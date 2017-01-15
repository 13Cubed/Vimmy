//
//  DetailViewController.m
//  Vimmy
//
//  Created by Richard Davis on 3/2/10.
//  Copyright 2012 13Cubed. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize delegate;
@synthesize detailView;
@synthesize detailViewLabel;
@synthesize detailViewData;

NSString *passDetail;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait |
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft |
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)viewSelection:(NSString *)str
{
    passDetail = str;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([UIPrintInteractionController isPrintingAvailable]) {
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                      target:self
                                      action:@selector(printCheatSheet:)];
        
        [detailViewNavItem setRightBarButtonItem:barButton];
        self.printButton = barButton;
        [barButton release];
    }
    
    CGRect webFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64); // 20 = Status Bar, 44 = Navigation Bar
    
    detailViewData = [[UIWebView alloc] initWithFrame:webFrame];
    [detailViewData setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [[self detailView] addSubview:detailViewData];
    
    [detailViewData release];
    
    detailViewLabel.textColor = [UIColor blackColor];
    detailViewLabel.text = passDetail;
    
    if ([passDetail  isEqual: @"Moving Around"]) {
        [detailViewData loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MovingAround" ofType:@"html"]isDirectory:NO]]];
    }
    
    else if ([passDetail  isEqual: @"Editing"]) {
        [detailViewData loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Editing" ofType:@"html"]isDirectory:NO]]];
    }
    
    else if ([passDetail  isEqual: @"Cut, Copy, and Paste"]) {
        [detailViewData loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CutCopyandPaste" ofType:@"html"]isDirectory:NO]]];
    }
    
    else if ([passDetail  isEqual: @"Search and Replace"]) {
        [detailViewData loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SearchandReplace" ofType:@"html"]isDirectory:NO]]];
    }
    
    else if ([passDetail  isEqual: @"Regular Expressions"]) {
        [detailViewData loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"RegularExpressions" ofType:@"html"]isDirectory:NO]]];
    }
    
    else if ([passDetail  isEqual: @"Tabs and Windows"]) {
        [detailViewData loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TabsandWindows" ofType:@"html"]isDirectory:NO]]];
    }
    
    else if ([passDetail  isEqual: @"Miscellaneous"]) {
        [detailViewData loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Miscellaneous" ofType:@"html"]isDirectory:NO]]];
    }
    
    else if ([passDetail  isEqual: @"About"]) {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"About.html" ofType:nil];
        NSString *fileURLString = [[NSURL fileURLWithPath:filePath] absoluteString];
        NSString *params = [NSString stringWithFormat:@"?version=%@&build=%@", version, build];
        NSURL *fileURL = [NSURL URLWithString:[fileURLString stringByAppendingString:params]];
        [detailViewData loadRequest:[NSURLRequest requestWithURL:fileURL]];
    }
    
    [detailViewLabel release];
    [super viewDidLoad];
}

- (IBAction)done
{
    [self.delegate detailViewControllerDidFinish:self];
}

- (IBAction)printCheatSheet:(id)sender
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = passDetail;
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    pic.printInfo = printInfo;
    pic.showsPageRange = YES;
    
    UIViewPrintFormatter *formatter = [self.detailViewData viewPrintFormatter];
    pic.printFormatter = formatter;
    
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            NSLog(@"Printing could not complete because of error: %@", error);
        }
    };
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [pic presentFromBarButtonItem:self.printButton animated:YES completionHandler: completionHandler];
    }
    else {
        [pic presentAnimated:YES completionHandler:completionHandler];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
