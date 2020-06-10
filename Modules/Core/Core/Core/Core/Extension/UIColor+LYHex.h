//
//  UIColor+LYHex.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LYHex)

/**
 *  获取颜色 含有alpha
 *
 *  @param color 6位16进制字符串
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)ly_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  获取颜色
 *
 *  @param color 6位16进制字符串
 *
 *  @return 颜色
 */
+ (UIColor *)ly_colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
