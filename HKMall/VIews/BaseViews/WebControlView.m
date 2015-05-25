//
//  WebControlView.m
//  HKMember
//
//  Created by xiaohua on 14-8-13.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "WebControlView.h"

@implementation WebControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"webControlBg"]];
    
    _goBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _goBackBtn.frame=CGRectMake(20, 4, 16, 16);
    [_goBackBtn setBackgroundImage:[UIImage imageNamed:@"web_btn_back"] forState:UIControlStateNormal];
    [_goBackBtn setBackgroundImage:[UIImage imageNamed:@"web_btn_back_s"] forState:UIControlStateHighlighted];
//    [_goBackBtn setBackgroundColor:kColorBlack];
    [_goBackBtn addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goBackBtn];
    
    _goForwardBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _goForwardBtn.frame=CGRectMake(_goBackBtn.right+20, 4, 16, 16);
    [_goForwardBtn setBackgroundImage:[UIImage imageNamed:@"web_btn_forword"] forState:UIControlStateNormal];
    [_goForwardBtn setBackgroundImage:[UIImage imageNamed:@"web_btn_forword_s"] forState:UIControlStateHighlighted];
//    [_goForwardBtn setBackgroundColor:kColorBlue];
    [_goForwardBtn addTarget:self action:@selector(goForwardClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goForwardBtn];
    
    _refreshBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _refreshBtn.frame=CGRectMake(320-20-16, 4, 16, 16);
    [_refreshBtn setBackgroundImage:[UIImage imageNamed:@"web_btn_refresh"] forState:UIControlStateNormal];
    [_refreshBtn setBackgroundImage:[UIImage imageNamed:@"web_btn_refresh_s"] forState:UIControlStateHighlighted];
//    [_refreshBtn setBackgroundColor:kColorDarkGreen];
    [_refreshBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_refreshBtn];
//    _goBackBtn.enabled = NO;
//    _goForwardBtn.enabled = NO;
}

-(void)goBackClick
{
    if (_goBackBlock) {
        _goBackBlock();
    }
}

-(void)goForwardClick
{
    if (_goForwardBlock) {
        _goForwardBlock();
    }
}

-(void)refreshClick
{
    if (_refreshBlock) {
        _refreshBlock();
    }
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
