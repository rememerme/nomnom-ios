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
    _checkedIndexPaths = [[NSMutableArray alloc] init];
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
    
    _game_name = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    _game_name.backgroundColor = [UIColor lightGrayColor];
    _game_name.textColor = [UIColor darkGrayColor];
    _game_name.font = [UIFont systemFontOfSize:14.0f];
    _game_name.borderStyle = UITextBorderStyleRoundedRect;
    _game_name.clearButtonMode = UITextFieldViewModeWhileEditing;
    _game_name.returnKeyType = UIReturnKeyDone;
    _game_name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _game_name.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _game_name.placeholder = @"Game Title";
    _game_name.enabled = NO;
    _game_name.delegate = self;
    
    UIView *gameNameView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 300, 50)];
    gameNameView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    gameNameView.layer.borderWidth = 2.f;
    
    [gameNameView addSubview:_game_name];
    [scroll addSubview:gameNameView];
    
    _winning_score = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    _winning_score.backgroundColor = [UIColor whiteColor];
    _winning_score.textColor = [UIColor blackColor];
    _winning_score.font = [UIFont systemFontOfSize:14.0f];
    _winning_score.borderStyle = UITextBorderStyleRoundedRect;
    _winning_score.clearButtonMode = UITextFieldViewModeWhileEditing;
    _winning_score.keyboardType = UIKeyboardTypeDecimalPad;
    _winning_score.returnKeyType = UIReturnKeyDefault;
    _winning_score.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _winning_score.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _winning_score.placeholder = @"Winning Score";
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _winning_score.inputAccessoryView = numberToolbar;
    
    _winning_score.delegate = self;
    
    UIView *winningView = [[UIView alloc] initWithFrame:CGRectMake(10, 90, 300, 50)];
    winningView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    winningView.layer.borderWidth = 2.f;
    
    [winningView addSubview:_winning_score];
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
    NSArray *members = [[NSArray alloc] initWithArray:_checkedIndexPaths];
    GameService *gs = [[GameService alloc]init];
    [gs createGameWithMembers:members andWinningScore:[_winning_score.text integerValue] andSession:_user.session_id];
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

-(void)cancelNumberPad{
    [_winning_score resignFirstResponder];
    _winning_score.text = @"";
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = _winning_score.text;
    [_winning_score resignFirstResponder];
}

@end
