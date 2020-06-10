//
//  UIImage+LYCreate.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LYCreate)

/**
 根据rect生成纯色图片
 
 @param color color description
 @param rect rect description
 @return return value description
 */
+ (nullable UIImage *)ly_imageWithColor:(UIColor *_Nullable)color rect:(CGRect)rect;



@end

NS_ASSUME_NONNULL_END
