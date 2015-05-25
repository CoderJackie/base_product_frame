#import <Foundation/Foundation.h>
//#import "DDXML.h"

@class HZActivityIndicatorView;
@interface DataHelper : NSObject

//根据最小尺寸转换图片
+ (UIImage *)scaleImage:(UIImage *)image toMinSize:(float)size;
//根据比例转换图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
//保存图片到Cache
+ (void)saveImage:(UIImage *)tempImage WithPath:(NSString *)path;
//从文档目录下获取路径
+ (NSString *)cachesFolderPathWithName:(NSString *)imageName;
//指定路径删除文件
+ (void)removeCachesFolderAtPath:(NSString*)filePath;

//获取现在时间
+(NSString *)getCurrentTime;
//tableView隐藏多余的线
+ (void)setExtraCellLineHidden:(UITableView *)tableView;
//转化DeviceToken
+(NSString*)conversionDeviceToken:(NSData*)deviceToken;

// 随机获取文件名 例如20131111_051014
+ (NSString*)getRandomFileName;
//获取一个随机整数，范围在[from,to），包括from，不包括to
+(int)getRandomNumber:(int)from to:(int)to;

#pragma mark - gps
//判断gps是否有效
+ (BOOL)gpsIsValidLongitude:(double)longitude latitude:(double)latitude;

//xml
//+(NSXMLElement*)creationPropertyName:(NSString*)name valueType:(NSString*)valueType value:(NSString*)value;

//唯一字符串
+(NSString *)generateUUID;
//获取设备唯一ID
+(NSString *)getDeviceID;
#pragma mark - UIColor
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(float)al;

/**
 *  32位 md5加密
 *  @param srcString 需要加密的字符串
 *  @param uppercase 是否需要转大写
 *  @return 加密后的字符串
 */
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase;

/**
 *  16位 md5加密
 *  @param srcString 需要加密的字符串
 *  @param uppercase 是否需要转大写
 *  @return 加密后的字符串
 */
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase;

/**
 *  计算高度
 *  @param string 需要计算高度的字符串
 *  @param font   字体
 *  @param width  限制宽度
 *  @return 返回计算出来的高度
 */
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  计算宽度
 *  @param string
 *  @param font
 *  @return 
 */
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;

/**
 * 当需要改变Label中得一段字体属性时调用
 * @param allstring 总字段
 * @param string    需要改变属性的字段
 * @param color     颜色
 * @param size      字体大小
 * @return  处理过后带属性的字段
 */
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size;

/**
 *  设置textfiled左边的空白
 *  @param textField
 *  @param rect      
 */
+ (void)setEmptyLeftViewForTextField:(UITextField *)textField withFrame:(CGRect)rect;

//给谁谁发信息
+ (void)showPromptMessage:(NSString *)phone;
//判断是否为空字符串
+(BOOL) isEmptyOrNull:(NSString *) string;

/**
 *  限制textfild 小数位数为2位
 */
+ (BOOL)setRadixPointForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 *  动态限制textField 长度
 *  add buzengyan
 */
+ (BOOL)setRadixPointForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string stringLength:(float)length;


// string to number
+ (NSNumber *)stringToNum:(NSString *)string;

@end
