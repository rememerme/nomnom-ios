//
//  StartGameViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "StartGameViewController.h"

@interface StartGameViewController ()

@end

@implementation StartGameViewController

-(id)initWithGame:(Game*)game andUser:(User*)user {
    self = [super init];
    _user = user;
    _game = game;
    GameService *gs = [[GameService alloc]init];
    _friends = [gs getGameMembersForGameID:_game.game_id andSession:_user];
    _checkedIndexPaths = [[NSMutableArray alloc]init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.title = @"Create Game";
	// Do any additional setup after loading the view.
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    scroll.delegate = self;
    //scroll.frame = self.frame;
    
    scroll.scrollEnabled = YES;
    
    UIView *friendsView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 300, 200)];
    UITableView *friendsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 200) style:UITableViewStylePlain];
    friendsTable.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    friendsTable.delegate = self;
    friendsTable.dataSource = self;
    [friendsTable reloadData];
    
    scroll.backgroundColor = [UIColor whiteColor];
    [friendsView addSubview:friendsTable];
    [scroll addSubview:friendsView];
    
    UIButton *create = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [create setFrame:CGRectMake(10, 250, 300, 50)];
    create.backgroundColor = [UIColor greenColor];
    [create setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [create setTitle:@"Start Game" forState:UIControlStateNormal];
    if ([_game.leader_id isEqualToString:_user.user_id])
        [create setEnabled:YES];
    else
        [create setEnabled:NO];
    
    [create addTarget:self action:@selector(createGame:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [scroll addSubview:create];
    
    [self.view addSubview:scroll];
    
}

-(void) createGame:(id)selector {
    NSLog(@"Create Game Init");
    NSArray *members = [[NSArray alloc] initWithArray:_checkedIndexPaths];
    GameService *gs = [[GameService alloc]init];
    [gs startGameWithGameID:_game.game_id andSession:_user];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;//[_friends count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return [_friends count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return @"Friends Ready";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    User *friend  = [[User alloc]init];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        friend = [_friends objectAtIndex:indexPath.row];
        cell.textLabel.text = friend.username;
    }
    
    if (friend.status == 2)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

@end
