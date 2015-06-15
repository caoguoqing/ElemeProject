//
//  SwitchLocationController.m
//
//
//  Created by Sam Lau on 6/14/15.
//
//

#import "SwitchLocationController.h"
#import "ColorMacro.h"

@interface SwitchLocationController ()

@end

@implementation SwitchLocationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // setup title
    self.title = @"切换位置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // add left bar button item to navigation bar
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_cancel"] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBarButtonPressed:)];
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

#pragma mark - Respond to action
- (void)cancelBarButtonPressed:(UIBarButtonItem *)barButtonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
