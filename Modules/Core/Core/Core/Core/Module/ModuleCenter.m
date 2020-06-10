//
//  ModuleCenter.m
//  Core
//
//  Created by mac on 2020/5/18.
//

#import "ModuleCenter.h"
#import "BaseModule.h"

@interface ModuleCenter()
@property (nonatomic, strong) NSMutableDictionary *modules;

@end

@implementation ModuleCenter

+ (instancetype)defaultCenter {
    static ModuleCenter *moduleCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        moduleCenter = [[ModuleCenter alloc] init];
    });
    return moduleCenter;
}

/// 获取到一个模块服务Module
/// @param name name description
- (id)getModule:(NSString *)name {
    BaseModule *module = [self.modules objectForKey:name];
    if(!module) {
        Class class = NSClassFromString([NSString stringWithFormat:@"%@Module",name]);
        if(class) {
            module = [class new];
            if([module isKindOfClass:[BaseModule class]]) {
                [self.modules setValue:module forKey:name];
                return module;
            }
        }else {
            NSLog(@"err ==> module: %@ is not exsit!",name);
        }
    }
    return module;
}

/// 获取模块服务协议
/// @param module 服务名字
/// @param protocol 协议名字
- (id)module:(NSString *)module protocol:(NSString *)protocol  {
    if(module && protocol){
        BaseModule *tmpModule = [self getModule:module];
        if (tmpModule) {
            id tempProtocol = NSProtocolFromString(protocol);
            if ([tmpModule conformsToProtocol:tempProtocol]) {
                return tmpModule;
            }else {
                NSLog(@"err ==> module: %@ protocol: %@ is not implement!",module ,protocol);
            }
        }else {
            NSLog(@"err ==> module: %@ is empty !",module);
        }
    }
    return nil;
}

/// 移除模块
/// @param module 模块名字
- (void)removeModule:(NSString *)module {
    BaseModule *tmpModule = [self.modules objectForKey:module];
    if(tmpModule){
        [self.modules removeObjectForKey:tmpModule];
        NSLog(@"msg ==> remove module: %@ success!",tmpModule);
    }
}

/// 根据Url执行模块协议方法
/// @param url （scheme://Module/Protocol/Method?data=testData）
- (id)performServiceByUrl:(NSURL *)url {
    NSString *moduleName = url.host;
    if(moduleName){
        NSArray <NSString *>*paths = [self urlToPaths:url];
        if(paths && paths.count == 2){
            NSDictionary* params = [self urlToParams:url];
            return [self performModule:moduleName protocol:paths[0] method:paths[1] params:params];
        }
    }
    return nil;
}

/// 本地调用
/// @param module module description
/// @param protocol protocol description
/// @param method method description
/// @param params params description
- (id)performModule:(NSString *)module protocol:(NSString *)protocol method:(NSString *)method params:(id)params {
    if(module && protocol && method) {
        BaseModule *tmpModule = [self getModule:module];
        if(tmpModule) {
            id tempProtocol = NSProtocolFromString(protocol);
            if (tempProtocol) {
                if([tmpModule conformsToProtocol:tempProtocol]) {
                    SEL action = [self methodToSEL:method];
                    if ([tmpModule respondsToSelector:action]) {
                        return [self safePerformAction:action target:tmpModule params:params];
                    }else {
                        NSLog(@"err ==> perform method: %@ for module: %@ protocol: %@ is not implement!",method,module,protocol);
                    }
                }else {
                    NSLog(@"err ==> perform method: %@ for module: %@ protocol: %@ is not responds!",method,module,protocol);
                }
            }else {
                NSLog(@"err ==> perform method: %@ for module: %@ protocol: %@ is not conforms protocol!",method,module,protocol);
            }
        }else {
            NSLog(@"err ==> perform method: %@ for module: %@ protocol: %@ is empty!",method,module,protocol);
        }
    }else {
        NSLog(@"err ==> perform method: %@ for module: %@ protocol: %@ is failed!",method,module,protocol);
    }
    return nil;
}

/// 检测特定的Application接口
/// @param selector SEL
/// @param arguments 参数对象
- (BOOL)checkAllServicesWithSelector:(SEL)selector arguments:(NSArray *)arguments {
    BOOL result = NO;
    NSArray *services = [self.modules allValues];
    for (BaseModule *module in services) {
        if ([module respondsToSelector:selector]) {
            [self invokeTarget:module action:selector arguments:arguments returnValue:&result];
        }
    }
    return result;
}

/// 解析URL path
/// @param url url description
- (NSArray<NSString *> *)urlToPaths:(NSURL *)url {
    NSString *path = url.path;
    if(path){
        path = [path substringFromIndex:1];
        return [path componentsSeparatedByString:@"/"];
    }
    return nil;
}

/// 解析URL params
/// @param url url description
- (NSMutableDictionary *)urlToParams:(NSURL *)url {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    return params;
}

- (SEL)methodToSEL:(NSString *)method {
    return NSSelectorFromString([NSString stringWithFormat:@"%@:",method]);
}

- (BOOL)invokeTarget:(id)target
              action:(_Nonnull SEL)selector
           arguments:(NSArray* _Nullable)arguments
         returnValue:(void* _Nullable)result {
    if (target && [target respondsToSelector:selector]) {
        NSMethodSignature *sig = [target methodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setTarget:target];
        [invocation setSelector:selector];
        for (NSUInteger i = 0; i<[arguments count]; i++) {
            NSUInteger argIndex = i+2;
            id argument = arguments[i];
            if ([argument isKindOfClass:NSNumber.class]) {
                //convert number object to basic num type if needs
                BOOL shouldContinue = NO;
                NSNumber *num = (NSNumber*)argument;
                const char *type = [sig getArgumentTypeAtIndex:argIndex];
                if (strcmp(type, @encode(BOOL)) == 0) {
                    BOOL rawNum = [num boolValue];
                    [invocation setArgument:&rawNum atIndex:argIndex];
                    shouldContinue = YES;
                } else if (strcmp(type, @encode(int)) == 0
                           || strcmp(type, @encode(short)) == 0
                           || strcmp(type, @encode(long)) == 0) {
                    NSInteger rawNum = [num integerValue];
                    [invocation setArgument:&rawNum atIndex:argIndex];
                    shouldContinue = YES;
                } else if(strcmp(type, @encode(long long)) == 0) {
                    long long rawNum = [num longLongValue];
                    [invocation setArgument:&rawNum atIndex:argIndex];
                    shouldContinue = YES;
                } else if (strcmp(type, @encode(unsigned int)) == 0
                           || strcmp(type, @encode(unsigned short)) == 0
                           || strcmp(type, @encode(unsigned long)) == 0) {
                    NSUInteger rawNum = [num unsignedIntegerValue];
                    [invocation setArgument:&rawNum atIndex:argIndex];
                    shouldContinue = YES;
                } else if(strcmp(type, @encode(unsigned long long)) == 0) {
                    unsigned long long rawNum = [num unsignedLongLongValue];
                    [invocation setArgument:&rawNum atIndex:argIndex];
                    shouldContinue = YES;
                } else if (strcmp(type, @encode(float)) == 0) {
                    float rawNum = [num floatValue];
                    [invocation setArgument:&rawNum atIndex:argIndex];
                    shouldContinue = YES;
                } else if (strcmp(type, @encode(double)) == 0) { // double
                    double rawNum = [num doubleValue];
                    [invocation setArgument:&rawNum atIndex:argIndex];
                    shouldContinue = YES;
                }
                if (shouldContinue) {
                    continue;
                }
            }
            if ([argument isKindOfClass:[NSNull class]]) {
                argument = nil;
            }
            [invocation setArgument:&argument atIndex:argIndex];
        }
        [invocation invoke];
        NSString *methodReturnType = [NSString stringWithUTF8String:sig.methodReturnType];
        if (result && ![methodReturnType isEqualToString:@"v"]) { //if return type is not void
            if([methodReturnType isEqualToString:@"@"]) { //if it's kind of NSObject
                CFTypeRef cfResult = nil;
                [invocation getReturnValue:&cfResult]; //this operation won't retain the result
                if (cfResult) {
                    CFRetain(cfResult); //we need to retain it manually
                    *(void**)result = (__bridge_retained void *)((__bridge_transfer id)cfResult);
                }
            } else {
                [invocation getReturnValue:result];
            }
        }
        return YES;
    }
    return NO;
}

- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params
{
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil) {
        return nil;
    }
    const char* retType = [methodSig methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

#pragma mark -
#pragma mark - lazy

- (NSMutableDictionary *)modules {
    if(!_modules){
        _modules = @{}.mutableCopy;
    }
    return _modules;
}

@end
