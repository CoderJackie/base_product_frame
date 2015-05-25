//
//  ChargeAndPayCfg.m
//  PinMall
//
//  Created by YangXu on 14/12/6.
//  Copyright (c) 2014年 365sji. All rights reserved.
//

#import "ChargeAndPayCfg.h"

@interface ChargeAndPayCfg ()
@property (nonatomic, strong) NSArray *payPlatFormArray;
@property (nonatomic, strong) NSArray *chargePlatFormArray;
@end

static NSString *const PlatKey = @"plat";
static NSString *const TitleKey = @"title";
static NSString *const LogKey = @"log";

@implementation ChargeAndPayCfg

+ (ChargeAndPayCfg *)sharedInstance
{
    static ChargeAndPayCfg *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance setPayPlatFormArray];
        [instance setChargePlatFormArray];
    });
    return instance;
}

- (void)setPayPlatFormArray
{
    
    /*
     @{PlatKey:[NSNumber numberWithInteger:PayPlatform_LLPay], TitleKey: @"连连支付", LogKey:@"LLPay"}
     @{PlatKey:[NSNumber numberWithInteger:PayPlatform_UnionPay], TitleKey: @"银联支付", LogKey:@"UnionPay"}
     @{PlatKey:[NSNumber numberWithInteger:PayPlatform_WangYinPay], TitleKey: @"网银支付", LogKey:@"WangYinPay"}
     */
    /*
    _payPlatFormArray = @[@{PlatKey:[NSNumber numberWithInteger:PayPlatform_WangYinPay], TitleKey: @"网银支付", LogKey:@"WangYinPay"},
                          @{PlatKey:[NSNumber numberWithInteger:PayPlatform_LLPay], TitleKey: @"连连支付", LogKey:@"LLPay"}];
    */
    
    _payPlatFormArray = @[@{PlatKey:[NSNumber numberWithInteger:PayPlatform_WangYinPay], TitleKey: @"网银支付", LogKey:@"WangYinPay"}];
}

- (void)setChargePlatFormArray
{
    /*
     @{PlatKey:[NSNumber numberWithInteger:ChargePlatform_LLPay], TitleKey: @"连连充值", LogKey:@"LLPay"}
     @{PlatKey:[NSNumber numberWithInteger:ChargePlatform_UnionPay], TitleKey: @"银联充值", LogKey:@"UnionPay"}
     @{PlatKey:[NSNumber numberWithInteger:ChargePlatform_WangYinPay], TitleKey: @"网银充值", LogKey:@"WangYinPay"}
     */
    
    _chargePlatFormArray = @[@{PlatKey:[NSNumber numberWithInteger:ChargePlatform_WangYinPay], TitleKey: @"网银充值", LogKey:@"WangYinPay"}];
}

+ (NSArray *)payPlatformArray
{
    return [[self sharedInstance] payPlatFormArray];
}

+ (PayPlatform)payPlatformTypeWithIndex:(NSInteger)index
{
    return [[[[ChargeAndPayCfg payPlatformArray] objectAtIndex:index] objectForKey:PlatKey] integerValue];
}

+ (NSString *)payPlatformTitleWithIndex:(NSInteger)index
{
    return [[[ChargeAndPayCfg payPlatformArray] objectAtIndex:index] objectForKey:TitleKey];
}

+ (NSString *)payPlatformLogWithIndex:(NSInteger)index
{
    return [[[ChargeAndPayCfg payPlatformArray] objectAtIndex:index] objectForKey:LogKey];
}

+ (NSArray *)chargePlatformArray
{
    return [[self sharedInstance] chargePlatFormArray];
}

+ (ChargePlatform)chargePlatformTypeWithIndex:(NSInteger)index
{
    return [[[[ChargeAndPayCfg chargePlatformArray] objectAtIndex:index] objectForKey:PlatKey] integerValue];
}

+ (NSString *)chargePlatformTitleWithIndex:(NSInteger)index
{
    return [[[ChargeAndPayCfg chargePlatformArray] objectAtIndex:index] objectForKey:TitleKey];
}

+ (NSString *)chargePlatformLogWithIndex:(NSInteger)index
{
    return [[[ChargeAndPayCfg chargePlatformArray] objectAtIndex:index] objectForKey:LogKey];
}

@end
