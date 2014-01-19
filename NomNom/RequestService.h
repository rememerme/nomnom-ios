//
//  RequestService.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface RequestService : NSObject

-(NSArray*)getFriendRequestsOfUserID:(User*)_user;
-(NSArray*)getGameRequestsOfUserID:(User*)_user;

@end
