//
//  SuperVC.m
//  YueDian
//
//  Created by xiao on 15/3/5.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import "SuperVC.h"
#import "MyTabbarVC.h"

#define widthScreen  [UIScreen mainScreen].applicationFrame.size.width
#define heightScreen [UIScreen mainScreen].applicationFrame.size.height

@interface SuperVC ()<LoadingAndRefreshViewDelegate>
{
    LoadingAndRefreshView   *_loadingAndRefreshView;
}
@end

@implementation SuperVC

- (void)dealloc
{
    DLog(@"%@释放了",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewWillAppear:(BOOL)animated{
    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleLightContent)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self setNeedsStatusBarAppearanceUpdate];
    }
    self.navigationItem.leftBarButtonItem.customView.userInteractionEnabled = NO;
    self.navigationItem.rightBarButtonItem.customView.userInteractionEnabled = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationItem.leftBarButtonItem.customView.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem.customView.userInteractionEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
    if ([self isTabbarRoot]) {
        self.hidesBottomBarWhenPushed = NO;
    }else{
        self.hidesBottomBarWhenPushed = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadViewData];

}

- (void)loadViewData{
    self.view.backgroundColor = UIColorRGB(240, 240, 243);
    self.tabBarController.tabBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = [self isTabbarRoot] ? nil : [self barBackButton];

}

#pragma mark - public Meathod 
- (void)backToSuperView
{
    [self releaseNet];//取消网络请求
    [self.view endEditing:YES];
    if (self.navigationController.viewControllers.firstObject == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)loginVerifySuccess:(void (^)())success
{
    if ([DataManager sharedManager].isLogin) {
        if (success) {
            success();
        }
    }else{
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        loginVC.completionBack = [success copy];
//        UINavigationController *navigationController = [[UINavigationController alloc]
//                                                        initWithRootViewController:loginVC];
//        [MainViewController setNavigationStyle:navigationController];
//        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

#pragma mark - Private Meathod
- (BOOL)isTabbarRoot
{
    for (UINavigationController* nc in self.tabBarController.viewControllers) {
        if (nc.viewControllers.firstObject == self) {
            return YES;
        }
    }
    return NO;
}

+ (void)setNavigationStyle:(UINavigationController *)nav
{
    [nav.view setBackgroundColor:kColorNavBground];
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowOffset = CGSizeZero;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor whiteColor],NSForegroundColorAttributeName,
                          kFontSizeBold21,NSFontAttributeName,
                          shadow,NSShadowAttributeName,
                          shadow,NSShadowAttributeName,
                          nil];
    
    nav.navigationBar.titleTextAttributes = dict;
    [nav.navigationBar lt_setBackgroundColor:kColorNavBground];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    nav.navigationBar.barStyle =  UIBaselineAdjustmentNone;
}


#pragma mark - Creat View Meathod
#pragma mark - 导航栏按钮

- (UIBarButtonItem *)barBackButton
{
    UIImage *image = [UIImage imageNamed:@"bar_back_logo"];
    CGRect buttonFrame;
    if (ISIOS7) {
        buttonFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    }else{
        buttonFrame = CGRectMake(0, 0, image.size.width+20, image.size.height);
    }
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 12)];
    button.accessibilityLabel = @"back";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

- (UIBarButtonItem *)barBackButtonWithImage:(UIImage *)image
{
    CGRect buttonFrame;
    if (ISIOS7)
    {
        buttonFrame = CGRectMake(0.0, 0.0, 20.0 * image.size.width / image.size.height, 20.0);
    }
    else
    {
        buttonFrame = CGRectMake(0.0, 0.0, 20.0 * image.size.width / image.size.height + 20.0, 20.0);
    }
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.accessibilityLabel = @"back";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

// 设置导航栏右按钮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                     action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imageName && ![imageName isEqualToString:@""])
    {
        UIImage *image = [UIImage imageNamed:imageName];
        [btn setImage:image forState:UIControlStateNormal];
        
        UIImage *imageSelected = [UIImage imageNamed:[NSString stringWithFormat:@"%@_s",imageName]];
        if (imageSelected)
        {
            [btn setImage:imageSelected forState:UIControlStateSelected];
        }
        
        btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    else
    {
        btn.frame=CGRectMake(0, 0, 50, 30);
    }
    
    if (name && ![name isEqualToString:@""])
    {
        [btn setTitle:name forState:UIControlStateNormal];
        btn.titleLabel.font = kFontSizeBold16;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forState:UIControlStateDisabled];
    }
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}


-(void)addLoadingView{
    
    if (_loadingAndRefreshView==nil) {
        _loadingAndRefreshView=[[LoadingAndRefreshView alloc] initWithFrame: self.view.bounds];
        _loadingAndRefreshView.delegate=self;
    }
    
    if (_loadingAndRefreshView.superview==nil) {
        [self.view addSubview:_loadingAndRefreshView];
    }
    
    [self.view bringSubviewToFront:_loadingAndRefreshView];
}

-(void)loadingDataStart{
    
    [self addLoadingView];
    
    [_loadingAndRefreshView setLoadingState];
}

-(void)loadingDataSuccess{
    
    if (_loadingAndRefreshView.superview!=nil) {
        [_loadingAndRefreshView removeFromSuperview];
    }
    
}

-(void)loadingDataFail{
    [self addLoadingView];
    [_loadingAndRefreshView setFailedState];
}

-(void)loadingDataBlank{
    
    [self addLoadingView];
    [_loadingAndRefreshView setBlankStateWithTitle:@""];
}


-(void)loadingDataBlankWithTitle:(NSString *)title{
    
    [self addLoadingView];
    [_loadingAndRefreshView setBlankStateWithTitle:title];
}

-(void)reflashClick{
}

- (void)updateLogin
{
    
}

#pragma mark - 网络操作
/**
 *  添加网络请求，backToSuperView执行后就会取消正在请求的网络
 *  @param net 网络操作
 */
- (void)addNet:(MKNetworkOperation *)net{
    if (!_networkOperations) {
        _networkOperations = [[NSMutableArray alloc] init];
    }
    [_networkOperations addObject:net];
}

/**
 *  手动释放网络操作队列
 */
- (void)releaseNet
{
    for (MKNetworkOperation *net in _networkOperations) {
        if ([net isKindOfClass:[MKNetworkOperation class]]) {
            [net cancel];
        }
    }
}


/**
 *  隐藏导航栏
 */
- (void)hideNavigationBar:(BOOL)flag
{
    [self.navigationController setNavigationBarHidden:flag];
}


@end
