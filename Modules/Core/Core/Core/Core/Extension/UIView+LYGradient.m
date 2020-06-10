//
//  UIView+LYGradient.m
//  LYProject
//
//  Created by mac on 2019/11/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIView+LYGradient.h"

@implementation UIView (LYGradient)

/**  设置View的渐变色

 @param colors 渐变颜色数组
 @param gradientType 渐变样式
 */
- (void)gradientColorFromColors:(NSArray*)colors
                             gradientType:(GradientType)gradientType {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, 1);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(1, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(1, 1);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(1, 0.0);
            end = CGPointMake(0.0, 1);
            break;
        default:
            break;
    }
    gradient.startPoint = start;
    gradient.endPoint = end;
    gradient.frame = self.bounds;
    NSMutableArray *array = @[].mutableCopy;
    for (UIColor *color in colors) {
        [array addObject:(id)color.CGColor];
    }
    gradient.colors = array;
    [self.layer insertSublayer:gradient atIndex:0];
}

@end
