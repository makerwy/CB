//
//  UITextView+LYPlaceholder.m
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UITextView+LYPlaceholder.h"
#import <objc/runtime.h>
#import "UIColor+LYHex.h"

static char *labelKey = "ly_placeholderKey";
static char *needAdjust = "ly_needAdjust";
static char *changeLocation = "ly_location";

@implementation UITextView (LYPlaceholder)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self.class,NSSelectorFromString(@"dealloc") ),class_getInstanceMethod(self.class, NSSelectorFromString(@"swizzledDealloc")));
}

- (void)swizzledDealloc {
    // 移除观察
    if (objc_getAssociatedObject(self, @selector(ly_placeholdLabel))) [self removeObserver:self forKeyPath:@"font"];
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self swizzledDealloc];
}

#pragma mark -   设置placeholderLabel
- (UILabel *)ly_placeholdLabel {
    UILabel *label = objc_getAssociatedObject(self, labelKey);
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.textColor = [self.class defaultColor];
        
        objc_setAssociatedObject(self, labelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:UITextViewTextDidChangeNotification object:nil];
        //监听font的变化
        [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
    }
    return label;
}

#pragma mark -  设置默认颜色
+ (UIColor *)defaultColor {
    static UIColor *color = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        color = [UIColor ly_colorWithHexString:@"999999"];
    });
    return color;
}

#pragma mark - set get methods

- (void)setLy_placeholder:(NSString *)ly_placeholder {
    self.ly_placeholdLabel.text = ly_placeholder;
    [self updateLabel];
}

- (NSString *)ly_placeholder {
    return self.ly_placeholdLabel.text;
}

- (void)setLy_placeholderColor:(UIColor *)ly_placeholderColor {
    self.ly_placeholdLabel.textColor = ly_placeholderColor;
    [self updateLabel];
}

- (UIColor *)ly_placeholderColor {
    return self.ly_placeholdLabel.textColor;
}

- (void)setLy_attributePlaceholder:(NSAttributedString *)ly_attributePlaceholder {
    self.ly_placeholdLabel.attributedText = ly_attributePlaceholder;
    [self updateLabel];
}

- (NSAttributedString *)ly_attributePlaceholder {
    return self.ly_placeholdLabel.attributedText;
}

- (void)setLy_location:(CGPoint)ly_location {
    objc_setAssociatedObject(self, changeLocation,NSStringFromCGPoint(ly_location), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLabel];
}

- (CGPoint)ly_location {
    return CGPointFromString(objc_getAssociatedObject(self, changeLocation));
}

#pragma mark - 是否需要调整字体
- (BOOL)needAdjustFont {
    return [objc_getAssociatedObject(self, needAdjust) boolValue];
}

- (void)setNeedAdjustFont:(BOOL)needAdjustFont {
    objc_setAssociatedObject(self, needAdjust, @(needAdjustFont), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - observer font KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"font"]) {
        self.needAdjustFont = YES;
        self.ly_placeholdLabel.font = self.font;
        [self updateLabel];
    }
}

#pragma mark -  更新label信息
- (void)updateLabel {
    if (self.text.length) {
        [self.ly_placeholdLabel removeFromSuperview];
        return;
    }
    
    //显示label
    [self insertSubview:self.ly_placeholdLabel atIndex:0];
    
    // 是否需要更新字体（NO 采用默认字体大小）
    if (self.needAdjustFont) {
        self.ly_placeholdLabel.font = self.font;
        self.needAdjustFont = NO;
    }
    
    CGFloat lineFragmentPadding =  self.textContainer.lineFragmentPadding;  //边距
    UIEdgeInsets contentInset = self.textContainerInset;
    
    //设置label frame
    CGFloat labelX = lineFragmentPadding + contentInset.left;
    CGFloat labelY = contentInset.top;
    
    if (self.ly_location.x != 0 || self.ly_location.y != 0) {
        if (self.ly_location.x < 0 || self.ly_location.x > CGRectGetWidth(self.bounds) - lineFragmentPadding - contentInset.right || self.ly_location.y< 0) {
            // 不做处理
        }else{
            labelX += self.ly_location.x;
            labelY += self.ly_location.y;
        }
    }
    
    CGFloat labelW = CGRectGetWidth(self.bounds) - contentInset.right - labelX;
    CGFloat labelH = [self.ly_placeholdLabel sizeThatFits:CGSizeMake(labelW, MAXFLOAT)].height;
    self.ly_placeholdLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

@end
