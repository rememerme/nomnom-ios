//
//  GameService.h
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface GameService : NSObject

-(NSArray*) getGamesWithSession:(NSString*)session_id;
-(void) createGameWithMembers:(NSArray*)members andWinningScore:(NSInteger*)score andSession:(NSString*)session_id;

@end
