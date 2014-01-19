//
//  GameRequest.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameRequest : NSObject

@property (nonatomic, strong) NSString *game_id;
@property (nonatomic, strong) NSString *game_member_id;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic) NSInteger *status;
@property (nonatomic, strong) NSString *date_created;
@property (nonatomic, strong) NSString *last_modified;
@property (nonatomic, strong) NSString *username;

@end
