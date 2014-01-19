//
//  GameViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Game.h"
#import "GameService.h"
#import "CreateGameViewController.h"
#import "StartGameViewController.h"

@interface GameViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *games;
@property (nonatomic, strong) NSMutableArray *games_start;
@property (nonatomic, strong) NSMutableArray *games_nom;
@property (nonatomic, strong) NSMutableArray *games_jud;
@property (nonatomic) UITabBarController *tabBarController;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSArray *searchRes;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
-(id) initWithUser:(User*)user;

@end
