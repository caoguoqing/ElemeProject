//
//  LocationHistory.m
//
//
//  Created by Sam Lau on 6/19/15.
//
//

#import "LocationHistory.h"
#import "NSString+Sandbox.h"

static NSString* const kLocationHistoryPath = @"locationHistory.plist";

@implementation LocationHistory

+ (void)insertLocationItem:(NSString*)addressItem
{
    NSMutableArray* locationHistoryItems = [self locationHistoryItems];

    if (![locationHistoryItems containsObject:addressItem]) {
        [locationHistoryItems addObject:addressItem];
        [locationHistoryItems writeToFile:[NSString filePathAppendDocumentDirectory:kLocationHistoryPath] atomically:YES];
    }
}

+ (NSMutableArray*)locationHistoryItems
{
    NSMutableArray* locationHistoryItems = [NSMutableArray arrayWithContentsOfFile:[NSString filePathAppendDocumentDirectory:kLocationHistoryPath]];

    if (!locationHistoryItems) {
        locationHistoryItems = [NSMutableArray new];
    }

    return locationHistoryItems;
}

+ (void)deleteLocationItemForIndex:(NSInteger)index
{
    NSMutableArray *locationHistoryItems = [self locationHistoryItems];
    NSString* item = [locationHistoryItems objectAtIndex:index];
    if (item) {
        [locationHistoryItems removeObjectAtIndex:index];
        [locationHistoryItems writeToFile:[NSString filePathAppendDocumentDirectory:kLocationHistoryPath] atomically:YES];
    }
    
}

@end
