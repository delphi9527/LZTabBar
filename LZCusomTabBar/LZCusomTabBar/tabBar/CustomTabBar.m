//
//  CostomTabBarView.m
//  NewTagged
//
//  Created by lin zheng on 5/14/12.
//  Copyright (c) 2012 yasofon, Inc. All rights reserved.
//
#import "CustomTabBar.h"
#import "CustomTabBarItem.h"
#import "CustomTabBarItemView.h"
#define kViewBaseTag 1001

@interface CustomTabBar ()
@property (strong, nonatomic) NSArray *itemArray;
@property (strong, nonatomic) NSMutableArray *itemViews;
@property (strong, nonatomic) UIImageView *bgImageView;

- (void)tapItem:(id)sender;
@end

@implementation CustomTabBar

@synthesize itemArray = _itemArray;
@synthesize bgImageView = _bgImageView;
@synthesize delegate = _delegate;
@synthesize itemViews = _itemViews;

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
            CustomTabBarItemView *aView = [[CustomTabBarItemView alloc] init];
            aView.frame = CGRectMake(leftGap + width * index, topGap, width, height);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0.0, 0.0, width, height);
            UILabel *label = [[UILabel alloc]initWithFrame:button.bounds];
            label.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
            label.textAlignment = UITextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            [button addSubview:label];
            button.tag = kViewBaseTag + index;
            UIImage *img = [UIImage imageNamed:item.unSelectedImgStr];
            button.imageView.image = img;
            [button setBackgroundImage:img forState:UIControlStateNormal];
            [button addTarget:self action:@selector(tapItem:) forControlEvents:UIControlEventTouchUpInside];
            
            aView.button = button;
            
            UIButton *badgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [badgeButton setBackgroundImage:[UIImage imageNamed:@"red-badge.png"] forState:UIControlStateNormal];
            aView.badgeButton = badgeButton;
            
            aView.badgeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red-badge.png"]];
            aView.badgeImageView.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
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
        self.itemViews = [[NSMutableArray alloc] init];
        float totalWidth = .0;
        float totalHeight = .0;
        
        for (id aItem in _itemArray) {
            if ([aItem isKindOfClass:[CustomTabBarItem class]] == NO) {
                return self;
            }
            CustomTabBarItem *item = (CustomTabBarItem *)aItem;
            totalWidth = totalWidth + item.width;
            if (item.height > totalHeight) {
                //we store the maximal height of all the items
                totalHeight = item.height;
            }
        }
        if (totalHeight <= 0) {
            totalHeight = frame.size.height;
        }
        if (totalWidth <= 0) {
            totalWidth = frame.size.width;
        }
        
        float originX = .0;
        float originY = .0;
        for (int index = 0; index< [_itemArray count]; index++)
        {
            CustomTabBarItem *item = [_itemArray objectAtIndex:index];
            CustomTabBarItemView *aView = [[CustomTabBarItemView alloc] init];
            [_itemViews addObject:aView];
            originY = totalHeight - item.height;
            aView.frame = CGRectMake(originX, originY, item.width, item.height);
            originX = originX + item.width;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0.0, 0.0, item.width, item.height);

            UIImage *img = [UIImage imageNamed:item.unSelectedImgStr];
            button.imageView.image = img;
            [button setBackgroundImage:img forState:UIControlStateNormal];
            [button addTarget:self action:@selector(tapItem:) forControlEvents:UIControlEventTouchUpInside];
            aView.tag = kViewBaseTag + index;
            button.tag = aView.tag;
            aView.button = button;
            aView.badgeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red-badge.png"]];
            aView.badgeImageView.frame = CGRectMake(item.width - 20.0, 5.0, 20.0, 20.0);
            aView.badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(item.width - 20.0, 5.0, 20.0, 20.0)];
            [aView setBadgeCount:0];
            [self addSubview:aView];
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, totalWidth, totalHeight);
    }
    
    return self;
}

- (void)resignFirstResponder:(NSNotification *) notification
{
    for (int i = 0; i< [_itemArray count]; i++) {
        CustomTabBarItem *aItem = [_itemArray objectAtIndex:i];
        int buttonTag = i + kViewBaseTag;
        UIButton *button = (UIButton *)[self viewWithTag:buttonTag];
        button.imageView.image = [UIImage imageNamed:aItem.unSelectedImgStr];
        [button setBackgroundImage:[UIImage imageNamed:aItem.unSelectedImgStr] forState:UIControlStateNormal];
    }
}

- (void)tapItem:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int selectedIndex = button.tag - kViewBaseTag;
    [self selectItemAtIndex:selectedIndex];
}

- (void)selectItemAtIndex:(int)index
{
    for (int i = 0; i < [_itemArray count]; i++) {
        int viewTag = i + kViewBaseTag;
        CustomTabBarItemView *aView = (CustomTabBarItemView *)[self viewWithTag:viewTag];
        UIButton *button = aView.button;
        CustomTabBarItem *aItem = [_itemArray objectAtIndex:i];
        if (index == i) {
            button.imageView.image = [UIImage imageNamed:aItem.selectedImgStr];
            [button setBackgroundImage:[UIImage imageNamed:aItem.selectedImgStr] forState:UIControlStateNormal];
        }else {
            button.imageView.image = [UIImage imageNamed:aItem.unSelectedImgStr];
            [button setBackgroundImage:[UIImage imageNamed:aItem.unSelectedImgStr] forState:UIControlStateNormal];
        }
    }
    if (index >=0 && index < [_itemArray count]) {
      [_delegate tabBar:self selectedAtIndex:index];  
    }
}

- (void)setItemBadgeNum:(int)number atIndex:(int)index
{
    CustomTabBarItemView *aView = (CustomTabBarItemView *)[_itemViews objectAtIndex:index];
    [aView setBadgeCount:number];
}

@end
