//
//  MicLocationAssistant.h
//  HKMember
//
//  Created by apple on 14-4-14.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MicAssistant : NSObject

+ (id)sharedInstance;

/**
 *  总定位服务是否开始
 *  @return
 */
- (BOOL)isLocationServiceOn;

/**
 *  当前app服务定位是否开启
 *  @return
 */
- (BOOL)isCurrentAppLocatonServiceOn;

/**
 *  当前app服务定位是否已决定
 *  @return
 */
- (BOOL)isLocationServiceDetermined;

/**
 *  当前app相册是否允许访问
 *  @return
 */
- (BOOL)isCurrentAppALAssetsLibraryServiceOn;


/**
 * 当前app相机服务是否拒绝
 * @return
 */
- (BOOL)isCameraServiceOn;

/**
 *  检测麦克风
 *  @return
 */
- (void)checkMicrophoneServeceOnCompletion:(void (^)(BOOL isPermision, BOOL isFirstAsked))completion;

@end
