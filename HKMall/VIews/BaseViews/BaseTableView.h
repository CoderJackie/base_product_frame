//
//  BaseTableView.h
//  WEIBO-X
//
//  Created by Mctu on 13-12-31.
//  Copyright (c) 2013年 XIAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface BaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *data;//提供数据

@property (nonatomic, assign) BOOL isDelete; //是否删除

@property (nonatomic, assign) BOOL isShowHeadView;

@end
