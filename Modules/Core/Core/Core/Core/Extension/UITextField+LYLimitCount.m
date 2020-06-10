//
//  UITextField+LYLimitCount.m
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UITextField+LYLimitCount.h"
#import <objc/runtime.h>

static char ly_limit;

@implementation UITextField (LYLimitCount)


- (void)setLy_limitCount:(NSInteger)ly_limitCount {
    objc_setAssociatedObject(self, &ly_limit, [NSString stringWithFormat:@"%ld", (long)ly_limitCount], OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
}

- (NSInteger)ly_limitCount {
    return [objc_getAssociatedObject(self, &ly_limit) integerValue];
}

- (void)changeText:(UITextField *)textField {
    NSString *toBeString = textField.text;
    NSString *lang = [textField textInputMode].primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        int chNum =0;
        for (int i=0; i<toBeString.length; ++i)
        {
            NSRange range = NSMakeRange(i, 1);
            NSString *subString = [toBeString substringWithRange:range];
            const char *cString = [subString UTF8String];
            if (cString == nil) {
                chNum ++;
            } else if (strlen(cString) == 3) {
                //                NSLog(@"汉字:%@",subString);
                chNum ++;
            }
        }
        if (!position) {
            if (toBeString.length > self.ly_limitCount) {
                textField.text = [toBeString substringToIndex:self.ly_limitCount];
            }
        }
    } else {
        if (toBeString.length > self.ly_limitCount) {
            textField.text = [toBeString substringToIndex:self.ly_limitCount];
        }
    }
}

/**
 设置占位符颜色
 
 @param color color description
 */
- (void)ly_placeholderColor:(UIColor *)color {    
    NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:color}];
    self.attributedText = arrStr;
}

@end
