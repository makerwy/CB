//
//  BaseViewController.m
//  Core
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 iule. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self backButton:@"iule_ic_back"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.fullScreenPopGestureEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -
#pragma mark - private methods

/**
 设置是否支持侧滑

 @param fullScreenPopGestureEnabled fullScreenPopGestureEnabled description
 */
- (void)setFullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    _fullScreenPopGestureEnabled = fullScreenPopGestureEnabled;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = fullScreenPopGestureEnabled;
        self.navigationController.interactivePopGestureRecognizer.delegate = fullScreenPopGestureEnabled ? self : nil;
    }
}

/**
 设置返回按钮

 @param backButton backButton description
 */
- (void)backButton:(NSString *)backButton {
    
}

#pragma mark -
#pragma mark - click Event

/**
 点击返回
 */
- (void)goback {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - system

/**
 系统状态栏

 @return return value description
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

/**
 是否隐藏状态栏

 @return return value description
 */
- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark -
#pragma mark - 关于旋转的设置

//是否自动旋转:所有控制器默认不自动旋转，需要横屏的视图控制器中覆写此方法，返回YES
- (BOOL)shouldAutorotate {
    return NO;
}

//支持哪些屏幕方向:只支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

//默认方向:只支持正常竖屏
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)dealloc {
    NSLog(@"%@被释放了",NSStringFromClass([self class]));
}

@end
