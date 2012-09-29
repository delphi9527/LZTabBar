//
//  CustomTabBarItem.h
//  NewTagged
//
//  Created by lin zheng on 5/14/12.
//  Copyright (c) 2012 yasofon, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTabBarItem : NSObject
@property (strong,nonatomic) NSString *unSelectedImgStr;
@property (strong,nonatomic) NSString *selectedImgStr;
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (strong,nonatomic) NSString *badgeStr;
@end
