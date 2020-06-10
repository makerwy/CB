//
//  NSMutableAttributedString+LYAttributedString.m
//  LYProject
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NSMutableAttributedString+LYAttributedString.h"

@implementation NSMutableAttributedString (LYAttributedString)

- (NSMutableAttributedString *)attributedSubstringWithLineSpace:(CGFloat)lineSpace {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpace;
    [self addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, self.string.length - 1)];
    return self;
}

- (NSMutableAttributedString *)attributedSubstringWithFont:(UIFont *)font {
    [self attributedSubstringWithFont:font rangeString:self.string];
    return self;
}

- (NSMutableAttributedString *)attributedSubstringWithFont:(UIFont *)font rangeString:(NSString *)rangeString {
    [self addAttribute:NSFontAttributeName value:font range:[self.string rangeOfString:rangeString]];
    return self;
}
- (NSMutableAttributedString *)attributedSubstringWithFont:(UIFont *)font range:(NSRange)range {
    [self addAttribute:NSFontAttributeName value:font range:range];
    return self;
}

- (NSMutableAttributedString *)attributedSubstringWithTextColor:(UIColor *)textColor {
    [self attributedSubstringWithTextColor:textColor rangeString:self.string];
    return self;
}

- (NSMutableAttributedString *)attributedSubstringWithTextColor:(UIColor *)textColor rangeString:(NSString *)rangeString {
    [self addAttribute:NSForegroundColorAttributeName value:textColor range:[self.string rangeOfString:rangeString]];
    return self;
}

- (NSMutableAttributedString *)attributedSubstringWithTextColor:(UIColor *)textColor range:(NSRange)range {
    [self addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    return self;
}


@end
