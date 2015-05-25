//
//  ProductCategoryVC.m
//  HKMall
//
//  Created by xujiaqi on 15/5/25.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import "ProductCategoryVC.h"

@interface ProductCategoryVC ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) BaseTableView *tableView;
@end

@implementation ProductCategoryVC

#pragma mark - getter
- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [DataHelper setExtraCellLineHidden:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView addLegendHeaderWithRefreshingBlock:^{
            
        }];
    }
    return _tableView;
    
}

#pragma mark - view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"分类";
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    return cell;
}

@end
