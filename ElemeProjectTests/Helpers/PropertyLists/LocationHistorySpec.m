//
//  LocationHistorySpec.m
//  
//
//  Created by Sam Lau on 6/19/15.
//  Copyright 2015 __MyCompanyName__. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "LocationHistory.h"


SPEC_BEGIN(LocationHistorySpec)

describe(@"LocationHistory", ^{
    context(@"when insert address item", ^{
        it(@"should be nil", ^{
            [LocationHistory insertLocationItem:@"客村"];
            NSMutableArray *locationHistory = [LocationHistory locationHistoryItems];
            NSString *location = locationHistory[0];
            [[location should] equal:@"客村"];
        });
    });
});

SPEC_END
