//
//  RequestsViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "RequestService.h"
#import "FriendRequest.h"
#import "GameRequest.h"
#import "FriendRequestViewController.h"

@interface RequestsViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *friend_requests;
@property (nonatomic, strong) NSArray *game_requests;
@property (nonatomic) UITabBarController *tabBarController;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSArray *searchRes;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
-(id) initWithUser:(User*)user;

@end
