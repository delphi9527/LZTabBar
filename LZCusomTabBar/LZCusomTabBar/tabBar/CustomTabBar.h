//
//  CustomTabBarView.h
//  NewTagged
//
//  Created by lin zheng on 5/14/12.
//  Copyright (c) 2012 D9527, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CustomTabBarResignNotificaition @"CustomTabBarResignNotificaition"
@class CustomTabBar;
@protocol TabBarDelegate <NSObject>
@optional
- (void)tabBar:(CustomTabBar *)tabBar selectedAtIndex:(NSUInteger)index tabBarTag:(int)tabTag;
@end
@interface CustomTabBar : UIView

@property (nonatomic,strong) NSArray *itemArray;
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,weak) id<TabBarDelegate> delegate;

- (id)initRegularBarWithFrame:(CGRect)frame
          backgroundImageView:(UIImageView *)imgView
              backgroundColor:(UIColor *)color
                   itemHeight:(float)height
                    itemWidth:(float)width
                        items:(NSMutableArray *)items;

- (id)initIrigularWithFrame:(CGRect)frame
        backgroundImage:(UIImage *)image
            backgroundColor:(UIColor *)color
                      items:(NSArray *)items;
- (void)loadActivities:(id)sender;
- (void)selectItemAtIndex:(int)index;
- (void)registerNotification;
- (void)resignFirstResponder:(NSNotification *)notification;

@end



