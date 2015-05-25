//
//  UIImage+LocalizedImage.h
//  PFSample
//
//  Created by Kasajima Yasuo on 12/03/04.
//  Copyright (c) 2012年 kyoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)
+(UIImage*)imageLocalizedNamed:(NSString *)name;
+ (UIImage *)colorImage:(UIImage *)img withColor:(UIColor *)color;
+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color;
+ (UIImage *)imageLocalizedNamed:(NSString *)name withColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage *)cropImageInRect:(CGRect )rect;
- (UIImage *)resizeImageToWidth:(float )width;
- (UIImage *) rotateImage:(UIImage *)img angle:(int)angle;
- (UIImage *) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
@end
