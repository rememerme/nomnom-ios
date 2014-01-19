//
//  GameViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation GameViewController

-(id) initWithUser:(User *)user {
    self = [super init];
    _user = user;
    GameService *gs = [[GameService alloc]init];
    _games = [gs getGamesWithSession:_user.session_id];
    return self;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *settings = [UIImage imageNamed:@"Settings.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createGame:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithCGImage:settings.CGImage scale:2.0 orientation:settings.imageOrientation]  style:UIBarButtonItemStyleBordered target:self action:@selector(settings:)];
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView reloadData];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshGames:)forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    self.tableView = tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) refreshGames :(id)selector{
    _games = [[NSArray alloc]init];
    GameService *gs = [[GameService alloc]init];
    _games = [gs getGamesWithSession:_user.session_id];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

-(void) createGame :(id) selector {
    NSLog(@"Creating Games");
    CreateGameViewController *cgvc = [[CreateGameViewController alloc]initWithUser:_user];
    [self.navigationController pushViewController:cgvc animated:YES];

}

-(void) settings :(id) selector{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;//[_friends count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return [_games count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return @"Games";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    Game *game = [_games objectAtIndex:indexPath.row];
    //TimeZoneWrapper *timeZoneWrapper = [region.timeZoneWrappers objectAtIndex:indexPath.row];
    cell.textLabel.text = game.leader_id;
    
    return cell;
}

@end
