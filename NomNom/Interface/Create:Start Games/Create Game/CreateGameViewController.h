//
//  CreateGameViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "FriendService.h"
#import "Friend.h"
#import "GameService.h"

@interface CreateGameViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) NSMutableArray *checkedIndexPaths;
@property (nonatomic, strong) UITextField *game_name;
@property (nonatomic, strong) UITextField *winning_score;

-(id) initWithUser:(User*)user;

@end
