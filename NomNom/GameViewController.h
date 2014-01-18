//
//  GameViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface GameViewController : UIViewController

@property (nonatomic, strong) User *user;

-(id) initWithUser:(User*)user;

@end
