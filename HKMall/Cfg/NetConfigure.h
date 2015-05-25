//
//  NetConfigure.h
//  PinMall
//
//  Created by YangXu on 14/12/29.
//  Copyright (c) 2014年 365sji. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NetCfgType)
{
    NetCfgType_True, // 正式
    NetCfgType_Test  // 测试
};

@interface NetConfigure : NSObject

/// 获取当前网络环境设置
+ (NSString *)getDefaultNetwork;

/// 获取发布网络环境设置
+ (NSString *)getPublicNetwork;

/// 设置网络环境
+ (void)setNetCfgType:(NetCfgType)type;
/// 获取网络环境
+ (NSString *)getNetCfgType;

///获取测试环境地址
+ (NSString *)getTestNetwork;

// 测试环境数组
+ (NSArray *)getTestNetworkEnviroments;

+ (NSString *)getEnviro;

+ (void)setTestEnviro:(NSString *)enviro;


@end
