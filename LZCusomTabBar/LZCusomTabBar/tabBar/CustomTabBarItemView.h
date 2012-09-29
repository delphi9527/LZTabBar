//
//  CustomTabBarItemView.h
//  LZCusomTabBar
//
//  Created by lin zheng on 9/27/12.
//  Copyright (c) 2012 yasofon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarItemView : UIView

@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UIImageView *badgeImageView;
@property (strong, nonatomic) UILabel *badgeLabel;
@property (strong, nonatomic) UIButton *badgeButton;
- (void)setBadgeCount:(int)count;
@end
