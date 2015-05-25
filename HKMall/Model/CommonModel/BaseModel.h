//
//  BaseModel.h
//
//  QQ:275080225
//  Created by wen jun on 12-10-13.
//  Copyright (c) 2013年 Wen Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JTObjectMapping.h"
#import "MKNetworkEngine.h"
#import "LKDBHelper.h"

typedef NS_ENUM(NSUInteger, NetworkHUD) {
    NetworkHUDBackground=0,         // 不锁屏，不提示
    NetworkHUDMsg=1,                // 不锁屏，只要msg不为空就提示
    NetworkHUDError=2,              // 不锁屏，提示错误信息
    NetworkHUDLockScreen=3,         // 锁屏
    NetworkHUDLockScreenAndMsg=4,   // 锁屏，只要msg不为空就提示
    NetworkHUDLockScreenAndError=5, // 锁屏，提示错误信息
    NetworkHUDLockScreenButNavWithMsg=6,  // 锁屏, 但是导航栏可以操作, 只要msg不为空就提示
    NetworkHUDLockScreenButNavWithError=7 // 锁屏, 但是导航栏可以操作, 提示错误信息
};

@class StatusModel;

@interface BaseModel : NSObject

#pragma mark - DB

/// 登录帐号的数据库
+ (LKDBHelper *)getUserLKDBHelper;

/// 默认的数据库 子类可以重写，默认已经登录用登录帐号数据库，没有则默认数据库
+ (LKDBHelper *)getUsingLKDBHelper;

/// 跟用户无关的数据库
+(LKDBHelper *)getDefaultLKDBHelper;

#pragma mark - map

/// 获取映射表 子类重写
+ (NSMutableDictionary *)getMapping;

/// 映射方法 字典对象
+ (StatusModel*)statusModelFromJSONObject:(id<JTValidJSONResponse>)object;

/// 映射方法 字典对象，rs对应的是哪个类
+ (StatusModel*)statusModelFromJSONObject:(id<JTValidJSONResponse>)object class:(Class)aClass;

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key;
+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key mapping:(NSMutableDictionary *)mapping;

// begin yangxu
// model更新 子类重写
- (void)update;
// end

#pragma mark - handle network data

/**
 *  上传文件
 *  @param path                相对路径
 *  @param params              参数
 *  @param filePaths           文件路径数组
 *  @param completionBlock     完成Block
 *  @param uploadProgressBlock 完成进度
 *  @return 操作对象
 */
+ (MKNetworkOperation*)uploadDocumentFromPath:(NSString *)path
                                       params:(NSMutableDictionary *)params
                                    filePaths:(NSMutableDictionary*)filePaths
                                 onCompletion:(void (^)(id data))completionBlock
                             onUploadProgress:(MKNKProgressBlock)uploadProgressBlock;

// begin 上传文件，返回信息包含请求头 张绍裕 20150207

// 上传文件
+ (MKNetworkOperation *)uploadFileFromPath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                                 filePaths:(NSMutableDictionary*)filePaths
                              onCompletion:(void (^)(id data, NSDictionary *dict))completionBlock
                          onUploadProgress:(MKNKProgressBlock)uploadProgressBlock;

// end

/**
 *  下载文件
 *  @param path                  绝对URL
 *  @param params                参数
 *  @param filePath              下载到哪个目录
 *  @param completionBlock       完成Block
 *  @param downloadProgressBlock 完成进度
 *  @return 操作对象
 */
+ (MKNetworkOperation*)downloadDocumentFromPath:(NSString *)path
                                         params:(NSMutableDictionary *)params
                                       filePath:(NSString *)filePath
                                   onCompletion:(void (^)(id data))completionBlock
                               onUploadProgress:(MKNKProgressBlock)downloadProgressBlock;

/**
 *  post请求 NetworkHUD = NetworkHUDLockScreenAndMsg
 *  @param path            相对路径
 *  @param params          参数
 *  @param completionBlock 完成Block
 *  @return 操作对象
 */
+ (MKNetworkOperation*)postDataResponsePath:(NSString *)path
                                     params:(NSMutableDictionary *)params
                               onCompletion:(void (^)(id data))completionBlock;

/**
 *  post请求 废弃
 *  @param path            相对路径
 *  @param params          参数
 *  @param isBackground    是否后台请求
 *  @param completionBlock 完成Block
 *  @return 操作对象
 */
+ (MKNetworkOperation*)postDataResponsePath:(NSString *)path
                                     params:(NSMutableDictionary *)params
                               isBackground:(BOOL)isBackground
                               onCompletion:(void (^)(id data))completionBlock;

/**
 *  post请求
 *  @param path            相对路径
 *  @param params          参数
 *  @param networkHUD      HUD状态
 *  @param completionBlock 完成Block
 *  @return 操作对象
 */
+ (MKNetworkOperation*)postDataResponsePath:(NSString *)path
                                     params:(NSMutableDictionary *)params
                                 networkHUD:(NetworkHUD)networkHUD
                               onCompletion:(void (^)(id data))completionBlock;

/**
 *  post请求
 *  @param path            相对路径
 *  @param params          参数
 *  @param networkHUD      HUD状态
 *  @param target          目标UIViewController，用于addNet:,返回按钮按下会断开网络请求
 *  @param completionBlock 完成Block
 *  @return 操作对象
 */
+ (MKNetworkOperation*)postDataResponsePath:(NSString *)path
                                     params:(NSMutableDictionary *)params
                                 networkHUD:(NetworkHUD)networkHUD
                                     target:(id)target
                               onCompletion:(void (^)(id data))completionBlock;

/**
 @author 杨旭, 14-12-01 14:12:55
 
 @brief  接口请求后直接解析回调
 @param path            相对路径
 @param params          参数
 @param networkHUD      HUD状态
 @param target          目标UIViewController，用于addNet:,返回按钮按下会断开网络请求
 @param success         请求成功之后的回调
 @return 操作对象
 */
+ (void)postDataResponsePath:(NSString *)path
                      params:(NSMutableDictionary *)params
                  networkHUD:(NetworkHUD)networkHUD
                      target:(id)target
                     success:(void (^)(id data))success;

/**
 *  显示HUD状态
 *  @param response   response字典对象
 *  @param networkHUD HUD状态
 */
+ (void)handleResponse:(NSDictionary *)response
            networkHUD:(NetworkHUD)networkHUD;


@end
