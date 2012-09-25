//
//  CustomTabBarView.h
//  NewTagged
//
//  Created by lin zheng on 5/14/12.
//  Copyright (c) 2012 yasofon, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBar;
@protocol TabBarDelegate <NSObject>
@optional
- (void)tabBar:(CustomTabBar *)tabBar
selectedAtIndex:(NSUInteger)index;

@end
@interface CustomTabBar : UIView
- (id)initRegularBarWithFrame:(CGRect)frame
          backgroundImageView:(UIImageView *)imgView
              backgroundColor:(UIColor *)color
                   itemHeight:(float)height
                    itemWidth:(float)width
                        items:(NSMutableArray *)items;

- (id)initIrigularBarWithFrame:(CGRect)frame
        backgroundImage:(UIImage *)image
            backgroundColor:(UIColor *)color
                      items:(NSArray *)items;

- (void)setItemBadgeNum:(int)number atItemIndex:(int)index;

@end



