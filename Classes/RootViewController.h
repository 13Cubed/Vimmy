//
//  RootViewController.h
//  Vimmy
//
//  Created by Richard Davis on 3/2/10.
//  Copyright 2012 13Cubed. All rights reserved.
//

#import "DetailViewController.h"
#define DONATE_URL  @"http://13cubed.com/donate/"

@protocol RootViewControllerDelegate;

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate> {
    id <RootViewControllerDelegate> delegate;
}

- (void)donate:(UIBarButtonItem *)donateButton;

@end
