//
//  SuperTableVC.h
//  HKMember
//
//  Created by Long on 14-10-8.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperScrollVC : SuperVC

@property (nonatomic, strong) UITableView *scrollTableView;

/*
    特别说明：因为该ScrollView就是tableview的型如果UI没满屏时可不用设置cell的高度
    若满屏了，则必须要实现cell的高度代理，scrollView才能滑动到底部
    否则只显示屏幕中的内容，超出屏幕的滑动不到
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 */


@end
