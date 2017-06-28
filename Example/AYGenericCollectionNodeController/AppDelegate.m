//
//  AppDelegate.m
//  ARGenericTableView
//
//  Created by Jonas Stubenrauch on 04.04.13.
//  Copyright (c) 2013 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import "ExampleGenericTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    ExampleGenericTableViewController *exampleView = [[ExampleGenericTableViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:exampleView];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
@end
