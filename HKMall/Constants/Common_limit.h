//
//  Common_limit.h
//  HKC
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用限制

#ifndef HKC_Common_limit_h
#define HKC_Common_limit_h

/********************** limit ****************************/

#pragma mark - 输入限制

// 提示符时间长度
#define kHUDTime 2.5

///晒单列表最大加载数
#define kMaxShareListDataCount 50

///其他最大列表加载数（一元夺宝记录、最新揭晓、往期记录）
#define kMaxOtherListDataCount 90

/// 分页大小
#define kPageSize 10

// 分割线高度
#define kSeparatorlineHeight 0.5

/// 注册模块
#define kMax_AccountHX           32  // 惠信用户名:4-32 字母数字下划线构成 可以是邮箱 张绍裕 20140904
#define kMax_Account             20  // 用户名:4-20 字母数字下划线构成 可以是邮箱
#define kMax_Password            16  // 密码:8-16  字母数字构成
#define kMax_PayPassword         16  // 交易密码: 8-16位 字母和数字构成
#define kMax_NickName            10  // 昵称:最多20位字符
#define kMax_MessageValidateCode 6   // 验证码:6位
#define kMax_Signature           100 // 个性签名
#define kMax_Address             100 // 地址
#define kMax_Phone               11  // 手机号
#define kMax_Tel                 18  // 电话号
#define kMax_RecommendCode       8   //注册邀请码
#define kMax_IDCardNum           18 // 身份证号
#define kMax_RealName            20 // 真实姓名
#define kMax_Money               12 // 充值金额位数限制

/// 字符输入限制
#define NUMBERS     @"0123456789"
#define xX          @"xX"
#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define Special_Character  @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'"

#define SpecialCharacterAndNumber @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789"

#define AllCharacterAndNumber @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

/********************** limit ****************************/

// 正则限制
#define RegexExceptSpace @"\\S+" // 除了空格的其他字符
#define RegexNumber @"[0-9]"
#define RegexCharacter @"[a-zA-Z]"
#define RegexCharacterlower @"[a-z]"
#define RegexCharacteruper @"[A-Z]"
#define RegexNumberAndCharacter @"[0-9a-zA-Z]"
#define RegexNumberAndCharacterlower @"[0-9a-z_.@]"

// 限制登录的合法输入字符
#if kIsOpenPwdFormatCheck
#define RegexLoginAccCharacter @"[0-9a-z_]"  // 登录可输入字符
#else
#define RegexLoginAccCharacter RegexExceptSpace
#endif

// 限制登录密码/交易密码的合法输入字符
#if kIsOpenPwdFormatCheck
#define RegexLoginPwdCharacter @"[0-9a-zA-Z`~!@#\\$%\\^&\\*()_\\+-=\\[\\]{}\\|;:'\"<,>\\.\\?/]"
#else
#define RegexLoginPwdCharacter RegexExceptSpace
#endif

#define RegexRegisterPwdCharacter RegexLoginPwdCharacter

#endif
