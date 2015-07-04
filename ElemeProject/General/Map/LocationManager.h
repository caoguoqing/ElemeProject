//
//  LocationManager.h
//
//
//  Created by Sam Lau on 6/13/15.
//
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface LocationManager : NSObject

// Methods
+ (LocationManager*)shareInstance;
- (void)findCurrentLocation;
- (void)searchHintResultsWithKeyWord:(NSString *)keyWord;

// Properties
@property (copy, nonatomic, readonly) NSString* address;
@property (strong, nonatomic) NSArray *searchHintResults;

@end
