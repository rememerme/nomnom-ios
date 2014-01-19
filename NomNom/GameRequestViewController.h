//
//  GameRequestViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameRequest.h"
#import "User.h"
#import "RequestService.h"

@interface GameRequestViewController : UIViewController

@property (nonatomic, strong) GameRequest *request;
@property (nonatomic, strong) User *user;

-(id) initWithRequest:(GameRequest*)request andUser:(User*)user;

@end
