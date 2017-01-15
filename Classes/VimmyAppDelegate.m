//
//  VimmyAppDelegate.m
//  Vimmy
//
//  Created by Richard Davis on 3/2/10.
//  Copyright 2012 13Cubed. All rights reserved.
//

#import "VimmyAppDelegate.h"
#import "RootViewController.h"
#import "Appirater.h"

@implementation VimmyAppDelegate

@synthesize window;
@synthesize navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    self.window.rootViewController = self.navigationController;
    [window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
    
    [Appirater setAppId:@"361221825"];
    [Appirater setDaysUntilPrompt:1];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater appLaunched:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Save data if appropriate
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [Appirater appEnteredForeground:YES];
}

- (void)dealloc
{
    [navigationController release];
    [window release];
    [super dealloc];
}

@end
