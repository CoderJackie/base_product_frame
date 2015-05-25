//
//  ImagePickerManager.m
//  HKMember
//
//  Created by zhangshaoyu on 14-6-11.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "ImagePickerManager.h"
#import "MicAssistant.h"

@interface ImagePickerManager () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ImagePickerManager

@synthesize succeedBack;
@synthesize errorBack;
@synthesize pickerType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.sourceType = self.pickerType;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 异常处理

// 根据数据源异常处理
- (BOOL)exceptionHandlingwithSourceType
{
    if (self.pickerType == UIImagePickerControllerSourceTypeCamera) {
        if (![[MicAssistant sharedInstance] isCameraServiceOn]) {
            [UIAlertView alertViewWithTitle:@"提示" message:@"无法使用相机，请在iPhone的“设置--隐私--相机”中允许访问相机"];
            return NO;
        }
    }
    if (![UIImagePickerController isSourceTypeAvailable:self.pickerType])
    {
        NSString *message = (self.pickerType == UIImagePickerControllerSourceTypeCamera ? @"该设备找不到相机" : @"资源不可访问");
        
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil] show];
        
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - 代码块回调

- (void)getPickerImage:(void (^)(UIImage *image))succeed withError:(void (^)(void))error
{
    self.succeedBack = [succeed copy];
    self.errorBack = [error copy];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (!image)
    {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
    if (self.succeedBack)
    {
        self.succeedBack(image);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.errorBack)
    {
        self.errorBack();
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
