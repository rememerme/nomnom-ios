//
//  FriendRequestViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "FriendRequestViewController.h"

@interface FriendRequestViewController ()

@end

@implementation FriendRequestViewController

-(id) initWithRequest:(FriendRequest*)request andUser:(User*)user {
    self = [super init];
    _user = user;
    _request = request;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 300, 60)];
    label.text = _request.username;
    [self.view addSubview:label];
    
    UIButton *accept = [UIButton buttonWithType:UIButtonTypeSystem];
    UIView *acceptView = [[UIView alloc]initWithFrame:CGRectMake(10, 200, 100, 50)];
    accept.titleLabel.text = @"Accept";
    [accept addTarget:self action:@selector(accept:) forControlEvents:UIControlEventTouchDown];
    [acceptView addSubview:accept];
    [self.view addSubview:acceptView];
    
    UIButton *decline = [UIButton buttonWithType:UIButtonTypeSystem];
    UIView *declineView = [[UIView alloc]initWithFrame:CGRectMake(150, 200, 100, 50)];
    decline.titleLabel.text = @"Deny";
    [decline addTarget:self action:@selector(decline:) forControlEvents:UIControlEventTouchDown];
    [declineView addSubview:decline];
    [self.view addSubview:declineView];
}

-(void) accept:(id)selector {
    RequestService *rs = [[RequestService alloc]init];
    [rs confimFriendRequestWithUserID:_request.user_id andSession:_user.session_id];
    NSString *msg = (@"Your friend request to %@ has been approved", _request.username);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Request Approved" message: msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    HomeViewController *home = [[HomeViewController alloc] initWithUser:_user];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setViewControllers:[NSArray arrayWithObject:home] animated:YES];
}

-(void) decline:(id)selector {
    RequestService *rs = [[RequestService alloc] init];
    [rs removeFriendRequestWithUserID:_request.user_id andSession:_user.session_id];
    NSString *msg = (@"Your friend request to %@ has been denied", _request.username);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Request Denied" message: msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    HomeViewController *home = [[HomeViewController alloc] initWithUser:_user];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setViewControllers:[NSArray arrayWithObject:home] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
