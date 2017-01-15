//
//  DetailViewController.h
//  Vimmy
//
//  Created by Richard Davis on 3/2/10.
//  Copyright 2012 13Cubed. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailViewControllerDelegate;

@interface DetailViewController : UIViewController <UIWebViewDelegate> {
    id <DetailViewControllerDelegate> delegate;
    IBOutlet UIView *detailView;
    IBOutlet UINavigationBar *detailViewNavBar;
    IBOutlet UINavigationItem *detailViewNavItem;
    IBOutlet UILabel *detailViewLabel;
}

@property (nonatomic, assign) id <DetailViewControllerDelegate> delegate;
@property (nonatomic, retain) UIView *detailView;
@property (nonatomic, retain) UIWebView *detailViewData;
@property (nonatomic, retain) UILabel *detailViewLabel;
@property (nonatomic, retain) UIBarButtonItem *printButton;

- (IBAction)viewSelection:(NSString *)str;
- (IBAction)done;

@end

@protocol DetailViewControllerDelegate

- (void)detailViewControllerDidFinish:(DetailViewController *)controller;

@end
