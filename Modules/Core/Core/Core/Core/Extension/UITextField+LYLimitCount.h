//
//  UITextField+LYLimitCount.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (LYLimitCount)

@property (nonatomic, assign) NSInteger ly_limitCount;

/**
 设置占位符颜色
 
 @param color color description
 */
- (void)ly_placeholderColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
