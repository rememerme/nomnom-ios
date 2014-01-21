//
//  GameService.h
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "Friend.h"
#import "FriendService.h"
#import "User.h"
#import "Round.h"
#import "Nomination.h"
#import "PhraseCard.h"
#import "NominationCard.h"

@interface GameService : NSObject

-(NSArray*) getGamesWithSession:(NSString*)session_id;
-(void) createGameWithMembers:(NSArray*)members andWinningScore:(NSInteger*)score andSession:(NSString*)session_id;
-(NSArray*) getGameMembersForGameID:(NSString*)game_id andSession:(User*)user;
-(Round*) getCurrentRoundForGameID:(NSString*)game_id andSession:(User*)user;
-(Round*) startGameWithGameID:(NSString*)game_id andSession:(User*)user;
-(NominationCard*) nominateWithNomination:(NominationCard*)nomination andGame:(Game*)game andSession:(User*)user;
-(PhraseCard*) getCardWithRound:(Round*)round andSession:(User*)user;

@end
