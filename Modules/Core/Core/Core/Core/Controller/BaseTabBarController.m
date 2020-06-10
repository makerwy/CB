//
//  BaseTabBarController.m
//  Core
//
//  Created by mac on 2020/5/19.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "UIColor+LYHex.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  主页成为根数图控制器
 */
- (void)tabBarControllerWithControllers:(NSArray *)controllers
                         darkImageNames:(NSArray *)darkImageNames
                        lightImageNames:(NSArray *)lightImageNames
                            tabBarNames:(NSArray *)names {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i < controllers.count; i ++) {
        //图标
        UIImage * image1 = [UIImage imageNamed:lightImageNames [i]];
        image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * image2 = [UIImage imageNamed:darkImageNames [i]];;
        image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIViewController *vc = [NSClassFromString(controllers [i]) new];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [nav preferredStatusBarStyle];
        nav.tabBarItem.title = names [i];
        nav.tabBarItem.image = image2;
        nav.tabBarItem.selectedImage = image1;
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);
        [array addObject:nav];
        [nav.tabBarItem setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor ly_colorWithHexString:@"#F75305"],
          NSForegroundColorAttributeName,
          nil] forState:UIControlStateSelected];
    }
    
    self.viewControllers = array;
    self.tabBar.barTintColor = [UIColor whiteColor];
}

@end
