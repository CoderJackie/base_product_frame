//
//  MyTabbarVC.h
//  PinMall
//
//  Created by YangXu on 14/11/27.
//  Copyright (c) 2014年 365sji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeVC;
@class ProductCategoryVC;
@class ShoppingCartVC;
@class MineVC;


@interface MyTabbarVC : UITabBarController<UITabBarControllerDelegate>

@property (strong, nonatomic) HomeVC *homeVC;
@property (strong, nonatomic) ProductCategoryVC *productCategoryVC;
@property (strong, nonatomic) ShoppingCartVC *shoppingCartVC;
@property (strong, nonatomic) MineVC *mineVC;

- (void)setTabBarState;

@end
