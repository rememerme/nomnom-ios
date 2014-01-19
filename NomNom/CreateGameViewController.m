//
//  CreateGameViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "CreateGameViewController.h"

@interface CreateGameViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CreateGameViewController

-(id) initWithUser:(User *)user {
    self = [super init];
    _user = user;
    FriendService *fs = [[FriendService alloc]init];
    _friends = [fs getFriendsOfUserID:_user];
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
    
    UITextField *game_name = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    game_name.backgroundColor = [UIColor lightGrayColor];
    game_name.textColor = [UIColor darkGrayColor];
    game_name.font = [UIFont systemFontOfSize:14.0f];
    game_name.borderStyle = UITextBorderStyleRoundedRect;
    game_name.clearButtonMode = UITextFieldViewModeWhileEditing;
    game_name.returnKeyType = UIReturnKeyDone;
    game_name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    game_name.autocapitalizationType = UITextAutocapitalizationTypeNone;
    game_name.placeholder = @"Game Title";
    game_name.enabled = NO;
    game_name.delegate = self;
    
    UIView *gameNameView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 300, 50)];
    gameNameView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    gameNameView.layer.borderWidth = 2.f;
    
    [gameNameView addSubview:game_name];
    [scroll addSubview:gameNameView];
    
    UITextField *winning_score = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    winning_score.backgroundColor = [UIColor whiteColor];
    winning_score.textColor = [UIColor blackColor];
    winning_score.font = [UIFont systemFontOfSize:14.0f];
    winning_score.borderStyle = UITextBorderStyleRoundedRect;
    winning_score.clearButtonMode = UITextFieldViewModeWhileEditing;
    winning_score.returnKeyType = UIReturnKeyDone;
    winning_score.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    winning_score.autocapitalizationType = UITextAutocapitalizationTypeNone;
    winning_score.placeholder = @"Winning Score";
    winning_score.delegate = self;
    
    UIView *winningView = [[UIView alloc] initWithFrame:CGRectMake(10, 90, 300, 50)];
    winningView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    winningView.layer.borderWidth = 2.f;
    
    [winningView addSubview:winning_score];
    [scroll addSubview:winningView];
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    Friend *friend = [_friends objectAtIndex:indexPath.row];
    //TimeZoneWrapper *timeZoneWrapper = [region.timeZoneWrappers objectAtIndex:indexPath.row];
    cell.textLabel.text = friend.username;
    
    return cell;
}


@end
