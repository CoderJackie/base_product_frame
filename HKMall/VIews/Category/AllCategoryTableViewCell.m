//
//  AllCategoryTableViewCell.m
//  PinMall
//
//  Created by xujiaqi on 14/12/3.
//  Copyright (c) 2014年 365sji. All rights reserved.
//

//#import "AllCategoryTableViewCell.h"
//#import "ProductCategoryModel.h"
//
//#define kBtnWidth (kScreenWidth-26)/4
//static NSInteger const btnHeight = 40;
//static NSInteger const totalColum = 4;
//static NSInteger const imageViewWidth = 50/2;
//static NSInteger const imageViewHeight = 50/2;
//
//@implementation AllCategoryTableViewCell
//
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        
//        _imageView = InsertImageView(self.contentView, CGRectZero, nil);
//        _topCategory = InsertLabel(self.contentView, CGRectZero, NSTextAlignmentLeft, @"", kFontSize15, kColorBlack, NO);
//        _separateLine = InsertView(self.contentView, CGRectZero, kColorSeparatorline);
//        
//    }
//    return self;
//}
//
//- (void)removebuttons
//{
//    for (UIView *view in self.contentView.subviews) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            [view removeFromSuperview];
//        }
//    }
//}
//
//- (void)setCategoryModel:(ProductCategoryModel *)categoryModel
//{
//    [self removebuttons];
//    
//    _categoryModel = categoryModel;
//    _imageView.frame = CGRectMake(13, 0, imageViewWidth, imageViewHeight);
//    
//    // add 卜增彦 2014.12.18 全部分类界面没有图标 取字段有误
////    [_imageView sd_setImageWithURL:[NSURL URLWithString:categoryModel.webTypeImage] placeholderImage:ImageWithName(@"allCategory_placeHolder") options:SDWebImageDownloaderLowPriority | SDWebImageRetryFailed];
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:categoryModel.typeImage] placeholderImage:ImageWithName(@"allCategory_placeHolder") options:SDWebImageDownloaderLowPriority | SDWebImageRetryFailed];
//    // end
//    
//    _topCategory.text = categoryModel.typeName;
//    CGFloat labelWidth = [DataHelper widthWithString:categoryModel.typeName font:kFontSize15];
//    _topCategory.frame = CGRectMake(_imageView.right + 10, _imageView.top, labelWidth, _imageView.height);
//    
//    _separateLine.frame = CGRectMake(_topCategory.right + 10, _topCategory.center.y, kScreenWidth - _topCategory.right - 10 , kSeparatorlineHeight);
//    
////    NSArray *secondArray = categoryModel.sencondLevelArray;
//    NSArray *secondArray = nil;
//    
//    NSInteger num = secondArray.count/totalColum + (secondArray.count % totalColum ? 1 : 0 );
//    NSInteger count = num * totalColum;
//    NSInteger secondArrayCount = secondArray.count;
//    int row = 0, colum = 0;
//    for (int i = 0; i < count; i++) {
//
//        CGRect rect = CGRectMake(13 + (kBtnWidth- 0.5)*colum, _imageView.bottom +13.5+ row *(btnHeight-0.5), kBtnWidth, btnHeight);
//        UIButton *btn = InsertButtonWithType(self.contentView, rect, 0, self, @selector(buttonPress:), UIButtonTypeCustom);
//        if (i < secondArrayCount) {
//            ProductCategoryModel *secondModel = secondArray[i];
//            [btn setTitle:secondModel.typeName forState:UIControlStateNormal];
//            btn.tag = 100 + i;
//        }
//        btn.titleLabel.font = kFontSize12;
//        [btn setTitleColor:kColorDarkgray forState:UIControlStateNormal];
//        [btn setBackgroundColor:kColorWhite];
//        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//        btn.layer.borderWidth = 0.5;
//        btn.layer.masksToBounds = YES;
//        btn.layer.borderColor = [kColorSeparatorline CGColor];
//        colum ++;
//        if (colum % totalColum == 0) {
//            row ++;
//            colum = 0;
//        }
//    }
//}
//+ (CGFloat)cellHeightWithSecondArray:(NSArray *)array
//{
//    NSInteger num = array.count/totalColum + (array.count % totalColum ? 1 : 0 );
////    return num * btnHeight +btnTopToCellTop + 5;
//    return num * btnHeight + imageViewHeight + 18/2 + 30/2;
//}
//- (void)buttonPress:(UIButton *)sender
//{
//    if (!sender.tag) return;
//    _buttonBlock(_categoryId, sender.tag);
//}
//
//@end
