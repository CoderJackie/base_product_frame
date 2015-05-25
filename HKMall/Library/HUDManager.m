//
//  HUDManager.m
//  DemoHUD
//
//  Created by zhangshaoyu on 14-10-28.
//  Copyright (c) 2014年 ygsoft. All rights reserved.
//

#import "HUDManager.h"

// 导入头文件 用于显示指示器的背景视图
#import "AppDelegate.h"

// 定义变量
static MBProgressHUD *mbProgressHUD;

@implementation HUDManager

+ (void)showHUDWithMessage:(NSString *)aMessage
{
    [self showHUD:MBProgressHUDModeIndeterminate onTarget:nil hide:NO afterDelay:0 enabled:NO message:aMessage];
}

+ (void)showHUDWithMessage:(NSString *)aMessage onTarget:(UIView *)target
{
    [self showHUD:MBProgressHUDModeIndeterminate onTarget:target hide:NO afterDelay:0 enabled:NO message:aMessage];
}

+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)autoEnabled message:(NSString *)aMessage
{
    [self showHUD:mode onTarget:nil hide:autoHide afterDelay:timeDelay enabled:autoHide message:aMessage];
}

+ (void)showHUD:(MBProgressHUDMode)mode onTarget:(UIView *)target hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL )autoEnabled message:(NSString *)aMessage
{
    // 如果已存在，则从父视图移除
    if (mbProgressHUD.superview)
    {
        [mbProgressHUD removeFromSuperview];
        mbProgressHUD = nil;
    }
    
    if (target && [target isKindOfClass:[UIView class]]) {
        // 添加到目标视图
        mbProgressHUD = [MBProgressHUD showHUDAddedTo:target animated:YES];
    } else {
        // 创建显示视图
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        mbProgressHUD = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
    }
    
    // 设置显示模式
    [mbProgressHUD setMode:mode];
    
    // 如果是自定义图标模式，则显示
    if (mode == MBProgressHUDModeCustomView)
    {
        // 设置自定义图标
        UIImageView *customImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Custom_Image.png"]];
        [mbProgressHUD setCustomView:customImageView];
    }
    
    // 如果是填充模式
    if (mode == MBProgressHUDModeDeterminate || mode == MBProgressHUDModeAnnularDeterminate || mode == MBProgressHUDModeDeterminateHorizontalBar)
    {
        // 方法2
        [mbProgressHUD showWhileExecuting:@selector(showProgress) onTarget:self withObject:nil animated:YES];
    }
    
    // 设置标示标签
    [mbProgressHUD setLabelText:aMessage];
    
    // 设置显示类型 出现或消失
    [mbProgressHUD setAnimationType:MBProgressHUDAnimationZoomOut];
    
    // 显示
    [mbProgressHUD show:YES];
    
    // 加上这个属性才能在HUD还没隐藏的时候点击到别的view
    // 取反，即!autoEnabled
    [mbProgressHUD setUserInteractionEnabled:!autoEnabled];
    
    // 隐藏后从父视图移除
    [mbProgressHUD setRemoveFromSuperViewOnHide:YES];
    
    // 设置自动隐藏
    if (autoHide)
    {
        [mbProgressHUD hide:autoHide afterDelay:timeDelay];
    }
}

+ (void)hiddenHUD
{
    [mbProgressHUD hide:YES];
}

+ (void)showProgress
{
    float progress = 0.0f;
    while (progress < 1.0f)
    {
        progress += 0.05f;
        [mbProgressHUD setProgress:progress];
        usleep(50000);
    }
}

@end
