//
//  UITextView+LYPlaceholder.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (LYPlaceholder)

/** placeholdLabel */
@property(nonatomic,readonly)  UILabel * _Nonnull ly_placeholdLabel;
/** placeholder */
@property(nonatomic,copy) NSString *ly_placeholder;
/** placeholder颜色 */
@property(nonatomic,copy) UIColor *ly_placeholderColor;
/** 富文本 */
@property(nonnull,strong) NSAttributedString *ly_attributePlaceholder;
/** 位置 */
@property(nonatomic,assign) CGPoint ly_location;
/** 默认颜色 */
+ (UIColor *_Nullable)defaultColor;

@end

NS_ASSUME_NONNULL_END
