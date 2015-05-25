//
//  Common_color.h
//  HKC
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用颜色

#ifndef HKC_Common_color_h
#define HKC_Common_color_h

/********************** Color ****************************/

#pragma mark - 颜色

/// 设置颜色
#define UIColorRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

/// 设置颜色 示例：UIColorHex(0x26A7E8)
#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/// 设置颜色与透明度 示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
#define UIColorHex_Alpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

/// 导航栏背景颜色
#define kColorNavBground UIColorHex(0xd70408)

// 主题背景色
//#define kBackgroundColor UIColorHex(0xe6e6e6)
#define kBackgroundColor UIColorRGB(238,241,241)
// cell高亮颜色
#define kCellHightedColor UIColorHex(0xe6e6e9)
/// 通用的红色文字颜色
#define kColorFontRed UIColorHex(0xe12228)

/// 透明色
#define kColorClear [UIColor clearColor]

/// 白色-如导航栏字体颜色
#define kColorWhite UIColorHex(0xffffff)

/// 淡灰色-如普通界面的背景颜色
#define kColorLightgrayBackground UIColorHex(0xf5f5f5)

/// 灰色—如内容字体颜色
#define kColorLightgrayContent UIColorHex(0x969696)

/// 灰色-如输入框占位符字体颜色
#define kColorLightgrayPlaceholder UIColorHex(0xaaaaaa)

/// 深灰色
#define kColorDarkgray UIColorHex(0x666666)

/// 黑色-如输入框输入字体颜色或标题颜色
#define kColorBlack UIColorHex(0x333333)

/// 黑色-细黑
#define kColorBlacklight UIColorHex(0x999999)

/// 黑色-纯黑
#define kColorDeepBlack UIColorHex(0x000000)

/// 灰色—如列表cell分割线颜色
// begin
/*
#define kColorSeparatorline UIColorHex(0xd1d1d1)
 */
#define kColorSeparatorline UIColorHex(0xdfdfe1)
// end

/// 灰色—如列表cell分割线颜色较深e5样式
#define kColorSeparatorline5 UIColorHex(0xe5e5e5)

/// 灰色-边框线颜色
#define kColorBorderline UIColorHex(0xb8b8b8)

/// 绿色-如导航栏背景颜色
#define kColorGreenNavBground UIColorHex(0x38ad7a)

/// 绿色
#define kColorGreen UIColorHex(0x349c6f)

/// 深绿色
#define kColorDarkGreen UIColorHex(0x188d5a)

/// 橙色
#define kColorOrange UIColorHex(0xf39700)

/// 深橙色
#define kColorDarkOrange UIColorHex(0xe48437)

/// 淡紫色
#define kColorLightPurple UIColorHex(0x909af8)

/// 红色
#define kColorRed UIColorHex(0xfd492e)

/// 蓝色
#define kColorBlue UIColorHex(0x00a0e9)

/// 高雅黑
#define kColorElegantBlack UIColorRGB(29, 31, 38)

/// 白色
#define kColorWhitelight UIColorHex(0xfefefe)

/// 背景色
#define kColorBackGroundColor UIColorHex(0xeff0f2)

/********************** Color ****************************/

#endif
