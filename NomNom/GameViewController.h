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

@interface GameViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray* games;

-(id) initWithUser:(User*)user;

@end
