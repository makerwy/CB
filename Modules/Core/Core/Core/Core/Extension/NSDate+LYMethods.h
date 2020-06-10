//
//  NSDate+LYMethods.h
//  LYProject
//
//  Created by mac on 2019/11/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LYMethods)

- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isBeforeYesterday;

@end

NS_ASSUME_NONNULL_END
