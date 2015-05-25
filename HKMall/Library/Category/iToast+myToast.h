//
//  iToast+myToast.h
//  HKMember
//
//  Created by 文俊 on 14-4-26.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "iToast.h"

@interface iToast (myToast)

+ (iToast *)alertWithTitle:(NSString *)title;

+ (iToast *)alertWithTitleCenter:(NSString *)title;

//显示iToast自定义位置和时间
+ (iToast *)alertWithTitle:(NSString *)title gravity:(iToastGravity)gravity duration:(NSInteger)duration;

// begin 张绍裕 20140701

/// 隐藏iToast
+ (void)hiddenIToast;
// end

@end
