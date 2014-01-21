//
//  User.h
//  Nominal Nominations
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* session_id;
@property (nonatomic, strong) NSString* user_id;
@property (nonatomic, strong) NSString* date_created;
@property (nonatomic, strong) NSString* last_modified;
@property (nonatomic) int status;
@property (nonatomic) BOOL isLeader;
@end
