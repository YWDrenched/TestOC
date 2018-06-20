//
//  AppDelegate.m
//  01-抽屉控制器
//
//  Created by cyw on 2017/2/7.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "rightViewController.h"
#import "centerViewController.h"
#import "leftViewController.h"
#import "MainNavViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

//    左中右三个控制器
    rightViewController *rightVc = [[rightViewController alloc] init];
    leftViewController *leftVc = [[leftViewController alloc] init];
    centerViewController *centerVc = [[centerViewController alloc] init];
    
//    导航控制器
    MainNavViewController *rightNavVc = [[MainNavViewController alloc] initWithRootViewController:rightVc];
    MainNavViewController *leftNavVc = [[MainNavViewController alloc] initWithRootViewController:leftVc];
    MainNavViewController *centerNavVc = [[MainNavViewController alloc] initWithRootViewController:centerVc];
    
//    抽屉控制器
    self.mmDrawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNavVc leftDrawerViewController:leftNavVc rightDrawerViewController:rightNavVc];
//    关闭模式手势
    self.mmDrawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
//    打开模式手势
    self.mmDrawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
//    抽屉控制器的最长宽度
    self.mmDrawerController.maximumLeftDrawerWidth = 200;
    
    [self.window makeKeyAndVisible];
    self.window.rootViewController = self.mmDrawerController;
    
    return YES;
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
