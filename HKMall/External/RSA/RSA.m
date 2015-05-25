//
//  RSA.m
//  HKMember
//
//  Created by 文俊 on 14-5-9.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "RSA.h"

@implementation RSA

+ (id)shareInstance{
    static RSA *_rsa = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _rsa = [[self alloc] init];
    });
    return _rsa;
}

- (id)init {
    self = [super init];
    
//    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"huixin"
//                                                              ofType:@"cert"];
//    if (publicKeyPath == nil) {
//        DLog(@"Can not find pub.der");
//        return nil;
//    }
//    
//    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
//    if (publicKeyFileContent == nil) {
//        DLog(@"Can not read from pub.der");
//        return nil;
//    }
    
//    NSString *cert = [publicKeyFileContent base64EncodedString];
//    DLog(@"%@",cert);
    NSString *cert = @"MIIBtjCCAWCgAwIBAgIQzI1/WDr/8apLcZc7wJTtBjANBgkqhkiG9w0BAQQFADAWMRQwEgYDVQQDEwtSb290IEFnZW5jeTAeFw0xNDA1MDkwMzU2NTJaFw0zOTEyMzEyMzU5NTlaMBExDzANBgNVBAMTBmh1aXhpbjCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAwVwBKuePO3ZZbZ//gqaNuUNyaPHbS3e2v5iDHMFRfYHS/bFw+79GwNUiJ+wXgpA7SSBRhKdLhTuxMvCn1aZNlXaMXIOPG1AouUMMfr6kEpFf/V0wLv6NCHGvBUK0l7O+2fxn3bR1SkHM1jWvLPMzSMBZLCOBPRRZ5FjHAy8d378CAwEAAaNLMEkwRwYDVR0BBEAwPoAQEuQJLQYdHU8AjWEh3BZkY6EYMBYxFDASBgNVBAMTC1Jvb3QgQWdlbmN5ghAGN2wAqgBkihHPuNSqXDX0MA0GCSqGSIb3DQEBBAUAA0EAFLejAoAaYB2VDuZGPDQk9fpnrw2+oGSIfFSMlI7Dq7CytwGD0qN+zRycuVSGNfMADB4yngf9LRXPYkE28D0TLg==";
    NSData *publicKeyFileContent = [NSData dataFromBase64String:cert];
    
    certificate = SecCertificateCreateWithData(kCFAllocatorDefault, ( __bridge CFDataRef)publicKeyFileContent);
    if (certificate == nil) {
        DLog(@"Can not read certificate from pub.der");
        return nil;
    }
    
    policy = SecPolicyCreateBasicX509();
    OSStatus returnCode = SecTrustCreateWithCertificates(certificate, policy, &trust);
    if (returnCode != 0) {
        DLog(@"SecTrustCreateWithCertificates fail. Error Code: %d", (int)returnCode);
        return nil;
    }
    
    SecTrustResultType trustResultType;
    returnCode = SecTrustEvaluate(trust, &trustResultType);
    if (returnCode != 0) {
        DLog(@"SecTrustEvaluate fail. Error Code: %d", (int)returnCode);
        return nil;
    }
    
    publicKey = SecTrustCopyPublicKey(trust);
    if (publicKey == nil) {
        DLog(@"SecTrustCopyPublicKey fail");
        return nil;
    }
    
    maxPlainLen = SecKeyGetBlockSize(publicKey) - 12;
    return self;
}

- (NSData *) encryptWithData:(NSData *)content {
    
    size_t plainLen = [content length];
    if (plainLen > maxPlainLen) {
        DLog(@"content(%ld) is too long, must < %ld", plainLen, maxPlainLen);
        return nil;
    }
    
    void *plain = malloc(plainLen);
    [content getBytes:plain
               length:plainLen];
    
    size_t cipherLen = 128; // 当前RSA的密钥长度是128字节
    void *cipher = malloc(cipherLen);
    
    OSStatus returnCode = SecKeyEncrypt(publicKey, kSecPaddingPKCS1, plain,
                                        plainLen, cipher, &cipherLen);
    
    NSData *result = nil;
    if (returnCode != 0) {
        DLog(@"SecKeyEncrypt fail. Error Code: %d", (int)returnCode);
    }
    else {
        result = [NSData dataWithBytes:cipher
                                length:cipherLen];
    }
    
    free(plain);
    free(cipher);
    
    return result;
}

- (NSString *) encryptWithString:(NSString *)content {
    return [[self encryptWithData:[content dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedString];
}

- (void)dealloc{
    CFRelease(certificate);
    CFRelease(trust);
    CFRelease(policy);
    CFRelease(publicKey);
}

@end
