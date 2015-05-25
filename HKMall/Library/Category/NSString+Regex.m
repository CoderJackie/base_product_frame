//
//  NSString+Regex.m
//  JHAPP
//
//  Created by wenjun on 13-6-7.
//  Copyright (c) 2013年 wenjun. All rights reserved.
//

#import "NSString+Regex.h"
#import "RegexKitLite.h"

@implementation NSString (Regex)

// 判断手机号
- (BOOL)isMobile
{
    return [self isMatchedByRegex:@"^(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])\\d{8}$"];
}

// 邮编
- (BOOL)isPostcode
{
    return [self isMatchedByRegex:@"[1-9]{1}(\\d+){5}"];
}

// mail
- (BOOL)isMail
{
    return [self isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
}

// 空格
- (BOOL)isContainSpace
{
    return [self isMatchedByRegex:@"\\s"];
}

// 电话
- (BOOL)isTel
{
    return [self isMatchedByRegex:@"^[^1]\\d{9,11}$"];
}

- (BOOL)isHXUserName
{
    if ([self isMatchedByRegex:@"^[0-9a-zA-Z]{4,12}$"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 字母/数字/特殊字符组成，8-16位,必须有字母数字
- (BOOL)isHxPassword
{
    NSString *rexStr = [NSString stringWithFormat:@"^%@{8,16}$", RegexRegisterPwdCharacter];
    if ([self isMatchedByRegex: rexStr])
    {
#if 0   // 必须同时包含数字字母
        if ([self isMatchedByRegex:@"\\d+"] && [self isMatchedByRegex:@"[a-zA-Z]+"]) {
            return YES;
        }
        return NO;
#else
        return YES;
#endif
    }
    else
    {
        return NO;
    }
}

-(BOOL)isHxBankCardNumber
{
    if ([self isMatchedByRegex:@"^[0-9]{12,19}$"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)isHxMoney
{
    if ([self isMatchedByRegex:@"^(([1-9]\\d{0,100})|0)(\\.\\d{1,2})?$"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 匹配身份证号码
-(BOOL)isHxIdentityCard
{
    // 判断位数
    if ([self length] != 15 && [self length] != 18)
    {
        return NO;
    }
    
    NSString *carid = self;
    long lSumQT  =0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if ([self length] == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince])
    {
        return NO;
    }
    // 判断年月日是否有效
    // 年份
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    // 月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    // 日
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil)
    {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if( 18 != strlen(PaperId)) return -1;
    // 校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    // 验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

-(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

// 是否是合法的密码组成字符
- (BOOL)isLegalHXPasswordCharacter
{
    if ([self isMatchedByRegex:@"[0-9a-zA-Z]"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 是否是合法的支付密码组成字符
- (BOOL)isLegalHXPayPasswordCharacter
{
    if ([self isMatchedByRegex:@"[0-9a-zA-Z]"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 是否是合法的帐号组成字符
- (BOOL)isLegalHXAccountCharacter
{
    if ([self isMatchedByRegex:@"[0-9a-z_.@]"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 合法身份证账号组成字符
- (BOOL)isLegalIDCardCharacter
{
    if ([self isMatchedByRegex:@"[0-9xX]"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// begin 张绍裕 20140625

/// 变更账户注册格式规则（数字+字母（大写自动转小写））
- (BOOL)isLegalHXAccountCharacterRegister
{
    if ([self isMatchedByRegex:@"[0-9a-zA-Z]"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/// 只输入数字 +字母 + _@.
- (BOOL)isLegalHKDemailCharacterRegister
{
    if ([self isMatchedByRegex:@"[0-9a-zA-Z_.@]"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isLegalCharacter:(NSString *)limitString
{
    return [self isMatchedByRegex:limitString];
}

@end
