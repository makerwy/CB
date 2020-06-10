//
//  UIView+LYCategory.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYCategory)

#pragma mark -
#pragma mark - 关于位置

/**
 * 获取视图 x 坐标
 *
 *  @return x 坐标
 */
@property (nonatomic, assign) CGFloat ly_x;

/**
 * 获取视图 y 坐标
 *
 *  @return y 坐标
 */
@property (nonatomic, assign) CGFloat ly_y;

/**
 * 获取视图 宽度
 *
 *  @return 宽度
 */
@property (nonatomic, assign) CGFloat ly_width;

/**
 * 获取视图 高度
 *
 *  @return 高度
 */
@property (nonatomic, assign) CGFloat ly_height;

/**
 *  获取视图 中心点 X
 *
 *  @return center.x
 */
@property (nonatomic, assign) CGFloat ly_centerX;

/**
 *  获取视图 中心点 Y
 *
 *  @return center.y
 */
@property (nonatomic, assign) CGFloat ly_centerY;

/**
* 获取视图 最右边 距 父视图左边 距离
*
*  @return 距离
*/
@property (nonatomic, assign) CGFloat ly_maxX;

/**
* 获取视图 最下边 距 父视图上边 距离
*
*  @return 距离
*/
@property (nonatomic, assign) CGFloat ly_maxY;


#pragma mark -
#pragma mark - 关于设置圆角

/**
 *  切圆
 */
- (void)ly_fillCorner;
/**
 *  切指定圆角
 *
 *  @param radius 圆角半径
 */
- (void)ly_cornerWithRadius:(CGFloat)radius;
/**
 *  设置边框
 *
 *  @param radius      半径
 *  @param borderWidth 边框宽度
 *  @param colorString 边框颜色 6位16进制字符串
 */
- (void)ly_borderWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(NSString *)colorString;

#pragma mark -
#pragma mark - 关于画线

/**
 *  画线
 *
 *  @param top   居上
 *  @param left  居左
 *  @param right 居右
 */
- (void)ly_lineFromTop:(float)top left:(float)left toRight:(float)right;
/**
 *  上部横线
 */
- (void)ly_topLine;
/**
 *  下部横线
 */
- (void)ly_bottomLine;

/**
 颜色 透明度 半径 偏移
 
 @param colorString 1
 @param opacity 1
 @param radius 1
 @param offset 1
 */
- (void)ly_shadowColorString:(NSString *)colorString opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

/**
 设置阴影
 
 @param color color description
 @param opacity opacity description
 @param radius radius description
 @param offset offset description
 */
- (void)ly_shadowColor:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

#pragma mark
#pragma mark -- XIB

@property(assign, nonatomic) IBInspectable CGFloat ly_radius;
@property(assign, nonatomic) IBInspectable CGFloat ly_borderWidth;
@property(strong, nonatomic) IBInspectable UIColor *ly_borderColor;

@property(assign, nonatomic) IBInspectable CGFloat ly_shadowRadius;
@property(strong, nonatomic) IBInspectable UIColor *ly_shadowColor;
@property(assign, nonatomic) IBInspectable CGFloat ly_shadowOpacity;
@property(assign, nonatomic) IBInspectable CGSize ly_shadowOffset;

+ (instancetype)ly_loadXib;
@end

NS_ASSUME_NONNULL_END
