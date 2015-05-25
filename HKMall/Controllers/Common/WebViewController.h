//
//  WebViewController.h
//  HKMember
//
//  Created by 文俊 on 14-6-14.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "SuperVC.h"

@interface WebViewController : SuperVC<UIWebViewDelegate>
{
    NSString *_url;
}
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *viewTitle;
@property (assign, nonatomic) BOOL isShowToolBar;
@property (strong, nonatomic) void(^ callBack)(NSDictionary *dicData);



- (id)initWithUrl:(NSString *)url;



@end