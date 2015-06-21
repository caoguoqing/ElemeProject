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
            NSString *location = locationHistory[locationHistory.count - 1];
            [[location should] equal:@"客村"];
        });
    });
    
    context(@"when insert and delet item", ^{
        it(@"should not change items count", ^{
            NSInteger beforeCount = [LocationHistory locationHistoryItems].count;
            
            [LocationHistory insertLocationItem:@"沥滘"];
            [LocationHistory deleteLocationItemForIndex:[LocationHistory locationHistoryItems].count - 1];
            
            NSInteger afterCount = [LocationHistory locationHistoryItems].count;
            
            [[theValue(beforeCount) should] equal:theValue(afterCount)];
        });
    });
});

SPEC_END
