//
//  CustomTabBarItem.m
//  NewTagged
//
//  Created by lin zheng on 5/14/12.
//  Copyright (c) 2012 D9527, Inc. All rights reserved.
//

#import "CustomTabBarItem.h"

@implementation CustomTabBarItem
@synthesize selectedImgNameStr,unSelectedImgNameStr,title,index;
@synthesize width,height;
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithTitle:(NSString *)titleString
        selectedImageNameString:(NSString *)selected
        unselectedImageNameString:(NSString *)unselected
        atIndex:(int)aIndex
{
    self = [super init];
    if (self) {
        self.title = titleString;
        self.selectedImgNameStr = selected;
        self.unSelectedImgNameStr = unselected;
        self.index = aIndex;
    }
    return self;
}

- (void)dealloc
{

}

@end
