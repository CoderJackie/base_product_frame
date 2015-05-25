//
//  SuperVC.h
//  YueDian
//
//  Created by xiao on 15/3/5.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingAndRefreshView.h"
#import "MKNetworkOperation.h"

@interface SuperVC : UIViewController

@property (nonatomic, strong) NSMutableArray *networkOperations;

/// 设置导航栏样式
+ (void)setNavigationStyle:(UINavigationController *)nav;

/// 设置导航栏左按钮;
- (UIBarButtonItem *)barBackButton;

/// 设置导航栏右按钮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                     action:(SEL)action;

- (void)loginVerifySuccess:(void (^)())success;


//开始加载
-(void)loadingDataStart;
//加载成功
-(void)loadingDataSuccess;
//加载失败
-(void)loadingDataFail;
//没有内容
-(void)loadingDataBlank;
//没有内容，加标题
-(void)loadingDataBlankWithTitle:(NSString *)title;
//刷新代理方法
-(void)reflashClick;

//子类实现，登录成功后会回掉
- (void)updateLogin;

/**
 *  添加网络请求，backToSuperView执行后就会取消正在请求的网络
 *  @param net 网络操作
 */
- (void)addNet:(MKNetworkOperation *)net;

/**
 *  手动释放网络操作队列
 */
- (void)releaseNet;


/**
 *  隐藏导航栏
 */
- (void)hideNavigationBar:(BOOL)flag;
@end
