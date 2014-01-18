//
//  Game.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, strong) NSString *game_id;
@property (nonatomic, strong) NSString *party_id;
@property (nonatomic, strong) NSString *date_created;
@property (nonatomic, strong) NSString *last_modified;
@property (nonatomic, strong) NSString *current_round_id;

@end
