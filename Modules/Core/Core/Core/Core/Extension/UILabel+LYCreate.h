//
//  UILabel+LYCreate.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LYCreate)

+ (UILabel *)ly_labelWithFont:(UIFont *)font textColor:(NSString *)textColor;
+ (UILabel *)ly_labelWithFont:(UIFont *)font textColor:(NSString *)textColor textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)ly_labelWithText:(NSString *)text font:(UIFont *)font textColor:(NSString *)textColor textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
