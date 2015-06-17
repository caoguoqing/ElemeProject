//
//  ArraySectionDataSource.h
//
//
//  Created by Sam Lau on 6/17/15.
//
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface ArraySectionDataSource : NSObject


- (id)initWithItems:(NSArray *)items
     cellIdentifiers:(NSArray *)cellIdentifiers
 configureCellBlocks:(NSArray *)configureCellBlocks;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
