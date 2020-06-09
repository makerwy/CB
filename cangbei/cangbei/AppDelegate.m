//
//  AppDelegate.m
//  cangbei
//
//  Created by wangyang on 2020/6/10.
//  Copyright © 2020 stefenw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    id<LoginModuleProtocol> module = [[ModuleCenter defaultCenter] getModule:@"CBLogin"];
    if (module) {
        [module openLoginVC:@{} completeHandler:^{
            //
        }];
    }
    
    return YES;
}

@end
