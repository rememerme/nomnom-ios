//
//  NominationsViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Nomination.h"
#import "NominationCard.h"
#import "PhraseCard.h"
#import "GameService.h"
#import "Round.h"
#import "Game.h"
#import "NomNomView.h"

@interface NominationsViewController : UIViewController

@property (nonatomic, strong) User* user;
@property (nonatomic, strong) Game* game;
@property (nonatomic, strong) PhraseCard *phrase_card;
@property (nonatomic, strong) NSArray *nominations;

-(id)initWithUser:(User*)user andGame:(Game*)game;

@end
