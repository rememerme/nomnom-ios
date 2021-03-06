//
//  FriendsViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "FriendService.h"

@interface FriendsViewController : UITableViewController <UITabBarControllerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic) UITabBarController *tabBarController;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSArray *searchRes;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
-(id) initWithUser:(User*)user;

@end
