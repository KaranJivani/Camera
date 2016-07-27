//
//  AppDelegate.m
//  Homepwner
//
//  Created by Karan Jivani on 7/16/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "AppDelegate.h"
#import "KRNItemsViewController.h"
#import "KRNItemStore.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
        NSLog(@"%@", NSStringFromSelector(_cmd));
    
    KRNItemsViewController *itemsViewController = [[KRNItemsViewController alloc]init];

    //Create an instance of a UINavigationController
    //Its stack contains only itemViewController
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:itemsViewController];
    //Place navigation controllers view in hierarchy
    self.window.rootViewController = navController;
//    self.window.rootViewController = itemsViewController;
    
        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
        NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    BOOL success = [[KRNItemStore sharedStore]saveChanges];
    
    if (success) {
        NSLog(@"saved all of the KRNItems");
    }
    else {
        NSLog(@"could not save any of the KRNItems");
    }
    
        NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
