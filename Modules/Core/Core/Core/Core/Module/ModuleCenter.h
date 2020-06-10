//
//  ModuleCenter.h
//  Core
//
//  Created by mac on 2020/5/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModuleCenter : NSObject

+ (instancetype)defaultCenter;

/// 获取到一个Module
/// @param name name description
- (id)getModule:(NSString *)name;

/// 获取模块服务协议
/// @param module 服务名字
/// @param protocol 协议名字
- (id)module:(NSString *)module protocol:(NSString *)protocol;

/// 移除服务
/// @param module 模块名字
- (void)removeModule:(NSString *)module;

/// 根据Url执行模块协议方法
/// @param url （scheme://Module/Protocol/Method?data=testData）
- (id)performServiceByUrl:(NSURL *)url;

/// 本地调用
/// @param module module description
/// @param protocol protocol description
/// @param method method description
/// @param params params description
- (id)performModule:(NSString *)module protocol:(NSString *)protocol method:(NSString *)method params:(id)params;

/// 检测特定的Application接口
/// @param selector SEL
/// @param arguments 参数对象
- (BOOL)checkAllServicesWithSelector:(SEL)selector arguments:(NSArray *)arguments;

@end

NS_ASSUME_NONNULL_END
