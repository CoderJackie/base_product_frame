//
//  CLTimerLabel.h
//  TimerDemo
//
//  Created by chenli on 14-7-8.
//  Copyright (c) 2014年 chenli. All rights reserved.
//


/*
 参考代码
 ===================================================================================
 CLTimerLabel *timerLb = [[CLTimerLabel alloc] initWithFrame:CGRectMake(50, 100, 200, 20)];
 
 timerLb.textColor = [UIColor redColor];
 //设置截止时间
 [timerLb setCutOffTime:[NSDate dateWithTimeInterval:600 sinceDate:[NSDate date]]];
 //设置服务器时间
 [timerLb setServerTime:  ];
 //开始倒计时
 [timerLb start];
 timerLb.countFinishedBlock = ^{
 NSLog(@"计时完成");
 };
 
 
 注意:在合适的地方释放定时器,使用方法 - (void)releaseTimer;
 ===================================================================================
 */


#import <UIKit/UIKit.h>

typedef void(^timerCountFinished) (void);
typedef void(^UpdateTimeBlock) (NSString *timeStr);

typedef void(^TimeIsZeroBlock)(BOOL timeIsZeroFlag);

@interface CLTimerLabel : UILabel
{
    NSTimer *_timer;
    NSDate *_cutOffTime;      // 截止时间
    NSDate *_serverTime;      // 服务器时间
    NSDate *_temporaryTime;   // 计算时间的时候的临时时间
}

@property (nonatomic, strong) NSTimer *timer;

/// 设置截止日期
@property (nonatomic, strong) NSDate *cutOffTime;

/// 设置服务器时间
@property (nonatomic, strong) NSDate *serverTime;

@property (nonatomic, strong) NSDate *temporaryTime;

/// 时间条前缀文字
@property (nonatomic, strong) NSString *prefixStr;

/// 倒计时结束语
@property (nonatomic, strong) NSString *timerEndStr;

/// 时间显示格式
@property (nonatomic, strong) NSString *timeType;

/// 倒计时结束后执行block, 可以不设置
@property (nonatomic, copy) timerCountFinished countFinishedBlock;
@property (nonatomic, copy) UpdateTimeBlock updateTimeBlock;

@property (nonatomic,copy)TimeIsZeroBlock timeIsZeroBlock;

/// 开始倒计时
- (void)start;

/// 释放定时器
- (void)releaseTimer;

@end
