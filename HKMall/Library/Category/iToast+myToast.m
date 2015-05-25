//
//  iToast+myToast.m
//  HKMember
//
//  Created by 文俊 on 14-4-26.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "iToast+myToast.h"

static iToast *staticIToast; // 定义表态变量 张绍裕 20140701

@implementation iToast (myToast)

// begin 张绍裕 20140701 修改实例化方法

/*
+ (iToast *)alertWithTitle:(NSString *)title
{
    iToast *toast = [iToast makeText:title ];
//    if ([DataManager sharedManager].keyboardIsVisible) {
//        [toast setGravity:iToastGravityTop];
//    }else{
//        [toast setGravity:iToastGravityCenter];
//    }
    [iToastSettings getSharedSettings].postition = CGPointMake(kScreenWidth, 120);
    [toast setGravity:iToastGravityTop
           offsetLeft:0
            offsetTop:120];
	[toast show];
	return toast;
}

+ (iToast *)alertWithTitleCenter:(NSString *)title
{
    iToast *toast = [iToast makeText:title ];
    [iToastSettings getSharedSettings].postition = CGPointMake(kScreenWidth, 120);
    [toast setGravity:iToastGravityCenter
           offsetLeft:0
            offsetTop:120];
	[toast show];
	return toast;

   
}
*/

// 实例化iToast
+ (iToast *)alertWithTitle:(NSString *)title
{
    if ([NSString isNull:title]) {
        return nil;
    }
    staticIToast = [iToast makeText:title ];
    [iToastSettings getSharedSettings].postition = CGPointMake(kScreenWidth, 120);
    [staticIToast setGravity:iToastGravityTop
           offsetLeft:0
            offsetTop:120];
	[staticIToast show];
	return staticIToast;
}

+ (iToast *)alertWithTitleCenter:(NSString *)title
{
    if ([NSString isNull:title]) {
        return nil;
    }
    staticIToast = [iToast makeText:title ];
    [iToastSettings getSharedSettings].postition = CGPointMake(kScreenWidth, 120);
    [staticIToast setGravity:iToastGravityCenter
           offsetLeft:0
            offsetTop:120];
	[staticIToast show];
	return staticIToast;
    
    
}

//显示iToast自定义位置和时间
+ (iToast *)alertWithTitle:(NSString *)title gravity:(iToastGravity)gravity duration:(NSInteger)duration
{
    if ([NSString isNull:title]) {
        return nil;
    }
    staticIToast = [iToast makeText:title ];
    [iToastSettings getSharedSettings].postition = CGPointMake(kScreenWidth, 120);
    [staticIToast setGravity:gravity
                  offsetLeft:0
                   offsetTop:120];
    [staticIToast setDuration:duration];
	[staticIToast show];
	return staticIToast;
}

@end
