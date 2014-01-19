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
    
    UIView *friendsView = [[UIView alloc] initWithFrame:CGRectMake(10, 170, 300, 200)];
    UITableView *friendsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 200) style:UITableViewStylePlain];
    friendsTable.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    friendsTable.delegate = self;
    friendsTable.dataSource = self;
    [friendsTable reloadData];
    
    scroll.backgroundColor = [UIColor whiteColor];
    [friendsView addSubview:friendsTable];
    [scroll addSubview:friendsView];
    
    UIButton *create = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [create setFrame:CGRectMake(10, 390, 300, 50)];
    create.backgroundColor = [UIColor greenColor];
    [create setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [create setTitle:@"Create Game" forState:UIControlStateNormal];
    [create addTarget:self action:@selector(createGame:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [scroll addSubview:create];
    
    [self.view addSubview:scroll];
    
}

-(void) createGame:(id)selector {
    NSArray *members = [[NSArray alloc] initWithArray:_checkedIndexPaths];
    GameService *gs = [[GameService alloc]init];
    //[gs createGameWithMembers:members andWinningScore:[_winning_score.text integerValue] andSession:_user.session_id];
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
    return @"Friends";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        Friend *friend = [_friends objectAtIndex:indexPath.row];
        cell.textLabel.text = friend.username;    }
    
    if ([self.checkedIndexPaths containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *uid = ((Friend*)[_friends objectAtIndex:indexPath.row]).user_id;
    if ([self.checkedIndexPaths containsObject:uid])
    {
        //[self.checkedIndexPaths removeObject:indexPath];
        [self.checkedIndexPaths removeObject: uid];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        //[self.checkedIndexPaths addObject:indexPath];
        [self.checkedIndexPaths addObject: uid];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end
