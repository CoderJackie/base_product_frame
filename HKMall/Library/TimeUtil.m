//
//  TimeUtil.m
//  wq
//
//  Created by berwin on 13-7-20.
//  Copyright (c) 2013年 Weqia. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil


+ (NSString*)getTimeStr:(long) createdAt
{
    // Calculate distance time string
    //
    NSString *timestamp;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "second ago" : "seconds ago"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "minute ago" : "minutes ago"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "hour ago" : "hours ago"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "day ago" : "days ago"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "week ago" : "weeks ago"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt]; 
        timestamp = [dateFormatter stringFromDate:date];
    }
    return timestamp;
}

+ (NSString*)getFullTimeStr:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSString * string=[NSString stringWithFormat:@"%04d-%02d-%02d %02d:%02d:%02d",[component year],[component month],[component day],[component hour],[component minute],[component second]];
    return string;
}

+ (NSString*)getMDStr:(long long)time
{
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSString * string=[NSString stringWithFormat:@"%ld月%ld日",(long)[component month],(long)[component day]];
    return string;
}

+(NSDateComponents*) getComponent:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    return component;
}

// begin 张绍裕 20140625 添加获取NSDateComponents实例方法

// 根据时间字符及其格式获取NSDateComponents实例
+ (NSDateComponents *)getDateComponentsWithTime:(NSString *)time formatter:(NSString *)format
{
    if (!time || 0 == time.length)
    {
        return nil;
    }
    
    // 时间字符转换date类型
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = format;
    NSDate *dateTime = [timeFormatter dateFromString:time];
    
    // date类型转换componets类型
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *component = [calendar components:unitFlags fromDate:dateTime];
    
    return component;
}

// end

+(NSString*) getTimeStrStyle1:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];

    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    int t_year=(int)[component year];
    
    NSString*string=nil;
    
    long long now=[today timeIntervalSince1970];
    
    long distance=(long)(now-time);
    if(distance<60)
        string=@"刚刚";
    else if(distance<60*60)
        string=[NSString stringWithFormat:@"%ld 分钟前",distance/60];
    else if(distance<60*60*24)
        string=[NSString stringWithFormat:@"%ld 小时前",distance/60/60];
    else if(distance<60*60*24*7)
        string=[NSString stringWithFormat:@"%ld 天前",distance/60/60/24];
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%d月%d日",month,day];
    else
        string=[NSString stringWithFormat:@"%d年%d月%d日",year,month,day];
    
    return string;   
    
}
+(NSString*) getTimeStrStyle2:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    int hour=(int)[component hour];
    int minute=(int)[component minute];
    int week=(int)[component week];
    int weekday=(int)[component weekday];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    int t_year=(int)[component year];
    int t_month=(int)[component month];
    int t_day=(int)[component day];
    int t_week=(int)[component week];
    
    NSString*string=nil;
    if(year==t_year&&month==t_month&&day==t_day)
    {
        if(hour<6&&hour>=0)
             string=[NSString stringWithFormat:@"凌晨 %d:%02d",hour,minute];
        else if(hour>=6&&hour<12)
            string=[NSString stringWithFormat:@"上午 %d:%02d",hour,minute];
        else if(hour>=12&&hour<18)
            string=[NSString stringWithFormat:@"下午 %d:%02d",hour-12,minute];
        else
            string=[NSString stringWithFormat:@"晚上 %d:%02d",hour-12,minute];
    }
    else if(year==t_year&&week==t_week)
    {
        NSString * daystr=nil;
        switch (weekday) {
            case 1:
                daystr=@"日";
                break;
            case 2:
                daystr=@"一";
                break;
            case 3:
                daystr=@"二";
                break;
            case 4:
                daystr=@"三";
                break;
            case 5:
                daystr=@"四";
                break;
            case 6:
                daystr=@"五";
                break;
            case 7:
                daystr=@"六";
                break;
        }
        string=[NSString stringWithFormat:@"周%@ %d:%02d",daystr,hour,minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%d月%d日",month,day];
    else
        string=[NSString stringWithFormat:@"%d年%d月%d日",year,month,day];
    
    return string;
}

+(NSString*) getTimeStrStyle3:(long long)time
{
    [NSTimeZone setDefaultTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    int hour=(int)[component hour];
    int minute=(int)[component minute];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    int t_year=(int)[component year];
    int t_month=(int)[component month];
    int t_day=(int)[component day];
    
    NSString*string=nil;
    if(year==t_year&&month==t_month&&day==t_day)
    {
        if(hour<6&&hour>=0)
            string=[NSString stringWithFormat:@"凌晨 %d:%02d",hour,minute];
        else if(hour>=6&&hour<12)
            string=[NSString stringWithFormat:@"上午 %d:%02d",hour,minute];
        else if(hour>=12&&hour<18)
            string=[NSString stringWithFormat:@"下午 %d:%02d",hour-12,minute];
        else
            string=[NSString stringWithFormat:@"晚上 %d:%02d",hour-12,minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%d-%d %d:%02d",month,day,hour,minute];
    else
        string=[NSString stringWithFormat:@"%02d-%d-%d %d:%02d",year%100,month,day,hour,minute];
    
    return string;
}

#pragma mark - dataFormat
+ (NSString*)getDate:(NSDate*)date withFormat:(NSString*)dataFormat{
    if (date == nil) {
        date = [[NSDate alloc] init];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dataFormat];
    NSString *theDate = [formatter stringFromDate:date];
    return theDate;
}

+ (NSDate*)getDateWithDateString:(NSString*)date dateFormat:(NSString*)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat dateFromString:date];
}

+ (NSString*)getDefaultDateFormat:(NSDate*)date{
    NSDate * today = [NSDate date];
    NSDate * refDate = date;
    
    NSString * todayString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:10];
    NSString * refDateString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:10];
    
    NSString * yearString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:4];
    NSString * refYearString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:4];
    
    if ([refDateString isEqualToString:todayString])
    {
        return [self getDate:date withFormat:kDateFormatTime];
    }else if([yearString isEqualToString:refYearString]){
        return [self getDate:date withFormat:kDateFormat_MdHms];
    }else{
        return [self getDate:date withFormat:kDateFormatDefault];
    }
}

+ (NSString*)getMessageDateFormat:(NSDate*)date{
    NSDate * today = [NSDate date];
    NSDate * refDate = date;
    
    NSString * todayString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:10];
    NSString * refDateString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:10];
    
    NSString * yearString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:4];
    NSString * refYearString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:4];
    
    if ([refDateString isEqualToString:todayString])
    {
        return [self getDate:date withFormat:kDateFormat_Hm];
    }else if([yearString isEqualToString:refYearString]){
        return [self getDate:date withFormat:kDateFormat_Md];
    }else{
        return [self getDate:date withFormat:kDateFormat_yyMd];
    }
}

+ (NSString*)getChatDateFormat:(NSDate*)date{
    //获取系统是24小时制或者12小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    //hasAMPM==TURE为12小时制，否则为24小时制
    if (hasAMPM) {
        return [self getTimeStrStyle3:date.timeIntervalSince1970];
    }else{
        NSDate * today = [NSDate date];
        NSDate * refDate = date;
        
        NSString * todayString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:10];
        NSString * refDateString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:10];
        
        NSString * yearString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:4];
        NSString * refYearString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:4];
        
        if ([refDateString isEqualToString:todayString])
        {
            return [self getDate:date withFormat:kDateFormat_Hm];
        }else if([yearString isEqualToString:refYearString]){
            return [self getDate:date withFormat:kDateFormat_MdHm];
        }else{
            return [self getDate:date withFormat:kDateFormat_yyMdHm];
        }
    }

}

+ (NSString*)getFriendsCircleDateFormat:(NSDate*)date{
    NSDate * today = [NSDate date];
    NSDate * refDate = date;
    
    NSString * todayString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:10];
    NSString * refDateString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:10];
    
    NSString * yearString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:4];
    NSString * refYearString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:4];
    
    if ([refDateString isEqualToString:todayString])
    {
        return @"今天";
    }else if([yearString isEqualToString:refYearString]){
        return [self getDate:date withFormat:kDateFormat_Md];
    }else{
        return [self getDate:date withFormat:kDateFormat_yyMd];
    }
}

+ (NSString*)getTimeStrStyle4:(NSDate *)date
{
    return [self getTimeStrStyle4:date today:nil];
}

+ (NSString*)getTimeStrStyle4:(NSDate *)date today:(NSDate*)today
{
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    int hour=(int)[component hour];
    int minute=(int)[component minute];
    int weekday=(int)[component weekday];
    
    today = today?today:[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    int t_year=(int)[component year];
    int t_month=(int)[component month];
    int t_day=(int)[component day];
    
    
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    
    NSString * todayString = [[self getDate:date withFormat:kDateFormatDefault] substringToIndex:10];
    NSString * refDateString = [[self getDate:yesterday withFormat:kDateFormatDefault] substringToIndex:10];
    
    NSString *noTimeStr = [self getDate:date withFormat:kDateFormat_yMd];
    NSDate *noTime = [self getDateWithDateString:noTimeStr dateFormat:kDateFormat_yMd];
    
    long long now=[today timeIntervalSince1970];
    long distance=(long)(now-[noTime timeIntervalSince1970]);
    
    
    NSString*string=[NSString stringWithFormat:@"%d:%02d",hour,minute];
    if(year==t_year&&month==t_month&&day==t_day){}
    else if([todayString isEqualToString:refDateString])
        string=[NSString stringWithFormat:@"昨天 %d:%02d",hour,minute];
    else if(distance<60*60*24*7)
    {
        NSString *daystr;
        switch (weekday) {
            case 1:
                daystr=@"日";
                break;
            case 2:
                daystr=@"一";
                break;
            case 3:
                daystr=@"二";
                break;
            case 4:
                daystr=@"三";
                break;
            case 5:
                daystr=@"四";
                break;
            case 6:
                daystr=@"五";
                break;
            case 7:
                daystr=@"六";
                break;
            default:
                break;
        }
        string=[NSString stringWithFormat:@"星期%@ %d:%02d",daystr,hour,minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%d-%d %d:%02d",month,day,hour,minute];
    else
        string=[NSString stringWithFormat:@"%02d-%d-%d %d:%02d",year%100,month,day,hour,minute];
    
    return string;
}

+ (NSString*)getTimeStrStyle5:(NSDate *)date
{
    return [self getTimeStrStyle4:date today:nil];
}

+ (NSString*)getTimeStrStyle5:(NSDate *)date today:(NSDate*)today
{
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    int hour=(int)[component hour];
    int minute=(int)[component minute];
    
    today = today?today:[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    int t_year=(int)[component year];
    int t_month=(int)[component month];
    int t_day=(int)[component day];
    
    
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    
    NSString * todayString = [[self getDate:date withFormat:kDateFormatDefault] substringToIndex:10];
    NSString * refDateString = [[self getDate:yesterday withFormat:kDateFormatDefault] substringToIndex:10];
    
    NSString*string=[NSString stringWithFormat:@"%d:%02d",hour,minute];
    if(year==t_year&&month==t_month&&day==t_day){}
    else if([todayString isEqualToString:refDateString])
        string=[NSString stringWithFormat:@"昨天"];
    else
        string=[NSString stringWithFormat:@"%02d-%02d-%02d",year%100,month,day];
    
    return string;
}

+ (NSMutableArray *)arrayWith:(NSDate *)date dayNum:(NSInteger)dayNum
{
    NSMutableArray *daysArray = [NSMutableArray arrayWithCapacity:dayNum];
    NSInteger year = [date year];
    NSInteger month = [date month];
    NSInteger day = [date day];
    
    //当前月一共多少天
    NSInteger totalDays = [TimeUtil howManyDaysInThisMonth:year month:month];
    
    //当前月还有多少天
    NSInteger leftDays = totalDays - day;
    
    if (leftDays >= dayNum) {
        for (NSUInteger i = 1; i <= dayNum; i++) {
            [daysArray addObject:[NSString stringWithFormat:@"%@月%@日", @(month), @(day + i)]];
        }
    } else {
        for (NSUInteger i = 1; i <= leftDays; i++) {
            [daysArray addObject:[NSString stringWithFormat:@"%@月%@日", @(month), @(day + i)]];
        }
        
        for (NSUInteger i = 1; i <= dayNum - leftDays; i++) {
            [daysArray addObject:[NSString stringWithFormat:@"%@月%@日", @(month + 1), @(i)]];
        }
    }

    
    return daysArray;
}

//计算某件中的某月有多少天
+ (NSInteger)howManyDaysInThisMonth:(NSInteger)year month:(NSInteger)imonth
{
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}

//时间格式：02-14 18:00
+ (NSString*)getMonthAndDayAndHourAndMiniteTimeStr:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSString * string=[NSString stringWithFormat:@"%02d-%02d %02d:%02d",[component month],[component day],[component hour],[component minute]];
    return string;
}


@end
