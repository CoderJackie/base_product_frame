//
//  NetworkStatusNotifier.h
//  YueDian
//
//  Created by hm on 15/3/26.
//  Copyright (c) 2015年 惠卡世纪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface NetworkStatusNotifier : Reachability
{
    SCNetworkReachabilityRef reachabilityRef;
}

// 打开网络实时监听
- (BOOL)startRealTimeNotifier;

// 关闭网络实时监听
- (void)stopRealTimeNotifier;

+ (NetworkStatusNotifier*) reachabilityWithHostName: (NSString*) hostName;


+ (NetworkStatusNotifier*) reachabilityForInternetConnection;


+ (NetworkStatusNotifier*) reachabilityWithAddress: (const struct sockaddr_in*) hostAddress;

@end
