//
//  DataManager.h
//  YueDian
//
//  Created by xiao on 15/3/6.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface DataManager : NSObject

@property (nonatomic, copy) NSString *userName;//用户名
@property (nonatomic, copy) NSString *password;//密码
@property (nonatomic, copy) NSString *accountId;

@property (nonatomic, assign) BOOL isLogin;//登录状态
@property (nonatomic,copy) NSString *deviceToken;

@property (nonatomic, strong) UserModel *userModel;

@property (nonatomic, copy, readonly) NSString *userId;

@property (nonatomic, assign) UInt64 currentChatUserId;


+ (DataManager *)sharedManager;

@end
