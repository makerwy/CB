//
//  UITableView+LYMethods.m
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UITableView+LYMethods.h"

@implementation UITableView (LYMethods)

- (void)ly_registerCellNib:(NSString *)classString {
    [self registerNib:[UINib nibWithNibName:classString bundle:nil] forCellReuseIdentifier:classString];
}
- (void)ly_registerCellClass:(NSString *)classString {
    [self registerClass:NSClassFromString(classString) forCellReuseIdentifier:classString];
}
- (void)ly_registerCellHeaderFooterNib:(NSString *)classString {
    [self registerNib:[UINib nibWithNibName:classString bundle:nil] forHeaderFooterViewReuseIdentifier:classString];
}
- (void)ly_registerCellHeaderFooterClass:(NSString *)classString {
    [self registerClass:NSClassFromString(classString) forHeaderFooterViewReuseIdentifier:classString];
}
- (void)ly_estimatedHeight {
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
}

@end
