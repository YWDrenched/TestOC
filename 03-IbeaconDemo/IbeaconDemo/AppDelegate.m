//
//  AppDelegate.m
//  IbeaconDemo
//
//  Created by AnRu on 2017/3/7.
//  Copyright © 2017年 anru. All rights reserved.
//

#import "AppDelegate.h"
#import "ANPeripheralManager.h"

@interface AppDelegate ()
{
    //一个后台任务标识符
    UIBackgroundTaskIdentifier taskID;
}
@property (nonatomic,strong) ANPeripheralManager * p;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didEnterBackground" object:nil];
    taskID = [application beginBackgroundTaskWithExpirationHandler:^{
    //如果系统觉得我们还是运行了太久，将执行这个程序块，并停止运行应用程序
        [application endBackgroundTask:taskID];
    }];
    //UIBackgroundTaskInvalid表示系统没有为我们提供额外的时候
    if (taskID == UIBackgroundTaskInvalid) {
            NSLog(@"Failed to start background task!");
        return;
    }
    NSLog(@"Starting background task with %f seconds remaining", application.backgroundTimeRemaining);
    self.p = [ANPeripheralManager sharedPeripheralManager];
    [self.p startAdvert];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"willEnterForeground" object:nil];
    NSLog(@"Finishing background task ");
        //告诉系统结束任务
        [application endBackgroundTask:taskID];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
