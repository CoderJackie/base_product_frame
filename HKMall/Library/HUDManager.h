//
//  HUDManager.h
//  DemoHUD
//
//  Created by zhangshaoyu on 14-10-28.
//  Copyright (c) 2014年 ygsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

// 导入头文件
#import "MBProgressHUD.h"

// 设置协议
@interface HUDManager : NSObject <MBProgressHUDDelegate>

/**
 @author 杨旭, 14-11-26 11:11:37
 @brief  完善加载视图
 @param mode        加载模式
 @param target      加载视图被添加到该视图上, 如果target=nil,则被添加到window上
 @param autoHide    是否到时间自动隐藏
 @param timeDelay   加载视图持续时间，hide=YES才起作用
 @param autoEnabled 加载视图显示过程中是否允许操作
 @param aMessage    加载视图显示的文字信息
 */
+ (void)showHUD:(MBProgressHUDMode)mode onTarget:(UIView *)target hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL )autoEnabled message:(NSString *)aMessage;

/**
 @author 杨旭, 14-11-26 11:11:24
 @brief 显示默认模式的加载视图,添加到window,阻塞操作
 */
+ (void)showHUDWithMessage:(NSString *)aMessage;

/**
 @author 杨旭, 14-11-26 12:11:16
 @brief 显示默认模式的加载视图,添加到target,阻塞操作[阻塞页面不阻塞导航栏可用此方法设置]
 @param aMessage 加载视图显示的文字信息
 @param target   加载视图被添加到该视图上, 如果target=nil,则被添加到window上
 */
+ (void)showHUDWithMessage:(NSString *)aMessage onTarget:(UIView *)target;


/// 设置方法:此方法默认加载到window上
+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)autoEnabled message:(NSString *)aMessage;

/// 隐藏
+ (void)hiddenHUD;

@end
