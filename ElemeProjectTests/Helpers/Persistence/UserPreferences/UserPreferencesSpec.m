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
});

SPEC_END
