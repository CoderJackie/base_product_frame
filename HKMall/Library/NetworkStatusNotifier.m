//
//  NetworkStatusNotifier.m
//  YueDian
//
//  Created by hm on 15/3/26.
//  Copyright (c) 2015年 惠卡世纪. All rights reserved.
//

#import "NetworkStatusNotifier.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

@implementation NetworkStatusNotifier



// static修饰的函数只能被本文件里内容使用。
static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
    NetworkStatusNotifier* noteObject = (__bridge NetworkStatusNotifier*) info;
    // Post a notification to notify the client that the network reachability changed.
    [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification object: noteObject];
}


// 打开网络实时监听
- (BOOL)startRealTimeNotifier
{
    BOOL retVal = NO;
    SCNetworkReachabilityContext	context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    if(SCNetworkReachabilitySetCallback(reachabilityRef, ReachabilityCallback, &context))
    {
        if(SCNetworkReachabilityScheduleWithRunLoop(reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
        {
            retVal = YES;
        }
    }
    return retVal;
}

// 关闭网络实时监听
- (void)stopRealTimeNotifier
{
    if(reachabilityRef!= NULL)
    {
        SCNetworkReachabilityUnscheduleFromRunLoop(reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }

}

+ (NetworkStatusNotifier*) reachabilityWithHostName: (NSString*) hostName
{
    NetworkStatusNotifier* retVal = NULL;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    if(reachability!= NULL)
    {
        retVal= [[self alloc] init];
        if(retVal!= NULL)
        {
            retVal->reachabilityRef = reachability;
        }
    }
    return retVal;
}


+ (NetworkStatusNotifier*) reachabilityWithAddress: (const struct sockaddr_in*) hostAddress
{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)hostAddress);
    NetworkStatusNotifier* retVal = NULL;
    if(reachability!= NULL)
    {
        retVal= [[self alloc] init];
        if(retVal!= NULL)
        {
            retVal->reachabilityRef = reachability;
        }
    }
    return retVal;
}

+ (NetworkStatusNotifier*) reachabilityForInternetConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    return [self reachabilityWithAddress: &zeroAddress];
}

@end
