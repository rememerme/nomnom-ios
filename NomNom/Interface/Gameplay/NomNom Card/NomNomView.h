//
//  NomNomView.h
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameService.h"
#import "NominationCard.h"
#import "User.h"
#import "Game.h"
#import "NominationCard.h"

@interface NomNomView : UIView

@property (nonatomic, strong) UILabel *description;
@property (nonatomic, strong) UILabel *term;
@property (nonatomic, strong) NSString *nomination_card_id;
@property (nonatomic, strong) User* user;
@property (nonatomic, strong) Game* game;

- (id)initWithFrame:(CGRect)frame andUser:(User*)user andGame:(Game*)game;

@end
