//
//  HomeVC.m
//  HKMall
//
//  Created by xujiaqi on 15/5/25.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import "HomeVC.h"
#import "ProductDetailVC.h"

@interface HomeVC ()

@end

@implementation HomeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:@"详情" imageName:nil target:self action:@selector(leftBarButtonClick)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

- (void)leftBarButtonClick
{
    ProductDetailVC *detailVC = [[ProductDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
