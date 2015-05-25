//
//  APIKey.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#ifndef SearchV3Demo_APIKey_h
#define SearchV3Demo_APIKey_h

/* 使用高德SearchV3, 请首先注册APIKey, 注册APIKey请参考 http://api.amap.com
 */
#if kIsEnterpriseBundle
const static NSString *APIKey = @"1662acbd6a70064b7a38d0319fa9b1c8";
#else
const static NSString *APIKey = @"703a29cb5d62d95bdf9b9552e7192643";
#endif

//const static NSString *APIKey = @"cf132bcc2f36d1dab197d0d8d2a51e95";

#endif
