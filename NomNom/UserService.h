//
//  UserService.h
//  Nominal Nominations
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Login.h"
#import "Friend.h"

@interface UserService : NSObject

-(User *) loginUserWithCredentials:(Login*)creds;
-(NSArray *) getUserWithUsername:(NSString *)username andSession:(NSString*)session_id;
@end
