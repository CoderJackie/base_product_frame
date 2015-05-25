//
//  LoadingAndReflashView.h
//  HKMember
//
//  Created by hua on 14-4-9.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadingAndRefreshViewDelegate <NSObject>

//点击刷新
- (void)reflashClick;

@end

@interface LoadingAndRefreshView : UIView

@property(assign,nonatomic) BOOL isLoading;
@property(weak,  nonatomic) id<LoadingAndRefreshViewDelegate>delegate;
@property(copy, nonatomic) void (^reflashBlock) (void);

// add 卜增彦 2015.01.08
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton  *refreshBtn;     //刷新按钮

- (void)setLoadingState;
- (void)setSuccessState;
- (void)setFailedState;
- (void)setBlankStateWithTitle:(NSString *)titleStr;

// add 卜增彦 2015.01.07
- (void)setBlankStateWithTitle:(NSString *)titleStr imageStr:(NSString *)imageStr;

@end
