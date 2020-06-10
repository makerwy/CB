//
//  NSMutableAttributedString+LYAttributedString.h
//  LYProject
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (LYAttributedString)

- (NSMutableAttributedString *)attributedSubstringWithLineSpace:(CGFloat)lineSpace;
- (NSMutableAttributedString *)attributedSubstringWithFont:(UIFont *)font;
- (NSMutableAttributedString *)attributedSubstringWithFont:(UIFont *)font rangeString:(NSString *)rangeString;
- (NSMutableAttributedString *)attributedSubstringWithFont:(UIFont *)font range:(NSRange)range;
- (NSMutableAttributedString *)attributedSubstringWithTextColor:(UIColor *)textColor;
- (NSMutableAttributedString *)attributedSubstringWithTextColor:(UIColor *)textColor rangeString:(NSString *)rangeString;
- (NSMutableAttributedString *)attributedSubstringWithTextColor:(UIColor *)textColor range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
