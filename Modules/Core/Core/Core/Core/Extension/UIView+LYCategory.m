//
//  UIView+LYCategory.m
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIView+LYCategory.h"
#import "UIColor+LYHex.h"

@implementation UIView (LYCategory)

@dynamic ly_x,ly_y,ly_width,ly_height,ly_centerX,ly_centerY;

#pragma mark -
#pragma mark - 关于位置

/**
 * 获取视图 x 坐标
 *
 *  @return x 坐标
 */
- (CGFloat)ly_x {
    return self.frame.origin.x;
}

/**
 设置视图 x 坐标

 @param ly_x ly_x description
 */
- (void)setLy_x:(CGFloat)ly_x {
    CGRect frame = self.frame;
    frame.origin.x = ly_x;
    self.frame = frame;
}

/**
 * 获取视图 y 坐标
 *
 *  @return y 坐标
 */
- (CGFloat)ly_y {
    return self.frame.origin.y;
}

/**
 设置视图 y 坐标

 @param ly_y ly_y description
 */
- (void)setLy_y:(CGFloat)ly_y {
    CGRect frame = self.frame;
    frame.origin.y = ly_y;
    self.frame = frame;
}

/**
 * 获取视图 宽度
 *
 *  @return 宽度
 */
- (CGFloat)ly_width {
    return self.frame.size.width;
}

/**
 设置视图 宽度

 @param ly_width ly_width description
 */
- (void)setLy_width:(CGFloat)ly_width {
    CGRect frame = self.frame;
    frame.size.width = ly_width;
    self.frame = frame;
}

/**
 * 获取视图 高度
 *
 *  @return 高度
 */
- (CGFloat)ly_height {
    return self.frame.size.height;
}

/**
 设置视图 高度

 @param ly_height ly_height description
 */
- (void)setLy_height:(CGFloat)ly_height {
    CGRect frame = self.frame;
    frame.size.height = ly_height;
    self.frame = frame;
}

/**
 *  获取视图 中心点 X
 *
 *  @return center.x
 */
- (CGFloat)ly_centerX {
    return self.center.x;
}

/**
 设置视图 中心点 X
 
 @param ly_centerX ly_centerX description
 */
- (void)setLy_centerX:(CGFloat)ly_centerX {
    CGPoint center = self.center;
    center.x = ly_centerX;
    self.center = center;
}

/**
 *  获取视图 中心点 Y
 *
 *  @return center.y
 */
- (CGFloat)ly_centerY {
    return self.center.y;
}

/**
 设置视图 中心点 Y

 @param ly_centerY ly_centerY description
 */
- (void)setLy_centerY:(CGFloat)ly_centerY {
    CGPoint center = self.center;
    center.y = ly_centerY;
    self.center = center;
}

/**
 * 获取视图 最右边距屏幕左边的距离
 *
 *  @return 距离
 */
- (CGFloat)ly_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setLy_maxX:(CGFloat)ly_maxX {
    CGRect newFrame   = self.frame;
    newFrame.origin.x = ly_maxX - self.frame.size.width;
    self.frame        = newFrame;
}

/**
 * 获取视图 最下边距屏幕左边的距离
 *
 *  @return 距离
 */
- (CGFloat)ly_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setLy_maxY:(CGFloat)ly_maxY {
    CGRect newFrame   = self.frame;
    newFrame.origin.y = ly_maxY - self.frame.size.height;
    self.frame        = newFrame;
}

#pragma mark -
#pragma mark - 关于设置圆角

/**
 *  切圆
 */
- (void)ly_fillCorner {
    self.layer.cornerRadius = self.frame.size.width / 2.0;
    self.layer.masksToBounds = YES;
}

/**
 *  切指定圆角
 *
 *  @param radius 圆角半径
 */
- (void)ly_cornerWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

/**
 *  设置边框
 *
 *  @param radius      半径
 *  @param borderWidth 边框宽度
 *  @param colorString 边框颜色 6位16进制字符串
 */
- (void)ly_borderWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(NSString *)colorString {
    self.layer.borderColor = [UIColor ly_colorWithHexString:colorString].CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

/**
 设置阴影
 
 @param colorString colorString description
 @param opacity opacity description
 @param radius radius description
 @param offset offset description
 */
- (void)ly_shadowColorString:(NSString *)colorString opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    self.layer.shadowColor = [UIColor ly_colorWithHexString:colorString].CGColor; /// 阴影颜色
    self.layer.shadowOpacity = opacity; /// 阴影透明度
    self.layer.shadowRadius = radius; /// 阴影半径 默认 3
    self.layer.shadowOffset = offset; /// 向右 向下 偏移
}

/**
 设置阴影
 
 @param color color description
 @param opacity opacity description
 @param radius radius description
 @param offset offset description
 */
- (void)ly_shadowColor:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    self.layer.shadowColor = color.CGColor; /// 阴影颜色
    self.layer.shadowOpacity = opacity; /// 阴影透明度
    self.layer.shadowRadius = radius; /// 阴影半径 默认 3
    self.layer.shadowOffset = offset; /// 向右 向下 偏移
}

#pragma mark -
#pragma mark - 关于画线

/**
 *  画线
 *
 *  @param top   居上
 *  @param left  居左
 *  @param right 居右
 */
- (void)ly_lineFromTop:(float)top left:(float)left toRight:(float)right {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor ly_colorWithHexString:@"e5e5e5"].CGColor;
    layer.frame = CGRectMake(left, top, [self ly_width] - left - right, 0.5);
    [self.layer addSublayer:layer];
}
/**
 *  上部横线
 */
- (void)ly_topLine {
    [self ly_lineFromTop:0 left:0 toRight:0];
}
/**
 *  下部横线
 */
- (void)ly_bottomLine {
    [self ly_lineFromTop:[self ly_height] - 0.5  left:0 toRight:0];
}

#pragma mark
#pragma mark -- XIB

- (void)setLy_radius:(CGFloat)ly_radius {
    self.layer.cornerRadius = ly_radius;
    self.layer.masksToBounds = YES;
}
- (CGFloat)ly_radius {
    return self.layer.cornerRadius;
}
- (void)setLy_borderWidth:(CGFloat)ly_borderWidth {
    self.layer.borderWidth = ly_borderWidth;
}
- (CGFloat)ly_borderWidth {
    return self.layer.borderWidth;
}
- (void)setLy_borderColor:(UIColor *)ly_borderColor {
    self.layer.borderColor = ly_borderColor.CGColor;
    self.layer.masksToBounds = YES;
}
- (UIColor *)ly_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setLy_shadowRadius:(CGFloat)ly_shadowRadius {
    self.layer.shadowRadius = ly_shadowRadius;
}
- (CGFloat)ly_shadowRadius {
    return self.layer.shadowRadius;
}
- (void)setLy_shadowColor:(UIColor *)ly_shadowColor {
    self.layer.shadowColor = ly_shadowColor.CGColor;
}
- (UIColor *)ly_shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
- (void)setLy_shadowOffset:(CGSize)ly_shadowOffset {
    self.layer.shadowOffset = ly_shadowOffset;
}
- (CGSize)ly_shadowOffset {
    return self.layer.shadowOffset;
}
- (void)setLy_shadowOpacity:(CGFloat)ly_shadowOpacity {
    self.layer.shadowOpacity = ly_shadowOpacity;
}
- (CGFloat)ly_shadowOpacity {
    return self.layer.shadowOpacity;
}

+ (instancetype)ly_loadXib {
    return [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}
@end
