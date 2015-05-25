//
//  Common_define.h
//  HKC
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用宏定义

/***common**/
#import "AppDelegate.h"
#import "Common_font.h"
#import "Common_color.h"
#import "Common_Markwords.h"
#import "Common_time.h"
#import "Common_limit.h"

/***类别***/
#import "NSString+Regex.h"
#import "NSString+MyString.h"
#import "iToast+myToast.h"
#import "UIImageView+WebCache.h"
#import "NSDate+Category.h"
#import "UIImageView+WebCache.h"
#import "LKDB+Manager.h"
#import "UINavigationBar+Awesome.h"
#import "UIViewExt.h"

/***View***/
#import "iToast.h"
#import "SuperVC.h"
#import "SuperScrollVC.h"
#import "MJRefresh.h"
#import "WebViewController.h"
#import "BaseTableView.h"

/***Manager***/
#import "HUDManager.h"
#import "DataManager.h"
#import <IQKeyboardManager.h>

/***Util***/
#import "RegexKitLite.h"
#import "DataHelper.h"
#import "UIKitHelper.h"
#import "UIInitMethod.h"
#import "Util.h"
#import "iOSBlocks.h"
#import "SandboxFile.h"
#import "SSKeychain.h"
#import "MKNetworkOperation.h"
#import "TimeUtil.h"
#import "RSA.h"
#import "MicAssistant.h"

/***Model***/
#import "UserModel.h"
#import "StatusModel.h"

/***Configure***/
#import "NetConfigure.h"

#ifndef HKC_Common_define_h
#define HKC_Common_define_h

/********************** app环境 ****************************/
#pragma mark - app环境，0开发或1发布
    
// 是否是企业包 0=非企业包(com.365sji.PinMall) 1=企业包(com.365sji.EnterprisePinMall)
#define kIsEnterpriseBundle 0

#define isTrueEnvironment 0

#if isTrueEnvironment
#define kServerHost         [NetConfigure getPublicNetwork]
#else
#define kServerHost         [NetConfigure getDefaultNetwork]
#endif

/********************** 常用宏 ****************************/
#pragma mark - 常用宏

/// 判断无网络情况
#define GetNetworkStatusNotReachable ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable)

/// 当前版本号
#define GetCurrentVersion ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

/// 当前app delegate
#define GetAPPDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// block self
#define kSelf __weak typeof(self) mySelf = self
#define kSelfStrong __strong __typeof__(self) self = mySelf

#define kLocalizedString(key) NSLocalizedString(key, nil)

// url
#define URLWithString(str)  [NSURL URLWithString:str]

/// Height/Width
#define kScreenWidth        [UIScreen mainScreen].applicationFrame.size.width
#define kScreenHeight       [UIScreen mainScreen].applicationFrame.size.height
#define kAllHeight          ([UIScreen mainScreen].applicationFrame.size.height + 20.0)
#define kBodyHeight         ([UIScreen mainScreen].applicationFrame.size.height - 44.0)
#define kTabbarHeight       49
#define kSearchBarHeight    45
#define kStatusBarHeight    20
#define kNavigationHeight   44
/// 分类下拉框
#define kComboxListHeight kBodyHeight - kTabbarHeight - kComboxViewHeight- 88 //combox下拉框距tabbar上部88
#define kComboxViewHeight 75/2 //combox的高度

/// System判断
#define ISiPod      [[[UIDevice currentDevice] model] isEqual:@"iPod touch"]
#define ISiPhone    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISiPad      [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define ISiPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
// end

#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) // IOS7的系统
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) // IOS8的系统

#define UIInterfaceOrientationIsPortrait(orientation)  ((orientation) == UIInterfaceOrientationPortrait || (orientation) == UIInterfaceOrientationPortraitUpsideDown)
#define UIInterfaceOrientationIsLandscape(orientation) ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight)

#define INTERFACEPortrait self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
#define INTERFACELandscape self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight

// 方便写接口
#define ParamsDic dic
#define CreateParamsDic NSMutableDictionary *ParamsDic = [NSMutableDictionary dictionary]
#define DicObjectSet(obj,key) [ParamsDic setObject:obj forKey:key]
#define DicValueSet(value,key) [ParamsDic setValue:value forKey:key]


#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

// DataManager && UserModel
#define GetDataManager [DataManager sharedManager]
#define GetDataUserModel [[DataManager sharedManager] userModel]

/// 数值转字符串
#define kIntToString(intValue) ([NSString stringWithFormat:@"%@", @(intValue)])
#define StrToInt(str) [str integerValue]
#define StrToDouble(str) [str doubleValue]
#define DoubleStringFormat(str) [NSString stringWithFormat:@"%.2f", [str doubleValue]]

/********************** 数值 ****************************/


/********************** 标识 ****************************/

#pragma mark - 标识

#define IQKeyboardDistanceFromTextField 50

/********************** 图片 ****************************/

#pragma mark - 图片

/********************** ****************************/


#endif
