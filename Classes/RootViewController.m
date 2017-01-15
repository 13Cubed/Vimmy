//
//  RootViewController.m
//  Vimmy
//
//  Created by Richard Davis on 3/2/10.
//  Copyright 2012 13Cubed. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "VimmyAppDelegate.h"

@implementation RootViewController

NSMutableArray *listOfItems;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait |
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft |
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the array
    
    listOfItems = [[NSMutableArray alloc] init];
    
    NSArray *sectionOne = [NSArray arrayWithObjects:@"Moving Around",@"Editing",@"Cut, Copy, and Paste",@"Search and Replace",@"Regular Expressions",@"Tabs and Windows",@"Miscellaneous",nil];
    NSDictionary *sectionOneDict = [NSDictionary dictionaryWithObject:sectionOne forKey:@"Items"];
    
    NSArray *sectionTwo = [NSArray arrayWithObjects:@"About",nil];
    NSDictionary *sectionTwoDict = [NSDictionary dictionaryWithObject:sectionTwo forKey:@"Items"];
    
    [listOfItems addObject:sectionOneDict];
    [listOfItems addObject:sectionTwoDict];
    
    // Set the navigation bar title and donate button
    
    self.navigationItem.title = @"Vimmy";
    
    UIBarButtonItem *donateButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Donate"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(donate:)];
    self.navigationItem.leftBarButtonItem = donateButton;
    [donateButton release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [listOfItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Number of rows it should expect should be based on the section
    
    NSDictionary *dictionary = [listOfItems objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Items"];
    return [array count];
}

// Customize the appearance of table view cells

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.backgroundView = nil;
    [tableView setBackgroundColor:[UIColor clearColor]];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell ...
    
    // First get the dictionary object
    
    NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Items"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellValue;
    
    if ([cellValue  isEqual: @"Moving Around"]) {
        UIImage *cellIcon = [UIImage imageNamed:@"MovingAround.png"];
        cell.imageView.image = cellIcon;
    }
    
    else if ([cellValue  isEqual: @"Editing"]) {
        UIImage *cellIcon = [UIImage imageNamed:@"Editing.png"];
        cell.imageView.image = cellIcon;
    }
    
    else if ([cellValue  isEqual: @"Cut, Copy, and Paste"]) {
        UIImage *cellIcon = [UIImage imageNamed:@"CutCopyandPaste.png"];
        cell.imageView.image = cellIcon;
    }
    
    else if ([cellValue  isEqual: @"Search and Replace"]) {
        UIImage *cellIcon = [UIImage imageNamed:@"SearchandReplace.png"];
        cell.imageView.image = cellIcon;
    }
    
    else if ([cellValue  isEqual: @"Regular Expressions"]) {
        UIImage *cellIcon = [UIImage imageNamed:@"RegularExpressions.png"];
        cell.imageView.image = cellIcon;
    }
    
    else if ([cellValue  isEqual: @"Tabs and Windows"]) {
        UIImage *cellIcon = [UIImage imageNamed:@"TabsandWindows.png"];
        cell.imageView.image = cellIcon;
    }
    
    else if ([cellValue  isEqual: @"Miscellaneous"]) {
        UIImage *cellIcon = [UIImage imageNamed:@"Miscellaneous.png"];
        cell.imageView.image = cellIcon;
    }
    
    else if ([cellValue  isEqual: @"About"]) {
        UIImage *cellIcon = [UIImage imageNamed:@"About.png"];
        cell.imageView.image = cellIcon;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the selected item
    
    NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Items"];
    
    // Initialize the detail view controller and display it
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [controller viewSelection:[array objectAtIndex:indexPath.row]];
    
    [self presentViewController:controller animated:YES completion:nil];
    
    [controller release];
}

- (void)donate:(UIBarButtonItem *)donateButton
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DONATE_URL]];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)detailViewControllerDidFinish:(DetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
