//
//  HomeViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "GameViewController.h"
#import "FriendsViewController.h"
#import "RequestsViewController.h"

@interface HomeViewController : UIViewController <UITabBarDelegate, UITableViewDataSource>

@property (nonatomic, strong) User *user;
@property (atomic, strong) GameViewController *gameController;
@property (atomic, strong) FriendsViewController *friendController;
@property (atomic, strong) RequestsViewController *requestsController;
@property (nonatomic) UITabBarController *tabBarController;

-(id)initWithUser:(User*)user;

@end
