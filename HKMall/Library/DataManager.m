//
//  DataManager.m
//  YueDian
//
//  Created by xiao on 15/3/6.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import "DataManager.h"
#import "SSKeychain.h"
#import "IQUIWindow+Hierarchy.h"
#import "AppDelegate.h"

@implementation DataManager
+ (DataManager *)sharedManager
{
    static DataManager *sharedManager;
    if (sharedManager == nil) {
        @synchronized (self) {
            sharedManager = [[DataManager alloc] init];
            assert(sharedManager != nil);
        }
    }
    return sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
