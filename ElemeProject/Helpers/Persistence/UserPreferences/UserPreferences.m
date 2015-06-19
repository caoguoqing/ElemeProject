//
//  UserPreferences.m
//
//
//  Created by Sam Lau on 6/19/15.
//
//

#import "UserPreferences.h"

static NSString* const kIsAutoLocation = @"isAutoLocation";
static NSString* const kCurrentAddress = @"currentAddress";
static NSString* const kIsFirstLaunch = @"isFirstLaunch";

@implementation UserPreferences

#pragma mark - auto location methods
+ (void)enableAutoLocation
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:kIsAutoLocation];
}

+ (void)disableAutoLocation
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:kIsAutoLocation];
}

+ (BOOL)isAutoLocation
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:kIsAutoLocation];
}

#pragma mark - save and get current address
+ (void)saveCurrentAddress:(NSString*)currentAddress
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:currentAddress forKey:kCurrentAddress];
}

+ (NSString*)getCurrentAddress
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:kCurrentAddress];
}

#pragma mark - first launch
+ (BOOL)isFirstLaunch
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return ![userDefaults boolForKey:kIsFirstLaunch];
}

+ (void)disableFirstLaunch
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:kIsFirstLaunch];
}

+ (void)enableFirstLaunch
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:kIsFirstLaunch];
}

@end
