//
//  Nomination.h
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nomination : NSObject

@property (nonatomic, strong) NSString *round_id;
@property (nonatomic, strong) NSString *nominator_id;
@property (nonatomic, strong) NSString *nomination_card_id;
@property (nonatomic, strong) NSString *date_created;
@property (nonatomic, strong) NSString *last_modified;
@property (nonatomic, strong) NSString *nomination_id;

@end
