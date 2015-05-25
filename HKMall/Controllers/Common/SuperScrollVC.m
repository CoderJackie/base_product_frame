//
//  SuperTableVC.m
//  HKMember
//
//  Created by Long on 14-10-8.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "SuperScrollVC.h"

@interface SuperScrollVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SuperScrollVC
@synthesize scrollTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBodyHeight)];
    self.scrollTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scrollTableView.showsVerticalScrollIndicator = NO;
    self.scrollTableView.delegate = self;
    self.scrollTableView.dataSource = self;
    self.view = self.scrollTableView;
}

#pragma mark - 表格代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kColorClear;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

@end
