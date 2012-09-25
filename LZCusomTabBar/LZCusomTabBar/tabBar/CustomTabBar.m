//
//  CostomTabBarView.m
//  NewTagged
//
//  Created by lin zheng on 5/14/12.
//  Copyright (c) 2012 yasofon, Inc. All rights reserved.
//

#import "CustomTabBarItem.h"
#import "CustomTabBar.h"
#define kButtonBaseTag 1001

@interface CustomTabBar ()
@property (strong,nonatomic) NSArray *itemArray;
@property (strong,nonatomic) UIImageView *bgImageView;
@property (weak,nonatomic) id<TabBarDelegate> delegate;
- (void)tapItem:(id)sender;
@end

@implementation CustomTabBar

@synthesize itemArray = _itemArray;
@synthesize bgImageView = _bgImageView;
@synthesize delegate = _delegate;

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
        for (int index = 0; index< [_itemArray count]; index++)
        {
            CustomTabBarItem *item = [_itemArray objectAtIndex:index];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(leftGap + width * index, topGap, width, height);
            UILabel *label = [[UILabel alloc]initWithFrame:button.bounds];
            label.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
            label.textAlignment = UITextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            [button addSubview:label];
            button.tag = kButtonBaseTag + index;
            UIImage *img = [UIImage imageNamed:item.unSelectedImgStr];
            button.imageView.image = img;
            [button setBackgroundImage:img forState:UIControlStateNormal];
            [button addTarget:self action:@selector(tapItem:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];

        }
    }
    return self;
}

- (id)initIrigularBarWithFrame:(CGRect)frame
            backgroundImage:(UIImage *)image
            backgroundColor:(UIColor *)color
                      items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (color != nil) {
            self.backgroundColor = color;
        }
    
        if (image != nil) {
            self.bgImageView = [[UIImageView alloc]initWithImage:image];
            self.bgImageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(frame), CGRectGetHeight(frame));
            [self addSubview:_bgImageView];
        }
        
        if (items == nil || [items count] == 0){
            return self;
        }
        self.itemArray = items;
        
        float totalWidth = .0;
        float totalHeight = .0;
        
        for (id aItem in items) {
            if ([aItem isKindOfClass:[CustomTabBarItem class]] == NO) {
                return self;
            }
            CustomTabBarItem *aItem = (CustomTabBarItem *)aItem;
            totalWidth = totalWidth + aItem.width;
            if (aItem.height > totalHeight) {
                //we store the maximal height of all the items
                totalHeight = aItem.height;
            }
        }
        
        self.frame = CGRectMake(.0, .0, totalWidth, totalHeight);
        float originX = .0;
        float originY = .0;
        for (int index = 0; index< [_itemArray count]; index++)
        {
            CustomTabBarItem *item = [_itemArray objectAtIndex:index];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            originY = totalHeight - item.height;
            button.frame = CGRectMake(originX, originY, item.width, item.height);
            originX = originX + item.width;
            button.tag = kButtonBaseTag + index;
            UIImage *img = [UIImage imageNamed:item.unSelectedImgStr];
            button.imageView.image = img;
            [button setBackgroundImage:img forState:UIControlStateNormal];
            [button addTarget:self action:@selector(tapItem:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)resignFirstResponder:(NSNotification *) notification
{
    for (int i = 0; i< [_itemArray count]; i++) {
        CustomTabBarItem *aItem = [_itemArray objectAtIndex:i];
        int buttonTag = i + kButtonBaseTag;
        UIButton *button = (UIButton *)[self viewWithTag:buttonTag];
        button.imageView.image = [UIImage imageNamed:aItem.unSelectedImgStr];
        [button setBackgroundImage:[UIImage imageNamed:aItem.unSelectedImgStr] forState:UIControlStateNormal];
    }
}

- (void)tapItem:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int selectedIndex = button.tag - kButtonBaseTag;
    for (int index = 0; index < [_itemArray count]; index++) {
        CustomTabBarItem *aItem = [_itemArray objectAtIndex:index];
        if (index == selectedIndex)
        {
            button.imageView.image = [UIImage imageNamed:aItem.selectedImgStr];
            [button setBackgroundImage:[UIImage imageNamed:aItem.selectedImgStr] forState:UIControlStateNormal];
        }
        else {
            int buttonTag = index + kButtonBaseTag;
            UIButton *otherButton = (UIButton *)[self viewWithTag:buttonTag];
            otherButton.imageView.image = [UIImage imageNamed:aItem.unSelectedImgStr];
            [otherButton setBackgroundImage:[UIImage imageNamed:aItem.unSelectedImgStr] forState:UIControlStateNormal];
        }
    }
    [_delegate tabBar:self selectedAtIndex:selectedIndex];
}

- (void)setItemBadgeNum:(int)number atItemIndex:(int)index
{
    
}

@end
