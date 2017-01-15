//
//  VimmyAppDelegate.h
//  Vimmy
//
//  Created by Richard Davis on 3/2/10.
//  Copyright 2012 13Cubed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VimmyAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
