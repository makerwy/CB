//
//  LoginModuleInterface.h
//  cangbei
//
//  Created by wangyang on 2020/6/10.
//  Copyright © 2020 stefenw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginModuleProtocol <NSObject>

@optional

- (void)openLoginVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

@end
