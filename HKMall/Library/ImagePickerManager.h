//
//  ImagePickerManager.h
//  HKMember
//
//  Created by zhangshaoyu on 14-6-11.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//  功能描述：封装公用UIImagePickerController，避免代码冗余

#import <UIKit/UIKit.h>

@interface ImagePickerManager : UIImagePickerController

/// 设置代码块属性-成功
@property (nonatomic, copy) void (^succeedBack)(UIImage *image);

/// 设置代码块属性-失败
@property (nonatomic, copy) void (^errorBack) (void);

/// 设置属性源
@property (nonatomic, assign) UIImagePickerControllerSourceType pickerType;

/// 根据数据源异常处理
- (BOOL)exceptionHandlingwithSourceType;

/// 设置代码块回调函数
- (void)getPickerImage:(void (^)(UIImage *image))succeed withError:(void (^)(void))error;

@end

/*
 使用示例
 步骤1 导入头文件
 #import "ImagePickerManager.h"
 
 步骤2 定义属性
 @property (nonatomic, strong) ImagePickerManager *imagePickerManager;
 
 步骤3 实例化
 mySelf.imagePickerManager = [[ImagePickerManager alloc] init];
 
 步骤4 设置数据源
 mySelf.imagePickerManager.pickerType = UIImagePickerControllerSourceTypePhotoLibrary;
 
 步骤5 异常判断
 if ([mySelf.imagePickerManager exceptionHandlingwithSourceType])
 {
    [mySelf presentViewController:mySelf.imagePickerManager animated:YES completion:NULL];
 
    [mySelf.imagePickerManager getPickerImage:^(UIImage *image) {
        NSLog(@"success");
    } withError:^{
        NSLog(@"error");
    }];
 }
 
 */