//
//  BaseTabBarController.h
//  Core
//
//  Created by mac on 2020/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabBarController : UITabBarController

/**
 *  主页成为根数图控制器
 */
- (void)tabBarControllerWithControllers:(NSArray *)controllers
                         darkImageNames:(NSArray *)darkImageNames
                        lightImageNames:(NSArray *)lightImageNames
                            tabBarNames:(NSArray *)names;
@end

NS_ASSUME_NONNULL_END
