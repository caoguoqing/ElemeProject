//
//  ArraySectionDataSource.m
//
//
//  Created by Sam Lau on 6/17/15.
//
//

#import "ArraySectionDataSource.h"

@interface ArraySectionDataSource () 

@property (strong, nonatomic) NSArray* items;
@property (strong, nonatomic) NSArray* cellIdentifiers;
@property (strong, nonatomic) NSArray* configureCellBlocks;

@end

@implementation ArraySectionDataSource

#pragma mark - Initializer
- (id)initWithItems:(NSArray*)items
    cellIdentifiers:(NSArray*)cellIdentifiers
configureCellBlocks:(NSArray*)configureCellBlocks
{
    self = [super init];
    if (!self) {
        return nil;
    }

    _items = items;
    _cellIdentifiers = cellIdentifiers;
    _configureCellBlocks = configureCellBlocks;

    return self;
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* rows = self.items[section];

    return rows.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    // get table view cell and item by index path
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifiers[indexPath.section]
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    
    TableViewCellConfigureBlock configureBlock = self.configureCellBlocks[indexPath.section];
    if (configureBlock) {
        configureBlock(cell, item);
    }

    return cell;
}

#pragma mark - UITableViewDataSource Helper
- (id)itemAtIndexPath:(NSIndexPath*)indexPath
{
    NSArray *itemsForRow = self.items[indexPath.section];
    
    return itemsForRow[(NSUInteger)indexPath.row];
}

@end
