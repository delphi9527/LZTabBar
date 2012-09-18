//
//  CustomTabBarItem.h
//  NewTagged
//
//  Created by lin zheng on 5/14/12.
//  Copyright (c) 2012 D9527, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTabBarItem : NSObject
{
    NSString *unSelectedImgNameStr;
    NSString *selectedImgNameStr;
    NSString *title;
    int index;
    float width;
    float height;
}
@property (nonatomic,retain) NSString *unSelectedImgNameStr;
@property (nonatomic,retain) NSString *selectedImgNameStr;
@property (nonatomic,retain) NSString *title;
@property int index;
@property float width;
@property float height;
@end
