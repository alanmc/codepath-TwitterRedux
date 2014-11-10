//
//  AppDelegate.m
//  Twitter
//
//  Created by Alan McConnell on 11/1/14.
//  Copyright (c) 2014 Alan McConnell. All rights reserved.
//

#import "AppDelegate.h"
#import "SlidableMenuViewController.h"
#import "MenuViewController.h"
#import "LoginViewController.h"
#import "FeedViewController.h"
#import "TwitterClient.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onLogout)
                                                 name:UserDidLogoutNotif
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onLogin)
                                                 name:UserDidLoginNotif
                                               object:nil];
    User *user = [User currentUser];
    if (user != nil) {
        FeedViewController *fvc = [[FeedViewController alloc] init];
        MenuViewController *mvc = [[MenuViewController alloc] init];
        
        UINavigationController *nmvc = [[UINavigationController alloc] initWithRootViewController:mvc];
        UINavigationController *nfvc = [[UINavigationController alloc] initWithRootViewController:fvc];
        
        SlidableMenuViewController *svc = [[SlidableMenuViewController alloc] initWithMenuViewController:nmvc contentViewController:nfvc];
        mvc.slidableMenuController = svc;
        
        self.window.rootViewController = svc;
    } else {
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
    

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)onLogout {
    self.window.rootViewController = [[LoginViewController alloc] init];
}

- (void)onLogin {
    FeedViewController *fvc = [[FeedViewController alloc] init];
    MenuViewController *mvc = [[MenuViewController alloc] init];
    
    UINavigationController *nmvc = [[UINavigationController alloc] initWithRootViewController:mvc];
    UINavigationController *nfvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    SlidableMenuViewController *svc = [[SlidableMenuViewController alloc] initWithMenuViewController:nmvc contentViewController:nfvc];
    self.window.rootViewController = svc;
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[TwitterClient sharedInstance] openURL:url];
    return YES;
}

@end
