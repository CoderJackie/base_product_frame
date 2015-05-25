//
//  AlipayConfigure.h
//  TWM
//
//  Created by YangXu on 14-10-8.
//  Copyright (c) 2014年 huika. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//


#ifndef TWM_AlipayConfigure_h
#define TWM_AlipayConfigure_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088411130864349"
//收款支付宝账号
#define SellerID @"2356904015@qq.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""

//商户私钥，自助生成 (pem->pkcs8)
#define PartnerPrivKey @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAOXBQIVlU3ji6upHs6Qmh+upBmK2kJ9j8UViV07jhql9SBJnnUg28evTKop02vGrtkd2P0pxxbyME6Pp3klFblxM6fzicg3Vx1hVZAxzTB2mE0hSjtQ5gNzPs0DHTCFFcfooXkK8TqpncEWamMJ4ISd9gi+PPhmDIgc7Y7q8yBuxAgMBAAECgYAnajbSa6adR3h7hp932rBYql+REbbP0Upz18IYo4nXi8mQdrwRxnNMPKbAp/ljmkykB9IlyEze4rz/0sAym7mpwr3D4yi3ZSvA7TG7h4d+LcmCvgRNjl2UUj4719aBNN56xDN+740VI6pFNFObt/A3itg9XswctA/t4ANckNnq0QJBAPlVvxcFtjoTOR6hL7OLRjmnEMcG2tyHsydLxGcyFndAOrLhaHnk24LM/Oi81C/uEV9R7oEDOd0RiaB29fpoP3UCQQDr5YPWBSj0o4VE3Qfv7vrHTcMFNiY/9ioMiGitjnClWkN2WNPn1b5kDEFfQTt1fXD9kH8xfUI81MRf8ibegb/NAkB3hZssthg8jqp6/FmZf9ISIPvx7F9OB97hn3hu35vVXnzE8zjZ9dMkSI+UIbC1qTG6t9PVFG7Qgm+u9FfFyeNhAkAKO7OjZifnrOxMF3aPrwNMABCUukugfLJIRuabmNFEKw1AJgxTQ092EZ4IXtEQgLeVGF6cK/3im6xFKUEMZ/6FAkBGzmn/jabnMfpvi/sCSGudlKrDb778tcxUAbQZX3zwUn1LoZBAc0k6fqxtPHZIlbGLuvEGi1Yi1kRxqGbDMe32"

//签名类型
#define SignType @"RSA"

//支付宝公钥
#define AlipayPubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

//应用scheme
#define URLScheme @"PinWaiMai"

//回调(异步通知商家支付信息)
#define NotifyURL @"http%3A%2F%2Fwaimai.365sji.com%2Fnotify_url_client.jsp"

#endif
