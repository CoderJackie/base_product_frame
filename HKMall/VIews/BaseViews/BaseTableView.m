//
//  BaseTableView.m
//  WEIBO-X
//
//  Created by Mctu on 13-12-31.
//  Copyright (c) 2013年 XIAO. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate   = self;
        self.dataSource = self;
        self.accessibilityLabel = @"businessTable";
        self.isShowHeadView = NO;
        self.backgroundColor = kBackgroundColor;
     }
    return self;
}


#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isDelete) {
        return YES;
    }
    return NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isShowHeadView) {
        return 31;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//        if (editingStyle ==UITableViewCellEditingStyleDelete ) {
//            [self.data removeObjectAtIndex:indexPath.row];
//            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//        }
}


- (void)reloadData
{
    [super reloadData];
    [self.header endRefreshing];
    [self.footer endRefreshing];
}

@end
