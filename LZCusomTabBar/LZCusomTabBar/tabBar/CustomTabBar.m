//
//  CostomTabBarView.m
//  NewTagged
//
//  Created by lin zheng on 5/14/12.
//  Copyright (c) 2012 D9527, Inc. All rights reserved.
//

#import "CustomTabBarItem.h"
#import "CustomTabBar.h"
#define kButtonTag 1001

@implementation CustomTabBar
@synthesize itemArray;
@synthesize bgImageView;
@synthesize delegate;
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (id)initRegularBarWithFrame:(CGRect)frame
          backgroundImageView:(UIImageView *)imgView
              backgroundColor:(UIColor *)color
                   itemHeight:(float)height
                    itemWidth:(float)width
                        items:(NSMutableArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = color;
        [self addSubview:imgView];
        self.itemArray = items;
        int itemCount = [self.itemArray count];
        float leftGap = .0;
        float topGap = .0;
        CGSize size = self.frame.size;
        if (width == 0) {
            width = size.width / itemCount;
        }
        else {
            leftGap = (size.width - itemCount * width) / 2;
        }

        if (height == 0) {
            height = size.height;
        }
        else {
            topGap = (size.height - height) / 2;
        }
        for (int index = 0; index< [itemArray count]; index++)
        {
            CustomTabBarItem *item = [itemArray objectAtIndex:index];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(leftGap + width * index, topGap, width, height);
            UILabel *label = [[UILabel alloc]initWithFrame:button.bounds];
            label.text = item.title;
            label.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
            label.textAlignment = UITextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            [button addSubview:label];
            button.tag = kButtonTag + index;
            UIImage *img = [UIImage imageNamed:item.unSelectedImgNameStr];
            button.imageView.image = img;
            [button setBackgroundImage:img forState:UIControlStateNormal];
            [button addTarget:self action:@selector(loadActivities:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];

        }
    }
    return self;
}

- (id)initIrigularWithFrame:(CGRect)frame
            backgroundImage:(UIImage *)image
            backgroundColor:(UIColor *)color
                      items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = color;
        if (self.bgImageView == nil) 
        {
            self.bgImageView = [[UIImageView alloc]initWithImage:image];
            self.bgImageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        }
        [self addSubview:bgImageView];
        self.itemArray = items;
        int itemCount = [self.itemArray count];
        float leftGap = .0;
        float topGap = .0;
        float totalWidth = .0;
        float totalHeight = .0;
        CGSize size = self.frame.size;
        for (int i = 0; i < [items count]; i++) {
            CustomTabBarItem *aItem = (CustomTabBarItem *)[items objectAtIndex:i];
            totalWidth = totalWidth + aItem.width;
            if (aItem.height > totalHeight) {
                //we store the maximal height of all the items
                totalHeight = aItem.height;
            }
        }

        if (totalWidth == .0 || totalWidth > size.width) {
            totalWidth = size.width;
            for (int i = 0; i < [items count]; i++) {
                CustomTabBarItem *aItem = (CustomTabBarItem *)[items objectAtIndex:i];
                aItem.width = size.width / itemCount;
            }

        }
        if (totalHeight == .0 || totalHeight > size.height) {
            // totalHeight = size.height;
            for (int i = 0; i < [items count]; i++) {
                CustomTabBarItem *aItem = (CustomTabBarItem *)[items objectAtIndex:i];
                aItem.height = size.height;
            }
        }

        leftGap = (size.width - totalWidth) / 2;
        // topGap = (size.height - totalHeight) / 2;
        topGap = 0;
        float x = .0;
        for (int index = 0; index< [itemArray count]; index++)
        {
            CustomTabBarItem *item = [itemArray objectAtIndex:index];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(leftGap + x, topGap, item.width, item.height);
            x = x + item.width;
            button.tag = kButtonTag + index;
            UIImage *img = [UIImage imageNamed:item.unSelectedImgNameStr];
            button.imageView.image = img;
            [button setBackgroundImage:img forState:UIControlStateNormal];
            [button addTarget:self action:@selector(loadActivities:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignFirstResponder:) name:@"CustomTabBarResignNotificaition" object:nil];
}

- (void)resignFirstResponder:(NSNotification *) notification
{
    for (int i = 0; i< [itemArray count]; i++) {
        CustomTabBarItem *aItem = [itemArray objectAtIndex:i];
        int buttonTag = i + kButtonTag;
        UIButton *button = (UIButton *)[self viewWithTag:buttonTag];
        button.imageView.image = [UIImage imageNamed:aItem.unSelectedImgNameStr];
        [button setBackgroundImage:[UIImage imageNamed:aItem.unSelectedImgNameStr] forState:UIControlStateNormal];
    }
}

- (void)selectItemAtIndex:(int)index
{
    for (int i = 0; i< [itemArray count]; i++) {
        CustomTabBarItem *aItem = [itemArray objectAtIndex:i];
        int buttonTag = i + kButtonTag;
        UIButton *button = (UIButton *)[self viewWithTag:buttonTag];
        if (i == index)
        {
            button.imageView.image = [UIImage imageNamed:aItem.selectedImgNameStr];
            NSLog(@"contentMode : %d",button.imageView.contentMode);
            [button setBackgroundImage:[UIImage imageNamed:aItem.selectedImgNameStr] forState:UIControlStateNormal];
        }
        else {
            button.imageView.image = [UIImage imageNamed:aItem.unSelectedImgNameStr];
            [button setBackgroundImage:[UIImage imageNamed:aItem.unSelectedImgNameStr] forState:UIControlStateNormal];
        }
    }
    [delegate tabBar:self selectedAtIndex:index tabBarTag:self.tag];
}

- (void)loadActivities:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomTabBarResignNotificaition" object:nil userInfo:nil];
    UIButton *button = (UIButton *)sender;
    int selectedIndex = button.tag - kButtonTag;
    for (int index = 0; index< [itemArray count]; index++) {
        CustomTabBarItem *aItem = [itemArray objectAtIndex:index];
        if (index == selectedIndex)
        {
            button.imageView.image = [UIImage imageNamed:aItem.selectedImgNameStr];
            [button setBackgroundImage:[UIImage imageNamed:aItem.selectedImgNameStr] forState:UIControlStateNormal];
        }
        else {
            int buttonTag = index + kButtonTag;
            UIButton *otherButton = (UIButton *)[self viewWithTag:buttonTag];
            otherButton.imageView.image = [UIImage imageNamed:aItem.unSelectedImgNameStr];
            [otherButton setBackgroundImage:[UIImage imageNamed:aItem.unSelectedImgNameStr] forState:UIControlStateNormal];
        }
    }
    [delegate tabBar:self selectedAtIndex:selectedIndex tabBarTag:self.tag];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
