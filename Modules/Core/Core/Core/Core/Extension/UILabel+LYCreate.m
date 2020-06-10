//
//  UILabel+LYCreate.m
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UILabel+LYCreate.h"
#import "UIColor+LYHex.h"

@implementation UILabel (LYCreate)

+ (UILabel *)ly_labelWithFont:(UIFont *)font textColor:(NSString *)textColor {
    return [UILabel ly_labelWithFont:font textColor:textColor textAlignment:NSTextAlignmentLeft];
}
+ (UILabel *)ly_labelWithFont:(UIFont *)font textColor:(NSString *)textColor textAlignment:(NSTextAlignment)textAlignment {
    return [UILabel ly_labelWithText:@"" font:font textColor:textColor textAlignment:textAlignment];
}
+ (UILabel *)ly_labelWithText:(NSString *)text font:(UIFont *)font textColor:(NSString *)textColor textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = [UIColor ly_colorWithHexString:textColor];
    label.textAlignment = textAlignment;
    label.text = text;
    return label;
}

@end
