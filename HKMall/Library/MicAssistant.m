//
//  MicLocationAssistant.m
//  HKMember
//
//  Created by apple on 14-4-14.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "MicAssistant.h"
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@implementation MicAssistant

+ (id)sharedInstance
{
    static MicAssistant *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (BOOL)isLocationServiceOn
{
    return [CLLocationManager locationServicesEnabled];
}

- (BOOL)isCurrentAppLocatonServiceOn
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)isLocationServiceDetermined
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusNotDetermined == status) {
        return NO;
    } else {
        return YES;
    }
    
}


- (BOOL)isCurrentAppALAssetsLibraryServiceOn
{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)isCameraServiceOn
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusDenied) {
        return NO;
    }else{
        return YES;
    }
}

- (void)checkMicrophoneServeceOnCompletion:(void (^)(BOOL isPermision, BOOL isFirstAsked))completion
{
    __block BOOL permision = NO;
    __block BOOL firstAsked = NO;
    // ios7 是利用 requestRecordPermission,回调只能判断允许或者未被允许
    NSDate *date = [NSDate date];
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            
            // ios7无法判断是否是出于未决定的状态,但是一旦判断，很快回调，所以可以用一个比较短的时间差来达到比较精准的判断
            NSDate *date2 = [NSDate date];
            NSTimeInterval timeGap = [date2 timeIntervalSinceDate:date];
            if (timeGap > 0.5) {
                firstAsked = YES;
            } else {
                firstAsked = NO;
            }
            permision = granted;
            
            if (completion) {
                completion(permision, firstAsked);
            }
        }];
        
    } else {
        // 7以前不用检测权限
        permision = YES;
        firstAsked = NO;
        if (completion) {
            completion(permision, firstAsked);
        }
    }
}

@end
