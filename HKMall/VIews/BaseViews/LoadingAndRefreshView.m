//
//  LoadingAndReflashView.m
//  HKMember
//
//  Created by hua on 14-4-9.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "LoadingAndRefreshView.h"

@implementation LoadingAndRefreshView{

    UILabel *_largeStr;        //大标题
    UILabel *_littleStr;       //小标题
    
    UILabel *_loadingStr;        //加载的文字
    UIActivityIndicatorView *_indicatorView; //加载指示器
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setReflashBlock:(void (^)(void))reflashBlock
{
    _reflashBlock = [reflashBlock copy];
}

-(void)initView{

    self.backgroundColor=UIColorRGB(240, 240, 240);
    
    _bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(121, 85, 78, 78)];
    _bgImageView.image=[UIImage imageNamed:@"notice_not_net"];
    [self addSubview:_bgImageView];
    
    _largeStr=[[UILabel alloc] initWithFrame:CGRectMake(0, _bgImageView.bottom+10, 320, 20)];
    _largeStr.textAlignment=NSTextAlignmentCenter;
    _largeStr.textColor=kColorLightgrayContent;
    _largeStr.font=kFontSize14;
    [self addSubview:_largeStr];
    
    _littleStr=[[UILabel alloc] initWithFrame:CGRectMake(0, _largeStr.bottom+10, 320, 20)];
    _littleStr.textAlignment=NSTextAlignmentCenter;
    _littleStr.textColor=kColorLightgrayContent;
    _littleStr.font=kFontSize12;
    [self addSubview:_littleStr];
    
    _refreshBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _refreshBtn.frame=CGRectMake(160-51.5, _littleStr.bottom+20, 103, 32);
    _refreshBtn.titleLabel.font=kFontSizeBold15;
    [_refreshBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_refreshBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_refreshBtn];
    
    
    _loadingStr=[[UILabel alloc] initWithFrame:CGRectMake(0, _bgImageView.bottom+15, 320, 20)];
    _loadingStr.textAlignment=NSTextAlignmentCenter;
    _loadingStr.font=kFontSize15;
    _loadingStr.textColor=kColorLightgrayContent;
    _loadingStr.text=@"";
    [self addSubview:_loadingStr];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.center = CGPointMake(kScreenWidth/2,220);
    [self addSubview:_indicatorView];

}

- (void)setLoadingState
{
    _bgImageView.hidden=YES;
    _largeStr.hidden=YES;
    _littleStr.hidden=YES;
    _refreshBtn.hidden=YES;
    
    _loadingStr.hidden = NO;
    _indicatorView.hidden = NO;
    [_indicatorView startAnimating];
    
}

- (void)setSuccessState{
    [self removeFromSuperview];

}

- (void)setFailedState
{
    _bgImageView.hidden=NO;
    _largeStr.hidden=NO;
    _littleStr.hidden=NO;
    _refreshBtn.hidden=NO;
    
    _loadingStr.hidden = YES;
    _indicatorView.hidden = YES;
    [_indicatorView stopAnimating];
    
    _bgImageView.frame = CGRectMake(101, 73, 137, 101);
    _bgImageView.image=[UIImage imageNamed:@"notice_not_net"];
    
    _littleStr.frame=CGRectMake(0, _bgImageView.bottom+42, 320, 20);
    _littleStr.text = @"哎呀！网络不给力啊亲";
    _littleStr.font=kFontSize16;
    
    [_refreshBtn setTitle:@"点击刷新" forState:UIControlStateNormal];
    UIImage *image=[[UIImage imageNamed:@"blueBtn"] stretchableImageWithLeftCapWidth:8 topCapHeight:6];
    [_refreshBtn setBackgroundImage:image forState:UIControlStateNormal];
    _refreshBtn.titleLabel.font = kFontSize16;
    _refreshBtn.frame=CGRectMake(160-72, _littleStr.bottom+14, 145, 44);
}

- (void)setBlankStateWithTitle:(NSString *)titleStr
{
    _bgImageView.hidden=NO;
    _largeStr.hidden=YES;
    _littleStr.hidden=NO;
    _refreshBtn.hidden=YES;
    
    _loadingStr.hidden = YES;
    _indicatorView.hidden = YES;
    [_indicatorView stopAnimating];
    
    _bgImageView.frame = CGRectMake(118, 170/2, 168/2, 148/2);
    _bgImageView.image=[UIImage imageNamed:@"notice_nodata"];
    
    _littleStr.frame=CGRectMake(0, _largeStr.top, 320, 20);
    
    if (titleStr!=nil) {
        _littleStr.text=titleStr;
    }
}

//刷新
-(void)refreshClick{

    [self setLoadingState];
    
    if (_reflashBlock) {
        _reflashBlock();
    }
    if (_delegate && [_delegate respondsToSelector:@selector(reflashClick)]) {
        [_delegate reflashClick];
    }
}

- (void)setBlankStateWithTitle:(NSString *)titleStr imageStr:(NSString *)imageStr
{
    _refreshBtn.hidden = YES;
    _loadingStr.hidden = YES;
    _largeStr.hidden = NO;
    
    UIImage *image;
    if ([NSString isNull:imageStr]) {
        image = [UIImage imageNamed:@"notice_nodata"];
    }else{
        image = [UIImage imageNamed:imageStr];
    }
    
    _bgImageView.image = image;
    _bgImageView.frame = CGRectMake((self.width - image.size.width)/2, 100, image.size.width, image.size.height);
    
    _largeStr.frame = CGRectMake(0, _bgImageView.bottom + 14, kScreenWidth, 20);
    if ([NSString isNull:titleStr]){
        _largeStr.text = @"暂无数据";
    }else{
        _largeStr.height = [DataHelper heightWithString:titleStr font:kFontSize14 constrainedToWidth:kScreenWidth];
        _largeStr.text = titleStr;
    }
}

@end
