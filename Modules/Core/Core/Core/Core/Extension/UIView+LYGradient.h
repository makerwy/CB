//
//  UIView+LYGradient.h
//  LYProject
//
//  Created by mac on 2019/11/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+LYGradient.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYGradient)

/**  设置View的渐变色

 @param colors 渐变颜色数组
 @param gradientType 渐变样式
 */
- (void)gradientColorFromColors:(NSArray*)colors
                   gradientType:(GradientType)gradientType;

@end

NS_ASSUME_NONNULL_END
