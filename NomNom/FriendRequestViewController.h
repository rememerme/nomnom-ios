//
//  FriendRequestViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestService.h"
#import "FriendRequest.h"
#import "User.h"
#import "HomeViewController.h"

@interface FriendRequestViewController : UIViewController

@property (nonatomic, strong) FriendRequest *request;
@property (nonatomic, strong) User *user;

-(id) initWithRequest:(FriendRequest*)request andUser:(User*)user;

@end
