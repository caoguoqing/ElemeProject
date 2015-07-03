//
//  SwitchLocationDataSource.h
//
//
//  Created by Sam Lau on 6/17/15.
//
//

#import "ArraySectionDataSource.h"

@class SwitchLocationDataSource;

@protocol SwitchLocationDataSourceDelegate <NSObject>

- (void)switchLocationDataSource:(SwitchLocationDataSource *)dataSource didDeleteItemWithHistoryItems:(NSMutableArray *)items;

@end

@interface SwitchLocationDataSource : ArraySectionDataSource

@property (weak, nonatomic) id<SwitchLocationDataSourceDelegate> delegate;

- (NSMutableArray *)locationHistoryItems;

@end
