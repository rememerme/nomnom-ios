//
//  RequestService.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "FriendRequest.h"
#import "FriendService.h"
#import "GameRequest.h"

@interface RequestService : NSObject

-(NSArray*)getFriendRequestsOfUserID:(User*)user;
-(NSArray*)getGameRequestsOfUserID:(User*)user;
-(void)removeFriendRequestWithUserID:(NSString*)user_id andSession:(NSString*)session_id;
-(void)confimFriendRequestWithUserID:(NSString*)user_id andSession:(NSString*)session_id;
@end
