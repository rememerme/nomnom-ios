//
//  FriendsViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController () <UITabBarControllerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@end

@implementation FriendsViewController

-(id) initWithUser:(User*)user {
    self = [super init];
    _user = user;
    FriendService *fs = [[FriendService alloc]init];
    _friends = [fs getFriendsOfUserID:user];
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *settings = [UIImage imageNamed:@"Settings.png"];
    //UIImage *home = [UIImage imageNamed:@"Home.png"];
    
    //SearchBar
    NSString *searchBarPlaceHolder = nil;
    UISearchBar * theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,40)]; // frame has no effect.
    theSearchBar.delegate = self;
    if ( !searchBarPlaceHolder ) {
        searchBarPlaceHolder = @"Search for new friends";
    }
    theSearchBar.placeholder = searchBarPlaceHolder;
    theSearchBar.showsCancelButton = YES;
    
    // add it to table view
    
    
    UISearchDisplayController *searchCon = [[UISearchDisplayController alloc]
                                            initWithSearchBar:theSearchBar
                                            contentsController:self ];
    _searchController = searchCon;
    
    [_searchController setActive:NO animated:YES];
    //[theSearchBar becomeFirstResponder];
    
    // make nav bar
    //UINavigationController *friendNavigationController = [[UINavigationController alloc] initWithRootViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithCGImage:settings.CGImage scale:2.0 orientation:settings.imageOrientation]  style:UIBarButtonItemStyleBordered target:self action:@selector(setttings:)];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView.tableHeaderView = theSearchBar;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchController.delegate = self;
    self.searchController.searchResultsDataSource = self.tableView.dataSource;
    self.searchController.searchResultsDelegate = self.tableView.delegate;
    //UITableViewController *tC = [[UITableViewController alloc] init];
    //tC.tableView = _tableView;

    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshFriends:)forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    self.view = self.tableView;
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) edit:(id)selector {
    BOOL edit = self.tableView.editing ? NO : YES;
    [self.tableView setEditing:edit];
}

-(void) refreshFriends:(id)selector {
    FriendService *fs = [[FriendService alloc]init];
    _friends = [fs getFriendsOfUserID:_user];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
}

-(void) settings:(id)selector {
    
}

#pragma mark UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    if (tableView == _searchController.searchResultsTableView) {
        return [_searchRes count];
    } else {
        return [_friends count];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return @"Friends";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }

    Friend *friend = [[Friend alloc]init];
    if (tableView == _searchController.searchResultsTableView) {
        friend = [_searchRes objectAtIndex:indexPath.row];
    } else {
        friend = [_friends objectAtIndex:indexPath.row];
    }
    NSLog(@"Changing cells %@", friend);
    //TimeZoneWrapper *timeZoneWrapper = [region.timeZoneWrappers objectAtIndex:indexPath.row];
    //NSLog(@"Friend: %@", friend.username);
    cell.textLabel.text = friend.username;
    cell.detailTextLabel.text = friend.user_id;
    if (tableView == _searchController.searchResultsTableView) {
        [tableView setEditing:YES];
        
    }

    return cell;
}

#pragma mark UITableViewDelegate
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _searchController.searchResultsTableView)
        return UITableViewCellEditingStyleInsert;
    else
        return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[_friends removeObjectAtIndex:indexPath.row];
        Friend *toDel = [_friends objectAtIndex:indexPath.row];
        FriendService *fs = [[FriendService alloc] init];
        [fs removeFriendWithUserID:toDel.user_id andSession:_user.session_id];
        NSMutableArray *temp = [NSMutableArray arrayWithArray:_friends];
        [temp removeObjectAtIndex:indexPath.row];
        NSLog(@"%i, %i", indexPath.row, [temp count]);
        [tableView beginUpdates];
        if (indexPath.row == 0 && [temp count] == 0) {
            //NSInteger sectionIndex = [indexPath indexAtPosition:0];
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"Deleted Section");
        }else {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"Deleted Row");
        }
        NSLog(@"Deleted shit");
        _friends = [NSArray arrayWithArray:temp];
        [tableView endUpdates];
        [tableView reloadData];
        
    } else {
        FriendService *fs = [[FriendService alloc]init];
        Friend *f = (Friend*)[_searchRes objectAtIndex:indexPath.row];
        [fs sendFriendRequestWithUserID:f.user_id andSession:_user.session_id];
        NSString *msg = (@"Your friend request to %@ has been sent", f.username);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Request Sent" message: msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
}

#pragma mark - UISearchDisplayController Delegate Methods
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *search = [searchBar text];
    UserService *us = [[UserService alloc]init];
    _searchRes = [us getUserWithUsername:search andSession:_user.session_id];
    NSLog(@"Search Size: %i", [_searchRes count]);
    
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //[_searchRes removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    UserService *us = [[UserService alloc]init];
    _searchRes = [us getUserWithUsername:searchText andSession:_user.session_id];
    //_searchRes = [NSMutableArray arrayWithArray: [_searchRes filteredArrayUsingPredicate:resultPredicate]];
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    // Return YES to cause the search result table view to be reloaded.
    
    if ([searchString length] > 0) {
        [self filterContentForSearchText:searchString scope:[[_searchController.searchBar scopeButtonTitles] objectAtIndex:[_searchController.searchBar selectedScopeButtonIndex]]];
        //_tableView = _searchController.searchResultsTableView;
        //[_tableView reloadData];
        NSLog(@"Search String Length Changed");
        return YES;
    }
    else {
        return NO;
    }
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    //_tableView = _searchController.searchResultsTableView;
    return YES;
}


@end
