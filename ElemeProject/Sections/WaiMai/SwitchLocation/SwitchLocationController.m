//
//  SwitchLocationController.m
//
//
//  Created by Sam Lau on 6/14/15.
//
//

#import "SwitchLocationController.h"
#import "UIImage+Helper.h"
#import "ColorMacro.h"
#import "ColorMacro.h"
#import "SwitchLocationDataSource.h"
#import "CurrentLocationCell.h"
#import "EnableAutoLocationCell.h"
#import "LocationHistory.h"
#import "LocationManager.h"
#import <ReactiveCocoa.h>

// Define constants
static NSString* const kCurrentLocationCell = @"currentLocationCell";
static NSString* const kSearchHistoryCell = @"searchHistoryCell";
static NSString* const kEnableAutoLocationCell = @"enableAutoLocationCell";

@interface SwitchLocationController () <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate>

@property (strong, nonatomic) UISearchDisplayController* searchController;
@property (strong, nonatomic) NSArray* searchHistory;
@property (strong, nonatomic) SwitchLocationDataSource* dataSource;
@property (strong, nonatomic) NSMutableArray* locationHistoryItems;

@end

@implementation SwitchLocationController

#pragma mark - Lifecycle
- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }

    // Initialize search display view controller
    UISearchBar* searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    [searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    searchBar.placeholder = @"请输入要切换的地址";
    searchBar.delegate = self;
    searchBar.backgroundImage = [UIImage imageWithColor:THEME_COLOR];

    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    self.searchController.delegate = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsDataSource = self;

    // setup table view header
    self.tableView.tableHeaderView = self.searchController.searchBar;

    // setup title and background color
    self.title = @"切换位置";
    self.view.backgroundColor = BACKGROUND_COLOR;

    // add left bar button item to navigation bar
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_cancel"] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBarButtonPressed:)];
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // load data from plist and reload table view
    self.locationHistoryItems = [LocationHistory locationHistoryItems];
    [RACObserve(self, locationHistoryItems) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];

    // setup table view
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Create data source and setup
    TableViewCellConfigureBlock placeholderBlock = ^(UITableViewCell* cell, NSString* address) {

    };
    TableViewCellConfigureBlock locationHistoryBlock = ^(UITableViewCell* cell, NSString* address) {
        cell.textLabel.text = address;
    };

    self.dataSource = [[SwitchLocationDataSource alloc]
              initWithItems:@[ @[ @"sectionOne" ], self.locationHistoryItems, @[ @"sectionThree" ] ]
            cellIdentifiers:@[ kCurrentLocationCell, kSearchHistoryCell, kEnableAutoLocationCell ]
        configureCellBlocks:@[ placeholderBlock, locationHistoryBlock, placeholderBlock ]];
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[CurrentLocationCell class] forCellReuseIdentifier:kCurrentLocationCell];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSearchHistoryCell];
    [self.tableView registerClass:[EnableAutoLocationCell class] forCellReuseIdentifier:kEnableAutoLocationCell];
}

#pragma mark - Event Response
- (void)cancelBarButtonPressed:(UIBarButtonItem*)barButtonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.section == 0 && indexPath.row == 0) {
        [[LocationManager shareInstance] findCurrentLocation];
        [RACObserve([LocationManager shareInstance], address) subscribeNext:^(NSString* address) {
            if (address) { // get the address successfully
                [LocationHistory insertLocationItem:address];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else { // fail to get the address
            }
        }];
    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15.0;
    }
    else {
        return 7.5;
    }
}

#pragma mark - UISearchBarDelegate

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController*)controller willShowSearchResultsTableView:(UITableView*)tableView
{
    static NSString* searchLocationCellIdentifier = @"searchLocationCell";
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchLocationCellIdentifier];
}

@end
