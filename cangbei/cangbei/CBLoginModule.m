//
//  CBLoginModule.m
//  cangbei
//
//  Created by wangyang on 2020/6/10.
//  Copyright © 2020 stefenw. All rights reserved.
//

#import "CBLoginModule.h"
#import "ViewController.h"

@implementation CBLoginModule

- (void)openLoginVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = [ViewController new];
}

@end
