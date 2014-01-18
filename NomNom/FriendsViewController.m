//
//  FriendsViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController () <UITabBarControllerDelegate>

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
    UIImage *home = [UIImage imageNamed:@"Home.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithCGImage:settings.CGImage scale:2.0 orientation:settings.imageOrientation]  style:UIBarButtonItemStyleBordered target:self action:@selector(settings)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithCGImage:home.CGImage scale:2.0 orientation:home.imageOrientation]  style:UIBarButtonItemStyleBordered target:self action:@selector(home)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    int i = 0;
    for (Friend* friend in _friends) {
        UIView *fView = [[UIView alloc]initWithFrame:CGRectMake(10, 50+i*40, 300, 40)];
        fView.backgroundColor = [UIColor whiteColor];
        fView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        fView.layer.borderWidth = 0.5f;
        UILabel *fLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 40)];
        fLabel.text = friend.username;
        fLabel.textColor = [UIColor darkTextColor];
        [scrollView addSubview:fView];
    }
    [self.view addSubview:scrollView];
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) poop :(id)selector{
    
}

-(void) home {
    
    
}

-(void) settings {
    
}

@end
