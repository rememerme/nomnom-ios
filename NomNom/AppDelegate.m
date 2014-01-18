//
//  AppDelegate.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "User.h"
#import "FriendsViewController.h"
#import "RootViewController.h"
#import "GameViewController.h"
#import "HomeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // for removing login info
    /*
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"session_id"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"date_created"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"last_modified"];    
    */
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] == nil &&
            [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"] == nil)  {
        ViewController *controller = [[ViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        self.window.rootViewController = navController;
    }
    else {
        User *user = [[User alloc]init];
        
        user.username = (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        user.user_id = (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        user.session_id = (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
        user.date_created = (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:@"date_created"];
        user.last_modified = (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:@"last_modified"];
        
        HomeViewController *home = [[HomeViewController alloc] initWithUser:user];
        //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:home];
        //self.window.rootViewController = navController;
        home.tabBarController = _tabBarController;
        _window.rootViewController = home;

        // need this last line to display the window (and tab bar controller)
        [_window addSubview:_tabBarController.view];
        
        [_window makeKeyAndVisible];
    }
    
    //[self.window makeKeyAndVisible];
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

@end
