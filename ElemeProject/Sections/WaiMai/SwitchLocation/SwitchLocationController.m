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
#import "ArrayDataSource.h"


// Define constants
static NSString *const kSearchHistoryCell = @"searchHistoryCell";

@interface SwitchLocationController () <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) UISearchDisplayController* searchController;
@property (strong, nonatomic) NSArray* searchHistory;

@end

@implementation SwitchLocationController

#pragma mark - View lifecycle
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

    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    self.searchController.delegate = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsDataSource = self;

    // setup table view header
    self.tableView.tableHeaderView = self.searchController.searchBar;

    // setup title and background color
    self.title = @"切换位置";
    self.view.backgroundColor = [UIColor whiteColor];

    // add left bar button item to navigation bar
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_cancel"] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBarButtonPressed:)];
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create data source and setup
    ArrayDataSource *dataSource = [[ArrayDataSource alloc] initWithItems:self.searchHistory cellIdentifier: kSearchHistoryCell configureCellBlock:^(id cell, id item) {

    }];
    self.tableView.dataSource = dataSource;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSearchHistoryCell];
}

#pragma mark - UISearchBarDelegate

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController*)controller willShowSearchResultsTableView:(UITableView*)tableView
{
    static NSString* searchLocationCellIdentifier = @"searchLocationCell";
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchLocationCellIdentifier];
}

#pragma mark - Event Response
- (void)cancelBarButtonPressed:(UIBarButtonItem*)barButtonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
