//
//  CLTimerLabel.m
//  TimerDemo
//
//  Created by chenli on 14-7-8.
//  Copyright (c) 2014年 chenli. All rights reserved.
//

#import "CLTimerLabel.h"

@implementation CLTimerLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)releaseTimer
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)setCutOffTime:(NSDate *)cutOffTime
{
    _cutOffTime = cutOffTime;
    [self updateLabel:nil];
}

- (void)setServerTime:(NSDate *)serverTime
{
//    DLog(@"serverTime:%@",serverTime);
    _serverTime = serverTime;
//    DLog(@"_serverTime:%@",_serverTime);
    _temporaryTime = serverTime;
    [self updateLabel:nil];
}

- (void)start
{
    if (!_timer)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateLabel:)
                                                    userInfo:nil
                                                     repeats:YES] ;
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
        });
    }
}

- (void)updateLabel:(NSTimer *)timer
{
    // 目标时间
    NSDate *fireDate = _cutOffTime;
    // 当前时间
    _temporaryTime = _temporaryTime ? _temporaryTime : [NSDate date];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    // 计算时间差
    NSDateComponents *d = [calendar components:unitFlags fromDate:_temporaryTime toDate:fireDate options:0];
    NSUInteger day = [d day];
    NSUInteger hour = [d hour];
    NSUInteger minute = [d minute];
    NSUInteger second = [d second];
    
    if(day != 0){
        self.text = [NSString stringWithFormat:@"剩%ld天", day];
    }else if(hour != 0){
        self.text = [NSString stringWithFormat:@"剩%ld小时", hour];
    }else if(minute != 0){
        self.text = [NSString stringWithFormat:@"剩%ld分钟", minute];
    }else{
        self.text = [NSString stringWithFormat:@"剩%ld秒", second];
    }
    
    NSString *str = self.text;
    if (self.updateTimeBlock)
    {
        self.updateTimeBlock(str);
    }

    _temporaryTime = [_temporaryTime dateByAddingTimeInterval:1.0f];
    
    if (![d day] && ![d hour] && ![d minute] && ![d second])
    {
        [timer invalidate];
        // 结束后执行block
        if (self.countFinishedBlock)
        {
            self.countFinishedBlock();
        }
    }
}

@end
