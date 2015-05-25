//
//  ReachbilityUtil.h
//  HKMerchant
//
//  Created by apple on 14-6-4.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReachbilityUtil : NSObject

+ (id)sharedInstance;

// Wi-Fi是否可用
+ (BOOL)isEnableWiFi;

// 3G是否可用
+ (BOOL)isEnable3G;

// 启动监听
- (void)startObserve;

// 网络是否能够连接
- (BOOL)isConnectable;

// 是否是Wi-Fi连接
- (BOOL)isWiFi;

// 是否通过3g/gprs网络
- (BOOL)is3G;

@end
