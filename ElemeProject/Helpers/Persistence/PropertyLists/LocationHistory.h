//
//  LocationHistory.h
//  
//
//  Created by Sam Lau on 6/19/15.
//
//

#import <Foundation/Foundation.h>

@interface LocationHistory : NSObject

+ (void)insertLocationItem:(NSString *)locationItem;
+ (NSMutableArray*)locationHistoryItems;
+ (void)deleteLocationItemForIndex:(NSInteger)index;

@end
