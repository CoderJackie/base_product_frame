//
//  WebControlView.h
//  HKMember
//
//  Created by xiaohua on 14-8-13.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebControlView : UIView

@property (nonatomic,strong) UIButton *goForwardBtn;
@property (nonatomic,strong) UIButton *goBackBtn;
@property (nonatomic,strong) UIButton *refreshBtn;

@property (nonatomic,copy) dispatch_block_t goForwardBlock;
@property (nonatomic,copy) dispatch_block_t goBackBlock;
@property (nonatomic,copy) dispatch_block_t refreshBlock;

@end
