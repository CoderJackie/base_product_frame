//
//  WebViewController.m
//  HKMember
//
//  Created by 文俊 on 14-6-14.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "WebViewController.h"
#import "WebControlView.h"

@interface WebViewController ()
{
    WebControlView *_web;
}
@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self hideNavigationBar:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBodyHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    //网页是否启用智能识别
    _webView.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.view addSubview:_webView];
    
    if (_isShowToolBar) {
        kSelf;
        _webView.frame = CGRectMake(0, 0, kScreenWidth, kBodyHeight - 40);
        _web = [[WebControlView alloc]initWithFrame:CGRectMake(0, kBodyHeight - 40, kScreenWidth, 40)];
        _web.goBackBlock = ^{
            kSelfStrong;
            if ([self.webView canGoBack]) {
                [self.webView goBack];
            }
        };
        _web.goForwardBlock = ^{
            if ([mySelf.webView canGoForward]) {
                [mySelf.webView goForward];
            }
        };
        _web.refreshBlock = ^{
            [mySelf.webView reload];

        };
        [self.view addSubview:_web];
    }
    
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    self.title = @"载入中...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction:(UIButton *)button
{
    if (button.tag == 100) {
        if ([_webView canGoBack]) {
            [_webView goBack];
        }
        
    }else if (button.tag == 101){
        if ([_webView canGoForward]) {
            [_webView goForward];
        }
        
    }else if (button.tag == 102){
        [_webView reload];
        
    }
}

- (id)initWithUrl:(NSString *)url
{
    self = [self init];
    if (self != nil) {
        _url = [url copy];
    }
    return self;
}

- (void)backToSuperView
{
    if ([_webView canGoBack])
    {
        [_webView goBack];
    }
    else
    {
        [_webView stopLoading];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -UIWebView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * requestString = [[request URL] absoluteString];
    DLog(@"%@",requestString);
    if ([requestString rangeOfString:@"ResetPasswordSuccess"].length >0){
            [self resetpwdSuccess];
            return YES;
            
    }
   
    return YES;
}




- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO ;
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title.length >  0 ? title : _viewTitle;
    
    _web.goBackBtn.enabled=_webView.canGoBack;
    _web.goForwardBtn.enabled=_webView.canGoForward;
    
    NSString * requestString = [[webView.request URL] absoluteString];
    NSArray * componenets = [requestString componentsSeparatedByString:@"?"];
    if (componenets.count>1) {
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        NSString *msgStr=[componenets lastObject];
        NSArray *allVars = [msgStr componentsSeparatedByString:@"&"];
        
        for (NSString *item in allVars ) {
            NSArray *eq = [item componentsSeparatedByString:@"="];
            NSString *key = [eq objectAtIndex:0];
            NSString *value = [eq objectAtIndex:1];
            [dic setObject:value forKey:key];
        }
        NSString *method=[dic objectForKey:@"method"];
        NSString *value=[dic objectForKey:@"parameter"];
        DLog(@"%@ %@",method,value);
        //根据链接中获取到的method方法名，做不同的处理，parameter后面是参数，例如可以是url网址
        if ([requestString rangeOfString:@"RegisterUserSuccess"].length >0) {
            [self performSelector:@selector(regSuccess) withObject:nil afterDelay:0];
        }

    }
}

// 注册成功
- (void)regSuccess
{
    NSString *accAndPwd = [_webView stringByEvaluatingJavaScriptFromString:@"RegSuccess();"];
    DLog(@"注册成功");
    if(accAndPwd.length >0 && [accAndPwd rangeOfString:@","].length >0)
    {
        NSArray *sep = [accAndPwd componentsSeparatedByString:@","];
        NSString *acc = [sep objectAtIndex:0];
        NSString *pwd = [sep objectAtIndex:1];
        
       if(self.callBack)
       {
           self.callBack([NSDictionary dictionaryWithObjects:@[acc,pwd] forKeys:@[@"acc",@"pwd"]]);
       }
    }
   
    
    
}


// 设置密码成功
- (void)resetpwdSuccess
{
    NSLog(@"设置密码成功");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
