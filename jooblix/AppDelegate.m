//
//  AppDelegate.m
//  jooblix
//
//  Created by maxday on 2014-07-18.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DataUpdater.h"
#import "Constant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DataUpdater setUUID]; //setUUID if necessary
    
	// Let the device know we want to receive push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    
    // Override point for customization after application launch.
    
    ViewController *main = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:main];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];

    
    return YES;

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{

    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];

    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kToken];
    
    [DataUpdater sendUserToken]; //send token
    
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

@end
