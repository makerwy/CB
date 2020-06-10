//
//  UIImage+LYGradient.m
//  LYProject
//
//  Created by mac on 2019/11/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIImage+LYGradient.h"
#import "UIColor+LYHex.h"

@implementation UIImage (LYGradient)

/**  设置图片的渐变色(颜色->图片)

 @param colors 渐变颜色数组  @param gradientType 渐变样式  @param imgSize 图片大小  @return 颜色->图片  */
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors
                             gradientType:(GradientType)gradientType
                                  imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    NSMutableArray *colorArr = [NSMutableArray array];
//    for(UIColor *c in colors) {
//        [ar addObject:(id)c.CGColor];
//    }
    for(NSString *c in colors) {
        UIColor *color = [UIColor ly_colorWithHexString:c];
        [colorArr addObject:color];
        [ar addObject:(id)color.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colorArr lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
