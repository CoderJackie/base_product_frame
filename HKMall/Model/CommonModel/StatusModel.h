//
//  StatusModel.h
//  HKMember
//
//  Created by 文俊 on 14-3-20.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//
#import "BaseModel.h"

@interface StatusModel : BaseModel

@property (nonatomic, assign) int flag;         //状态码
@property (nonatomic, strong) NSString* msg;    //信息
@property (nonatomic, assign) int totalSize;    //总数
@property (nonatomic, strong) id rs;            //结果  对应的Model  eg. BusinessModel or BusinessModel数组

@end
