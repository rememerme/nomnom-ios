//
//  StartGameViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "GameService.h"
#import "User.h"
#import "Friend.h"

@interface StartGameViewController : UIViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Game *game;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) NSMutableArray *checkedIndexPaths;

-(id)initWithGame:(Game*)game andUser:(User*)user;

@end
