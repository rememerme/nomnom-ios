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
//#import <JSON/JSON.h>

@interface UserService : NSObject

-(User *) loginUserWithCredentials:(Login*)creds;

@end
