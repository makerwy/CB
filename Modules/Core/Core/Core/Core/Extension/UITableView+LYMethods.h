//
//  UITableView+LYMethods.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (LYMethods)

- (void)ly_registerCellNib:(NSString *)classString;
- (void)ly_registerCellClass:(NSString *)classString;
- (void)ly_registerCellHeaderFooterNib:(NSString *)classString;
- (void)ly_registerCellHeaderFooterClass:(NSString *)classString;
- (void)ly_estimatedHeight;

@end

NS_ASSUME_NONNULL_END
