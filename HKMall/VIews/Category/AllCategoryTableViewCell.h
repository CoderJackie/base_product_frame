//
//  AllCategoryTableViewCell.h
//  PinMall
//
//  Created by xujiaqi on 14/12/3.
//  Copyright (c) 2014年 365sji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductCategoryModel;

@interface AllCategoryTableViewCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *_topCategory;
    UIView *_separateLine;
    ProductCategoryModel *_categoryModel;
}
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy) void (^buttonBlock)(NSInteger, NSInteger);
@property (nonatomic, strong) ProductCategoryModel *categoryModel;
+ (CGFloat)cellHeightWithSecondArray:(NSArray *)array;
@end
