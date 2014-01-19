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
    
    UIButton *accept = [UIButton buttonWithType:UIButtonTypeSystem];
    [accept setFrame:CGRectMake(0, 0, 100, 50)];
    UIView *acceptView = [[UIView alloc]initWithFrame:CGRectMake(10, 200, 100, 50)];
    accept.titleLabel.text = @"Accept";
    accept.backgroundColor = [UIColor greenColor];
    [accept addTarget:self action:@selector(accept:) forControlEvents:UIControlEventTouchDown];
    [acceptView addSubview:accept];
    
    UIButton *decline = [UIButton buttonWithType:UIButtonTypeSystem];
    [decline setFrame:CGRectMake(0, 0, 100, 50)];
    UIView *declineView = [[UIView alloc]initWithFrame:CGRectMake(150, 200, 100, 50)];
    decline.titleLabel.text = @"Deny";
    decline.backgroundColor = [UIColor redColor];
    [decline addTarget:self action:@selector(decline:) forControlEvents:UIControlEventTouchDown];
    [declineView addSubview:decline];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [self.view addSubview:acceptView];
    [self.view addSubview:declineView];
}

-(void) accept:(id)selector {
    RequestService *rs = [[RequestService alloc]init];
    [rs confimFriendRequestWithUserID:_request.user_id andSession:_user.session_id];
    NSString *msg = (@"Your friend request to %@ has been approved", _request.username);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Request Approved" message: msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [self.navigationController popViewControllerAnimated:TRUE];

}

-(void) decline:(id)selector {
    RequestService *rs = [[RequestService alloc] init];
    [rs removeFriendRequestWithUserID:_request.user_id andSession:_user.session_id];
    NSString *msg = (@"Your friend request to %@ has been denied", _request.username);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Request Denied" message: msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [self.navigationController popViewControllerAnimated:TRUE];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
