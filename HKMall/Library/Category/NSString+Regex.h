//
//  NSString+Regex.h
//  JHAPP
//
//  Created by wenjun on 13-6-7.
//  Copyright (c) 2013年 wenjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

/// 判断手机号
- (BOOL)isMobile;

/// 邮编
- (BOOL)isPostcode;

/// mail
- (BOOL)isMail;

/// 空格
- (BOOL)isContainSpace;

/// 电话
- (BOOL)isTel;

/// 惠信用户名格式：数字，字母下划线组成(4～32位)
- (BOOL)isHXUserName;

/// 惠信密码：8～16位数字字母组成
- (BOOL)isHxPassword;

/// 银卡号 8~25位数字
-(BOOL)isHxBankCardNumber;

/// 提现金额非负数
-(BOOL)isHxMoney;

/// 匹配身份证号码
-(BOOL)isHxIdentityCard;

//// 特殊字符
//- (BOOL)isSpacialCharacter;

/// 是否是合法的密码组成字符
- (BOOL)isLegalHXPasswordCharacter;

/// 是否是合法的支付密码组成字符
- (BOOL)isLegalHXPayPasswordCharacter;

/// 是否是合法的帐号组成字符
- (BOOL)isLegalHXAccountCharacter;
// begin 张绍裕 20140625

/// 变更账户注册格式规则（数字+字母（大写自动转小写））
- (BOOL)isLegalHXAccountCharacterRegister;

/// 合法身份证账号组成字符
- (BOOL)isLegalIDCardCharacter;

// end

/// 只输入数字 +字母 + _@.
- (BOOL)isLegalHKDemailCharacterRegister;

// 输入时根据条件限制 张绍裕 20140913
- (BOOL)isLegalCharacter:(NSString *)limitString;


@end
