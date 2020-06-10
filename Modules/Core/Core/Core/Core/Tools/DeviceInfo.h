//
//  DeviceInfo.h
//  Core
//
//  Created by wangyang on 2020/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceInfo : NSObject
@property (nonatomic, copy) NSString *brand;//设备品牌
@property (nonatomic, copy) NSString *model;//设备型号
@property (nonatomic, copy) NSString *language;//设置的语言
@property (nonatomic, copy) NSString *version;//版本号
@property (nonatomic, copy) NSString *system;//操作系统及版本
@property (nonatomic, copy) NSString *platform;//客户端平台
@property (nonatomic, copy) NSString *SDKVersion;//客户端基础库版本
@property (nonatomic, assign) CGFloat pixelRatio;//设备像素比
@property (nonatomic, assign) CGFloat screenWidth;//屏幕宽度，单位px
@property (nonatomic, assign) CGFloat screenHeight;//屏幕高度，单位px
@property (nonatomic, assign) CGFloat windowWidth;//可使用窗口宽度，单位px
@property (nonatomic, assign) CGFloat windowHeight;//可使用窗口高度，单位px
@property (nonatomic, assign) CGFloat statusBarHeight;//状态栏的高度，单位px
@property (nonatomic, assign) CGFloat fontSizeSetting;//用户字体大小（单位px）。以微信客户端「我-设置-通用-字体大小」中的设置为准

+ (DeviceInfo *)deviceInfo;
+ (NSDictionary *)deviceInfoKeyValues;

/// 获取设备唯一标识
+ (NSString *)getDeviceId;

/// 获取设备唯一标识
+ (NSString *)getChannel;

@end

NS_ASSUME_NONNULL_END
