//
//  WaiMaiViewController.m
//
//
//  Created by Sam Lau on 6/12/15.
//
//

#import "WaiMaiViewController.h"
#import "LocationManager.h"
#import <ReactiveCocoa.h>

@interface WaiMaiViewController ()

@end

@implementation WaiMaiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[LocationManager shareInstance] findCurrentLocation];
    [RACObserve([LocationManager shareInstance], address) subscribeNext:^(NSString *x) {
        NSLog(@"address = %@", x);
    }];
}

@end
