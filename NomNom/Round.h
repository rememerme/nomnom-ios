//
//  Round.h
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Round : NSObject

@property (nonatomic, strong) NSString *game_id;
@property (nonatomic, strong) NSString *selector_id;
@property (nonatomic, strong) NSString *selection_id;
@property (nonatomic, strong) NSString *phrase_card_id;
@property (nonatomic, strong) NSString *round_id;
@property (nonatomic, strong) NSString *date_created;
@property (nonatomic, strong) NSString *last_modified;

@end
