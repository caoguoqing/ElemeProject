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

@interface SwitchLocationController () <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, SwitchLocationDataSourceDelegate>

@property (strong, nonatomic) UISearchDisplayController* searchController;
@property (strong, nonatomic) SwitchLocationDataSource* dataSource;
@property (strong, nonatomic) NSMutableArray* locationHistoryItems;

@property (assign, nonatomic) CGFloat cellSectionGap;

@end

@implementation SwitchLocationController

#pragma mark - Lifecycle
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
        [self updateCellSectionGap:self.locationHistoryItems];

    }];

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
    self.dataSource.delegate = self;
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
        CurrentLocationCell *cell = (CurrentLocationCell *)[tableView cellForRowAtIndexPath:indexPath];
    
        // activity indicator view start animation
        cell.locationImageView.hidden = YES;
        cell.activityIndicatorView.hidden = NO;
        [cell.activityIndicatorView startAnimating];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[LocationManager shareInstance] findCurrentLocation];
            [RACObserve([LocationManager shareInstance], address) subscribeNext:^(NSString* address) {
                
                // activity indicator view stop animation
                [cell.activityIndicatorView stopAnimating];
                
                if (address) { // get the address successfully
                    [LocationHistory insertLocationItem:address];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                else { // fail to get the address
                }
            }];
        });
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 1) { // location history items
        return UITableViewCellEditingStyleDelete;
    }
    else {
        return UITableViewCellEditingStyleNone;
    }
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"历史位置";
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate for changing each section gap
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 15.0f : self.cellSectionGap;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return self.cellSectionGap;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1 && [tableView numberOfRowsInSection:section] != 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 18.0)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, -7, CGRectGetWidth(self.tableView.frame), 18.0)];
        titleLabel.text = @"历史位置";
        titleLabel.textColor = [UIColor grayColor];
        
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        [view addSubview:titleLabel];
        
        return view;
    }else {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 18.0)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 7, CGRectGetWidth(self.tableView.frame), 18.0)];
        titleLabel.text = @"关闭自动定位后，每次打开应用会默认使用上一次地址";
        titleLabel.textColor = [UIColor grayColor];
        
        titleLabel.font = [UIFont systemFontOfSize:12.0];
        
        [view addSubview:titleLabel];
        
        return view;
    }else {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
}


#pragma mark - UISearchBarDelegate

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController*)controller willShowSearchResultsTableView:(UITableView*)tableView
{
    static NSString* searchLocationCellIdentifier = @"searchLocationCell";
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchLocationCellIdentifier];
}

#pragma mark - SwitchLocationDataSourceDelegate
- (void)switchLocationDataSource:(SwitchLocationDataSource*)dataSource didDeleteItemWithHistoryItems:(NSMutableArray*)items
{
    [self updateCellSectionGap:items];
}

#pragma mark - Private methods
- (void)updateCellSectionGap:(NSMutableArray*)locationHistoryItems
{
    if (locationHistoryItems.count > 0) {
        self.cellSectionGap = 15.0f;
    }
    else {
        self.cellSectionGap = 3.5f;
    }

    [UIView animateWithDuration:2.0 animations:^{
        [self.tableView reloadData];
    }];
    
}

@end
