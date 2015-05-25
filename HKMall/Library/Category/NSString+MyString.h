//
//  NSString+MyString.h
//  HuiXin
//
//  Created by apple on 13-12-11.
//  Copyright (c) 2013年 惠卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyString)

+ (NSString *)stringBySpaceTrim:(NSString *)string;
//替换@为#
- (NSString *)replacingAtWithOctothorpe;
- (NSString *)replacingOctothorpeWithAt;
- (NSString *)replacingEnterWithNull;

+ (BOOL)containsChinese:(NSString *)string;
+ (NSString*)stringByNull:(NSString*)string;
+ (BOOL)isNull:(NSString *)string;
+ (BOOL)isEmptyAfterSpaceTrim:(NSString *)string;

-(BOOL)isBlank;

+ (BOOL)isPureInt:(NSString*)string;//判断是否纯数字

+ (BOOL)isPureFloat:(NSString*)string;//判断浮点型

// begin 张绍裕 20140627

// 过滤html的所有标志(图片等也被过滤) NSScanner过滤html
+ (NSString *)getClearHtmlString:(NSString *)htmlString clearSpace:(BOOL)clear;

// end

//手机号添加空格
+ (NSString *)addBlank:(NSString *)phone;

// begin 字符输入正则限制 张绍裕 20141017

/// 字符输入正则限制
+ (BOOL)isTrueValue:(NSString *)value withRegex:(NSString *)regex;

// end

//将数字前面加0
/*
 *numString   :   传入数字，需要先转成string
 *len         :   需要数字的长度
 */
+ (NSString *)addZero:(NSString *)numString len:(NSInteger)len;

@end
