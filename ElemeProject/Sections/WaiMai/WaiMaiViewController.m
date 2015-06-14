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
#import <ReactiveCocoa.h>

@interface WaiMaiViewController ()

@property (strong, nonatomic) LocationTitleView* locationTitleView;

@end

@implementation WaiMaiViewController

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
}

@end
