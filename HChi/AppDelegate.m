//
//  AppDelegate.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "IssueViewController.h"
#import "PersonViewController.h"
#import "HCGlobalVariable.h"
#import "HCTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    
    [self initHCGV];
    
    UINavigationController * rootView =[[UINavigationController alloc] initWithRootViewController: [RootViewController new]];
    UINavigationController * issueView = [[UINavigationController alloc] initWithRootViewController: [IssueViewController new]];
    UINavigationController * settingView = [[UINavigationController alloc] initWithRootViewController: [PersonViewController new]];
    NSArray * viewArray = @[rootView, issueView, settingView];
    
    HCTabBarController * tabBarController = [HCTabBarController new];
    [tabBarController setViewControllers: viewArray];
    
//    UITabBarController * tabBarController = [UITabBarController new];
//    [tabBarController setViewControllers: viewArray];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    
    
    // 导航栏颜色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    // 导航栏按钮颜色
    [[UINavigationBar appearance] setTintColor:HCColorForTheme];
    // 去除Nav 下划线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    // 自定义背景
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new]
                                       forBarMetrics:UIBarMetricsDefault];
    // 设置底部菜单选中颜色
//    tabBarController.tabBar.tintColor = HCColorForTheme;
    
    return YES;
}

/// 初始化全局变量
- (void)initHCGV {
    
    ScreenSize = [UIScreen mainScreen].bounds.size;
    
    HCColorForTheme = [UIColor colorWithRed:0.39 green:0.60 blue:0.0 alpha:1.0];
    HCColorForSubView = [UIColor colorWithWhite:1.0 alpha:1.0];
    HCColorForRootView = [UIColor colorWithWhite:0.0 alpha:0.6];
    
    // RootView
    HCNCBackgroundForRootView = [CAGradientLayer layer];
    HCNCBackgroundForRootView.frame = CGRectMake(0, -20, ScreenSize.width, 64);
    
    HCNCBackgroundForRootView.colors = @[(id)HCColorForRootView.CGColor,
                                         (id)[HCColorForRootView colorWithAlphaComponent:0.4].CGColor,
                                         (id)[HCColorForRootView colorWithAlphaComponent:0.1].CGColor,
                                         (id)[HCColorForRootView colorWithAlphaComponent:0.0].CGColor];
    HCNCBackgroundForRootView.locations = @[@(0.1), @(0.4), @(0.6), @(1.0)];
    
    // SubView
    HCNCBackgroundForSubView = [UIImageView new];
    HCNCBackgroundForSubView.backgroundColor = HCColorForSubView;
    HCNCBackgroundForSubView.frame = CGRectMake(0, -20, ScreenSize.width, 64);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
