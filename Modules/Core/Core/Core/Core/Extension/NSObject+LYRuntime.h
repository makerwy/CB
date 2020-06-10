//
//  NSObject+LYRuntime.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LYRuntime)

/**
 获取对象所有属性
 
 @return return value description
 */
- (NSArray *)ly_getAllProperties;

/**
 获取对象所有方法
 
 @return return value description
 */
- (NSArray *)ly_getAllMethods;

/**
 获取对象的所有属性和属性内容
 
 @return return value description
 */
- (NSDictionary *)ly_getAllPropertiesAndVaules;

@end

NS_ASSUME_NONNULL_END
