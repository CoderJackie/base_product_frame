//
//  CustomTabbarButton.m
//  PinMall
//
//  Created by YangXu on 15/2/28.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import "CustomTabbarButton.h"

@implementation CustomTabbarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 35)];
        _cusImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_cusImageView];
        
        _cusTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _cusImageView.bottom - 5, self.width, 13)];
        _cusTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_cusTitleLabel];
    }
    return self;
}




@end
