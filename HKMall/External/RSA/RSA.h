//
//  RSA.h
//  HKMember
//
//  Created by 文俊 on 14-5-9.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSA : NSObject {
    SecKeyRef publicKey;
    SecCertificateRef certificate;
    SecPolicyRef policy;
    SecTrustRef trust;
    size_t maxPlainLen;
}
+ (id)shareInstance;
- (NSString *)encryptWithString:(NSString *)content;

@end