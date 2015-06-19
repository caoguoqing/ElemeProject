//
//  UserPreferences.h
//  
//
//  Created by Sam Lau on 6/19/15.
//
//

#import <Foundation/Foundation.h>

@interface UserPreferences : NSObject

// auto location methods
+ (void)enableAutoLocation;
+ (void)disableAutoLocation;
+ (BOOL)isAutoLocation;

// save and get current address
+ (void)saveCurrentAddress:(NSString *)currentAddress;
+ (NSString *)getCurrentAddress;

// first launch
+ (BOOL)isFirstLaunch;
+ (void)disableFirstLaunch;
+ (void)enableFirstLaunch;

@end
