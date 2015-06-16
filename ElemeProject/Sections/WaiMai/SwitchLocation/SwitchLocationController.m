//
//  SwitchLocationController.m
//
//
//  Created by Sam Lau on 6/14/15.
//
//

#import "SwitchLocationController.h"
#import "ColorMacro.h"
#import "ColorMacro.h"

@interface SwitchLocationController () <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) UISearchDisplayController* searchController;

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
    searchBar.barTintColor = THEME_COLOR;
    [searchBar sizeToFit];
    searchBar.delegate = self;
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    self.searchController.delegate = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsDataSource = self;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // setup title
    self.title = @"切换位置";
    self.view.backgroundColor = [UIColor whiteColor];
    // setup table view header
    self.tableView.tableHeaderView = self.searchController.searchBar;

    // add left bar button item to navigation bar
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_cancel"] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBarButtonPressed:)];
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

#pragma mark - UISearchBarDelegate

#pragma mark - UISearchDisplayDelegate
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    static NSString *searchLocationCellIdentifier = @"searchLocationCell";
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchLocationCellIdentifier];
}

#pragma mark - Event Response
- (void)cancelBarButtonPressed:(UIBarButtonItem*)barButtonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
