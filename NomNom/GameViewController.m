//
//  GameViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "GameViewController.h"
#import "ViewController.h"

@interface GameViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation GameViewController

-(id) initWithUser:(User *)user {
    self = [super init];
    _user = user;
    GameService *gs = [[GameService alloc]init];
    _games = [gs getGamesWithSession:_user.session_id];
    _games_start = [[NSMutableArray alloc] init];
    _games_nom = [[NSMutableArray alloc ] init];
    _games_jud = [[NSMutableArray alloc] init];
    for (Game *game in _games) {
        if ([game.current_round_id isEqualToString: @""]) {
            [_games_start addObject:game];
        }
        else {
            Round *curr = [gs getCurrentRoundForGameID:game.game_id andSession:_user];
            if ([curr.selector_id isEqualToString:_user.user_id]) {
                [_games_jud addObject:game];
            } else {
                [_games_nom addObject:game];
            }
            
        }
    }
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
    _games_start = [[NSMutableArray alloc] init];
    _games_nom = [[NSMutableArray alloc ] init];
    _games_jud = [[NSMutableArray alloc] init];
    for (Game *game in _games) {
        if ([game.current_round_id isEqualToString: @""]) {
            [_games_start addObject:game];
        }
        else {
            Round *curr = [gs getCurrentRoundForGameID:game.game_id andSession:_user];
            if ([curr.selector_id isEqualToString:_user.user_id]) {
                [_games_jud addObject:game];
            } else {
                [_games_nom addObject:game];
            }
            
        }
    }
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
    return 3;//[_friends count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return (section == 0) ? [_games_start count] : ((section == 1) ? [_games_nom count] : [_games_jud count]);
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return (section == 0) ? @"Ready to Start" : ((section == 1)? @"Ready to Nominate" : @"Ready to Judge");
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    if (indexPath.section == 0) {
        if ([_games_start count] == 0) {
            cell.textLabel.text = @"No Games";
        } else {
            Game *fr = [_games_start objectAtIndex:indexPath.row];
            cell.textLabel.text = fr.game_id;
            cell.detailTextLabel.text = fr.date_created;
        }
    } else if (indexPath.section == 1){
        if ([_games_nom count] == 0) {
            cell.textLabel.text = @"No Games";
        } else {
            Game *gr = [_games_nom objectAtIndex:indexPath.row];
            cell.textLabel.text = gr.game_id;
        }
    } else {
        if ([_games_jud count] == 0) {
            cell.textLabel.text = @"No Games";
        } else {
            Game *hr = [_games_jud objectAtIndex:indexPath.row];
            cell.textLabel.text = hr.game_id;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"Selected Start Game");
        Game *game = (Game*)[_games_start objectAtIndex:indexPath.row];
        StartGameViewController *sgvc = [[StartGameViewController alloc]initWithGame:game andUser:_user];
        [self.navigationController pushViewController:sgvc animated:YES];
    } else if (indexPath.section == 1){
        NSLog(@"Selected Nominate");
        NominationsViewController *n = [[NominationsViewController alloc]initWithUser:_user andGame:(Game*)[_games objectAtIndex:indexPath.row]];
        
        [self.navigationController pushViewController:n animated:YES];
    } else {
        NSLog(@"Selected Judging");
    }
}

@end
