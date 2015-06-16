//
//  ArrayDataSource.h
//
//
//  Created by Sam Lau on 6/16/15.
//
//

#import "ArrayDataSource.h"

@interface ArrayDataSource ()

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, copy) NSString* cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation ArrayDataSource

#pragma mark - Initializer
- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray*)items
     cellIdentifier:(NSString*)cellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;
{
    self = [super init];
    if (self) {
        _items = items;
        _cellIdentifier = cellIdentifier;
        _configureCellBlock = [configureCellBlock copy];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

#pragma mark - UITableViewDataSource Helper
- (id)itemAtIndexPath:(NSIndexPath*)indexPath
{
    return self.items[(NSUInteger)indexPath.row];
}

@end
