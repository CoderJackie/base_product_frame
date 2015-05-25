//
//  MyTabbarVC.m
//  PinMall
//
//  Created by YangXu on 14/11/27.
//  Copyright (c) 2014年 365sji. All rights reserved.
//

#import "MyTabbarVC.h"
#import "CustomTabbarButton.h"

#import "HomeVC.h"
#import "ProductCategoryVC.h"
#import "ShoppingCartVC.h"
#import "MineVC.h"
#import "BufferedNavigationController.h"

@interface MyTabbarVC ()
{
    UIImageView *_bgView;
    NSMutableArray *_btnData;
    NSMutableArray *_btnArray;
}

@end

@implementation MyTabbarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initView{
    
    [self addNavigationController];
    [self drawTabBar];
    [self setTabBarState];
}

//自定义tabbar
- (void)drawTabBar{
    
    _btnArray= [[NSMutableArray alloc] initWithCapacity:3];
    _btnData = [[NSMutableArray alloc] initWithCapacity:3];
    
    NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic1 setObject:[UIImage imageNamed:@"tabbar_n_1"] forKey:@"Default"];
    [imgDic1 setObject:[UIImage imageNamed:@"tabbar_s_1"] forKey:@"Seleted"];
    [imgDic1 setObject:@"首页" forKey:@"name"];
    NSMutableDictionary *imgDic2 =[NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic2 setObject:[UIImage imageNamed:@"tabbar_n_2"] forKey:@"Default"];
    [imgDic2 setObject:[UIImage imageNamed:@"tabbar_s_2"] forKey:@"Seleted"];
    [imgDic2 setObject:@"分类" forKey:@"name"];
    NSMutableDictionary *imgDic3 =[NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic3 setObject:[UIImage imageNamed:@"tabbar_n_3"] forKey:@"Default"];
    [imgDic3 setObject:[UIImage imageNamed:@"tabbar_s_3"] forKey:@"Seleted"];
    [imgDic3 setObject:@"购物车" forKey:@"name"];
    NSMutableDictionary *imgDic4 =[NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic4 setObject:[UIImage imageNamed:@"tabbar_n_3"] forKey:@"Default"];
    [imgDic4 setObject:[UIImage imageNamed:@"tabbar_s_3"] forKey:@"Seleted"];
    [imgDic4 setObject:@"我的" forKey:@"name"];
    
    [_btnData addObject:imgDic1];
    [_btnData addObject:imgDic2];
    [_btnData addObject:imgDic3];
    [_btnData addObject:imgDic4];
    
    _bgView = [[UIImageView alloc] init];
    _bgView.userInteractionEnabled=YES;
    
    CGRect frame=self.tabBar.frame;
    frame.origin.y=0;
    _bgView.frame=frame;
    _bgView.image=[UIImage imageWithColor:UIColorHex(0xf9f9f9) andSize:CGSizeMake(1, 49)];
    _bgView.alpha = 0.95;
    [self.tabBar addSubview:_bgView];
    
    double _width=kScreenWidth/_btnData.count;
    double _height=self.tabBar.frame.size.height;
    UIColor *color = UIColorHex(0x5D6460);
    
    for (int i=0; i<_btnData.count; i++) {
        
        NSDictionary *dic=[_btnData objectAtIndex:i];
        
        CustomTabbarButton *btn = [[CustomTabbarButton alloc] initWithFrame:CGRectMake(i*_width, 0, _width, _height)];
        [btn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [_btnArray addObject:btn];
        
        //设置图片，不是背景图片
        [btn.cusImageView setImage:[dic objectForKey:@"Default"]];
        
        //文字
        UIFont *font = [UIFont boldSystemFontOfSize:12.0];
        [btn.cusTitleLabel setText:[dic objectForKey:@"name"]];
        [btn.cusTitleLabel setTextColor:color];
        btn.cusTitleLabel.font=font;
        
        [_bgView addSubview:btn];
    }

}

-(void)addNavigationController{
    
    _homeVC = [[HomeVC alloc] init];
    UINavigationController *navigationController01 = [[BufferedNavigationController alloc] initWithRootViewController:_homeVC];
    navigationController01.view.backgroundColor = kColorGreen;
    
    _productCategoryVC = [[ProductCategoryVC alloc] init];
    UINavigationController *navigationController02 = [[BufferedNavigationController alloc] initWithRootViewController:_productCategoryVC];
    
    _shoppingCartVC = [[ShoppingCartVC alloc] init];
    UINavigationController *navigationController03 = [[BufferedNavigationController alloc] initWithRootViewController:_shoppingCartVC];
    
    _mineVC = [[MineVC alloc] init];
    UINavigationController *navigationController04 = [[BufferedNavigationController alloc] initWithRootViewController:_mineVC];
    
    
    NSArray *ctrlArr = [NSArray arrayWithObjects:navigationController01, navigationController02, navigationController03, navigationController04, nil];
    
    self.viewControllers = ctrlArr;
    
    [SuperVC setNavigationStyle:navigationController01];
    [SuperVC setNavigationStyle:navigationController02];
    [SuperVC setNavigationStyle:navigationController03];
    [SuperVC setNavigationStyle:navigationController04];
}

#pragma mark - tabbar
- (void)selectedClick:(UIButton *)button{
    
    if (self.selectedIndex!=button.tag) {
        [self setSelectedIndex:button.tag];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self setTabBarState];
}

#pragma mark - 跳转到其他tabbarIndex
- (void)gotoTabbarIndex:(NSNotification *)obj
{
    NSInteger index = [[obj object] integerValue];
    if (index >= 0 && index < 4) {
        self.selectedIndex = index;
        [self setTabBarState];
    }
}

-(void)setTabBarState
{
    UIColor *color = UIColorHex(0x5D6460);
    UIColor *colorSelect = UIColorHex(0xE12328);
    
    for (int i=0; i<_btnData.count; i++) {
        NSDictionary *dic=[_btnData objectAtIndex:i];
        CustomTabbarButton *btn=[_btnArray objectAtIndex:i];
        if (i==self.selectedIndex) {
            [btn.cusImageView setImage:[dic objectForKey:@"Seleted"]];
            [btn.cusTitleLabel setTextColor:colorSelect];

        }else{
            [btn.cusImageView setImage:[dic objectForKey:@"Default"]];
            [btn.cusTitleLabel setTextColor:color];
        }
    }
}

+ (void)setTableBarItemStyle:(UITabBarItem*)tabBarItem
{
    //    [tabBarItem setImageInsets:UIEdgeInsetsMake(-2.0, 0.0, 2.0, 0.0)];
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    UIColor *color = UIColorRGB(150, 150, 150);
    UIColor *colorSelect = UIColorRGB(0, 174, 125);
    UIFont *font = kFontSizeBold12;
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        color, NSForegroundColorAttributeName,
                                        font, NSFontAttributeName,
                                        nil] forState:UIControlStateNormal];
    
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        colorSelect, NSForegroundColorAttributeName,
                                        font, NSFontAttributeName,
                                        nil] forState:UIControlStateSelected];
}

@end
