//
//  SwitchLocationDataSource.m
//
//
//  Created by Sam Lau on 6/17/15.
//
//

#import "SwitchLocationDataSource.h"
#import "LocationHistory.h"
#import <ReactiveCocoa.h>

@implementation SwitchLocationDataSource

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 1 && editingStyle == UITableViewCellEditingStyleDelete) {
        // update location history items and record it
        [[self locationHistoryItems] removeObjectAtIndex:indexPath.row];
        [LocationHistory deleteLocationItemForIndex:indexPath.row];

        // update UI
        [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationLeft];
        [self.delegate switchLocationDataSource:self didDeleteItemWithHistoryItems:[self locationHistoryItems]];
    }
}

@end
