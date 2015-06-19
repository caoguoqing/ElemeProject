//
//  WaiMaiViewController.m
//
//
//  Created by Sam Lau on 6/12/15.
//
//

#import "WaiMaiViewController.h"
#import "LocationManager.h"
#import "LocationTitleView.h"
#import "SwitchLocationController.h"
#import <ReactiveCocoa.h>

@interface WaiMaiViewController ()

@property (strong, nonatomic) LocationTitleView* locationTitleView;

@end

@implementation WaiMaiViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // create LocationTitle View
    self.locationTitleView = [[LocationTitleView alloc] initWithFrame:CGRectMake(0, 0, 250, 32)];
    self.navigationItem.titleView = self.locationTitleView;

    // observer address and update location title view
    [[LocationManager shareInstance] findCurrentLocation];
    [RACObserve([LocationManager shareInstance], address) subscribeNext:^(NSString* address) {
        self.locationTitleView.locationLabel.text = address;
    }];

    //  handle when touch location title view
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.navigationItem.titleView addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - Events Response
- (void)handleTapGesture:(UITapGestureRecognizer*)gesture
{
    SwitchLocationController* destViewController = [[SwitchLocationController alloc] init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:destViewController];

    [self presentViewController:navigationController animated:YES completion:nil];
}


@end
