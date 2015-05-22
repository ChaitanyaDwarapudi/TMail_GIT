//
//  AppDelegate.m
//  TMail
//
//  Created by Eshwar Rao on 5/7/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import "AppDelegate.h"
#import "TMConstants.h"
#import "TMApplicationLog.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logRestAccesible:)
                                                 name:kREST_AccessibleNotification
                                               object:nil];

    
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
 
    //Initially result will be NO,Based on network status it may varies.
    //Whenever network is not available,messages will save locally and
    //result value  be set as YES or vise versa.
    BOOL result = [[NSUserDefaults standardUserDefaults] boolForKey:kIsMessageSavedLocally];
    if (result) {
        [[TMApplicationLog sharedLog] logSavedMessages];
    }
    else
    {
        [[TMApplicationLog sharedLog] Log:@""];
    }

}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark- Log Notifications

- (void)logRestAccesible:(NSNotification *) notification
{
    [[TMApplicationLog sharedLog] pushLogMessagesToServer];
}


@end
