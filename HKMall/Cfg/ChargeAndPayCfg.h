//
//  ChargeAndPayCfg.h
//  PinMall
//
//  Created by YangXu on 14/12/6.
//  Copyright (c) 2014年 365sji. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 支付／充值方式 **/

// 支付平台
typedef NS_ENUM(NSInteger, PayPlatform) {
    PayPlatform_UnionPay = 1,  // 银联
    PayPlatform_LLPay,         // 连连支付
    PayPlatform_WangYinPay     // 网银支付
};

// 充值平台
typedef NS_ENUM(NSInteger, ChargePlatform)
{
    ChargePlatform_UnionPay = 1,     // 银联
    ChargePlatform_LLPay,            // 连连充值
    ChargePlatform_WangYinPay           // 网银充值
};

// 支付类型
typedef NS_ENUM(NSInteger, PayType)
{
    PayType_Balance = 1 << 0, //余额
    PayType_ThirdPlatformPay = 1 << 1, // 三方平台支付
    PayType_PinBaoBean = 1 << 2 // 拼宝豆支付
};

// 充值类型
typedef NS_ENUM(NSInteger, ChargeType)
{
    ChargeType_Balance = 1, // 余额
    ChargeType_DiYongJin = 2 // 拼宝豆
};

@interface ChargeAndPayCfg : NSObject

+ (NSArray *)payPlatformArray;
+ (PayPlatform)payPlatformTypeWithIndex:(NSInteger)index;
+ (NSString *)payPlatformTitleWithIndex:(NSInteger)index;
+ (NSString *)payPlatformLogWithIndex:(NSInteger)index;

+ (NSArray *)chargePlatformArray;
+ (ChargePlatform)chargePlatformTypeWithIndex:(NSInteger)index;
+ (NSString *)chargePlatformTitleWithIndex:(NSInteger)index;
+ (NSString *)chargePlatformLogWithIndex:(NSInteger)index;


@end
