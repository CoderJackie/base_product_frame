//
//  TimeUtil.h
//  wq
//
//  Created by berwin on 13-7-20.
//  Copyright (c) 2013年 Weqia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject

+ (NSString*)getTimeStr:(long) createdAt;

+ (NSString*)getFullTimeStr:(long long)time;

+ (NSString*)getMDStr:(long long)time;

+(NSDateComponents*) getComponent:(long long)time;

// begin 张绍裕 20140625 添加获取NSDateComponents实例方法

/// 根据时间字符及其格式获取NSDateComponents实例
+ (NSDateComponents *)getDateComponentsWithTime:(NSString *)time formatter:(NSString *)format;

// end

+(NSString*) getTimeStrStyle1:(long long)time;

+(NSString*) getTimeStrStyle2:(long long)time;

+(NSString*) getTimeStrStyle3:(long long)time;

//dataFormat
+ (NSString*)getDate:(NSDate*)date withFormat:(NSString*)dataFormat;
+ (NSDate*)getDateWithDateString:(NSString*)date dateFormat:(NSString*)format;
//默认格式时间，聊天用
+ (NSString*)getDefaultDateFormat:(NSDate*)date;
//获取消息列表时间格式
+ (NSString*)getMessageDateFormat:(NSDate*)date;
//聊天时间格式
+ (NSString*)getChatDateFormat:(NSDate*)date;
//获取朋友圈时间格式
+ (NSString*)getFriendsCircleDateFormat:(NSDate*)date;
//
+ (NSString*)getTimeStrStyle4:(NSDate *)date;

+ (NSString*)getTimeStrStyle4:(NSDate *)date today:(NSDate*)today;

+ (NSString*)getTimeStrStyle5:(NSDate *)date;
+ (NSString*)getTimeStrStyle5:(NSDate *)date today:(NSDate*)today;

//时间格式：02-14 18:00
+ (NSString*)getMonthAndDayAndHourAndMiniteTimeStr:(long long)time;

//计算某件中的某月有多少天
+ (NSInteger)howManyDaysInThisMonth:(NSInteger)year month:(NSInteger)imonth;

///有bug，暂不要在其他地方使用
+ (NSMutableArray *)arrayWith:(NSDate *)date dayNum:(NSInteger)dayNum;
@end
