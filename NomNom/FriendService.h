//
//  FriendService.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "UserService.h"
#import "Friend.h"

@interface FriendService : NSObject

-(NSArray*) getFriendsOfUserID:(User*)user;
-(Friend *) getFriendWithUserID:(NSString*)user_id andSession:(NSString*)session_id;
-(void) removeFriendWithUserID:(NSString*)user_id andSession:(NSString*)session_id;
-(void) sendFriendRequestWithUserID:(NSString*)user_id andSession:(NSString*)session_id;

@end
