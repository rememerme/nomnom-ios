//
//  HomeViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController () <UITabBarDelegate, UITableViewDataSource>

@end

@implementation HomeViewController

-(id) initWithUser:(User*)user{
    self = [super init];
    _user = user;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //HomeViewController *controller = [[HomeViewController alloc]initWithUser:user];
    //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    // set up a local nav controller which we will reuse for each view controller
    // UINavigationController *friendNavigationController;
    
    // create tab bar controller and array to hold the view controllers
    _tabBarController = [[UITabBarController alloc] init];
    
    NSMutableArray *localControllersArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    // setup the first view controller (Root view controller)
   
    _friendController = [[FriendsViewController alloc] initWithUser:_user];
    
    _gameController = [[GameViewController alloc]initWithUser:_user];
    
    _requestsController = [[RequestsViewController alloc] initWithUser:_user];
    
    // create the nav controller and add the root view controller as its first view
    UINavigationController *friendNavigationController = [[UINavigationController alloc] initWithRootViewController:_friendController];
    friendNavigationController.delegate = self;
    UINavigationController *gameNavigationController = [[UINavigationController alloc] initWithRootViewController:_gameController];
    gameNavigationController.delegate = self;
    UINavigationController *requestsNavigationController = [[UINavigationController alloc] initWithRootViewController:_requestsController];
    requestsNavigationController.delegate = self;
    
    [localControllersArray addObject:gameNavigationController];
    [localControllersArray addObject:friendNavigationController];
    [localControllersArray addObject:requestsNavigationController];
    NSArray *titles = [NSArray arrayWithObjects:@"Games", @"Friends", @"Requests", nil];
    
    _tabBarController.viewControllers = localControllersArray;
    
    for (UIViewController *controller in _tabBarController.viewControllers) {
        controller.title = [titles objectAtIndex: [_tabBarController.viewControllers indexOfObject: controller]];
    } 
    _tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    _tabBarController.delegate = self;
    _tabBarController.moreNavigationController.delegate = self;
    _tabBarController.selectedIndex = 0;
    //myViewController.tabBarController = _tabBarController;
    
    // add the tabBarController as a subview in the window
    [self.view addSubview:_tabBarController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
