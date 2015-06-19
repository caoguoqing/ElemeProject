//
//  UserPreferencesSpec.m
//  
//
//  Created by Sam Lau on 6/19/15.
//  Copyright 2015 __MyCompanyName__. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "UserPreferences.h"


SPEC_BEGIN(UserPreferencesSpec)

describe(@"UserPreferences", ^{
    context(@"enable auto location", ^{
        it(@"should return YES", ^{
            [UserPreferences enableAutoLocation];
            [[theValue([UserPreferences isAutoLocation]) should] beYes];
        });
    });
    
    context(@"disable auto location", ^{
        it(@"should return NO", ^{
            [UserPreferences disableAutoLocation];
            [[theValue([UserPreferences isAutoLocation]) should] beNo];
        });
    });
    
    context(@"when save current address that is Guangzhou", ^{
        it(@"should be Guangzhou", ^{
            [UserPreferences saveCurrentAddress:@"Guangzhou"];
            NSString *currentAddress = [UserPreferences getCurrentAddress];
            [[currentAddress should] equal:@"Guangzhou"];
        });
    });
    
    context(@"when first launch", ^{
        it(@"should be YES", ^{
            [UserPreferences enableFirstLaunch];
            [[theValue([UserPreferences isFirstLaunch]) should] beYes];
        });
    });
    
    context(@"when disable first launch", ^{
        it(@"should be NO", ^{
            [UserPreferences disableFirstLaunch];
            [[theValue([UserPreferences isFirstLaunch]) should] beNo];
        });
    });
});

SPEC_END
