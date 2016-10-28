//
//  AppDelegate.m
//  TDYAppDocuments
//
//  Created by 唐道勇 on 16/10/28.
//  Copyright © 2016年 唐道勇. All rights reserved.
//
/*
 打印沙盒中的各种路径
 */
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //打印沙盒目录
    NSLog(@"沙盒目录NSHomeDirectory() = %@", NSHomeDirectory());
    //打印Myapp.app目录
    NSLog(@"Myapp.app目录 = %@", [[NSBundle mainBundle] bundlePath]);
    //打印tmp路径
    NSLog(@"tmp路径 = %@", NSTemporaryDirectory());
    //打印Documents路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    for (NSString *path in paths) {
        NSLog(@"path = %@", path);
    }
    //打印Library
    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    for (NSString *path in libraryPaths) {
        NSLog(@"path = %@", path);
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
