//
//  CustomTabBarItemView.m
//  LZCusomTabBar
//
//  Created by lin zheng on 9/27/12.
//  Copyright (c) 2012 yasofon. All rights reserved.
//

#import "CustomTabBarItemView.h"

@implementation CustomTabBarItemView
@synthesize button = _button;
@synthesize badgeImageView = _badgeImageView;
@synthesize badgeLabel = _badgeLabel;
@synthesize badgeButton = _badgeButton;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addSubview:_button];
    [self addSubview:_badgeImageView];
    [self addSubview:_badgeLabel];
    [_badgeLabel setFont:[UIFont systemFontOfSize:10]];
    [_badgeLabel setBackgroundColor:[UIColor clearColor]];
    [_badgeLabel setTextAlignment:UITextAlignmentLeft];

}

- (void)setBadgeCount:(int)count
{
    if (count <= 0) {
        _badgeImageView.hidden = YES;
        _badgeLabel.hidden = YES;
        _badgeLabel.text = @"";
        return;
    }else if(count < 100){
        _badgeImageView.hidden = NO;
        _badgeLabel.hidden = NO;
        _badgeLabel.text = [NSString stringWithFormat:@"%d",count];
    }else{
        _badgeImageView.hidden = NO;
        _badgeLabel.hidden = NO;
        _badgeLabel.text = @"99+";
    }
    
    UIFont *font = [UIFont systemFontOfSize:10];
    NSString *content = _badgeLabel.text;
    CGSize size = [content sizeWithFont:font];
    CGRect frame = _badgeImageView.frame;
    _badgeImageView.frame = CGRectMake(self.frame.size.width - size.width - 10, frame.origin.y, size.width + 10, size.height + 3);
    _badgeLabel.frame = CGRectMake(self.frame.size.width - size.width - 7, frame.origin.y, size.width, size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
