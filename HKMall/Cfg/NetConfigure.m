//
//  NetConfigure.m
//  PinMall
//
//  Created by YangXu on 14/12/29.
//  Copyright (c) 2014年 365sji. All rights reserved.
//

#import "NetConfigure.h"

static NSString *const keyNetwork = @"keyNetwork";

/// 真实环境
#define NetworkTrue @"interface.178pb.com"


/// 测试环境
#define NetworkTest   @"192.168.16.240:9002"  // 一元拼宝合并

#define NetworkTestEnviroments @[]


@implementation NetConfigure

/// 设置网络环境
+ (void)setNetCfgType:(NetCfgType)type
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (type == NetCfgType_True) {
        [userDefaults setObject:NetworkTrue forKey:keyNetwork];
    } else if (type == NetCfgType_Test) {
        [userDefaults setObject:NetworkTest forKey:keyNetwork];
    }
    [userDefaults synchronize];
}

+ (void)setTestEnviro:(NSString *)enviro
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:enviro forKey:keyNetwork];

    [userDefaults synchronize];
}

/// 获取网络环境
+ (NSString *)getNetCfgType
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *netStr = [userDefaults objectForKey:keyNetwork];
    if (nil == netStr) {
        [self setNetCfgType:NetCfgType_Test];
        return NetworkTest;
    }
    
    return netStr;
}

+ (NSString *)getEnviro
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *netStr = [userDefaults objectForKey:keyNetwork];
    if (nil == netStr) {
        [self setNetCfgType:NetCfgType_Test];
        return NetworkTest;
    }
    
    return netStr;
}

/// 获取当前网络环境设置
+ (NSString *)getDefaultNetwork
{
    // 根据设置返回
    return [self getNetCfgType];
}

/// 获取发布网络环境设置
+ (NSString *)getPublicNetwork
{
    return NetworkTrue;
}

///获取测试环境地址
+ (NSString *)getTestNetwork
{
    return NetworkTest;
}

+ (NSArray *)getTestNetworkEnviroments
{
    return NetworkTestEnviroments;
}

@end
