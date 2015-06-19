//
//  UserPreferences.m
//
//
//  Created by Sam Lau on 6/19/15.
//
//

#import "UserPreferences.h"

static NSString* const kIsAutoLocation = @"isAutoLocation";

@implementation UserPreferences

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

@end
