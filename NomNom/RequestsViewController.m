//
//  RequestsViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "RequestsViewController.h"

@interface RequestsViewController ()

@end

@implementation RequestsViewController

-(id) initWithUser:(User *)user {
    self = [super init];
    _user = user;
    
    _friend_requests = [[[RequestService alloc]init] getFriendRequestsOfUserID:_user];
    _game_requests = [[[RequestService alloc]init] getGameRequestsOfUserID:_user];
    
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *settings = [UIImage imageNamed:@"Settings.png"];
    //UIImage *home = [UIImage imageNamed:@"Home.png"];
    
    //SearchBar
    //[theSearchBar becomeFirstResponder];
    
    // make nav bar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithCGImage:settings.CGImage scale:2.0 orientation:settings.imageOrientation]  style:UIBarButtonItemStyleBordered target:self action:@selector(setttings:)];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshRequests:)forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    self.view = self.tableView;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) settings:(id)selector {
    
}

-(void) edit:(id)selector {
    BOOL edit = self.tableView.editing ? NO : YES;
    [self.tableView setEditing:edit];
}

-(void) refreshRequests:(id)selector {
    RequestService *rs = [[RequestService alloc]init];
    _friend_requests = [rs getFriendRequestsOfUserID:_user];
    _game_requests = [rs getGameRequestsOfUserID:_user];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return (section == 0) ? ([_friend_requests count] > 0 ? [_friend_requests count] : 1) : ([_game_requests count] > 0 ? [_game_requests count] : 1);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return section == 0 ? @"Friend Requests" : @"Game Requests";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        if ([_friend_requests count] == 0) {
            cell.textLabel.text = @"No new Friend Requests";
        } else {
            FriendRequest *fr = [_friend_requests objectAtIndex:indexPath.row];
            cell.textLabel.text = fr.username;
            cell.detailTextLabel.text = fr.date_created;
        }
    } else {
        if ([_game_requests count] == 0) {
            cell.textLabel.text = @"No new Game Requests";
        } else {
            GameRequest *gr = [_game_requests objectAtIndex:indexPath.row];
            cell.textLabel.text = gr.game_id;
        }
    }
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendRequest *fr = (FriendRequest*)[_friend_requests objectAtIndex:indexPath.row];
    FriendRequestViewController *frvc = [[FriendRequestViewController alloc]initWithRequest:fr andUser:_user];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setViewControllers:[NSArray arrayWithObject:frvc] animated:YES];
}

@end
