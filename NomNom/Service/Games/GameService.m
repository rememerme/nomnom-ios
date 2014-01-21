//
//  GameService.m
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "GameService.h"

@implementation GameService

-(NSArray*) getGamesWithSession:(NSString *)session_id {
    NSString *urlString = [@"http://134.53.148.103:8002/rest/v1/games/?access_token=" stringByAppendingString:session_id];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSError *requestError = nil;
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode]==200){
        NSLog(@"Friend Response Success");
        
        NSError *parseError = nil;
        NSArray *resultsArray = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        NSLog(@"%@", resultsArray);
        NSMutableArray *retArray = [[NSMutableArray alloc] init];
        
        if(resultsArray){
            //NSArray * friends = (NSArray*)[resultsArray objectForKey:@"friends_list"];
            for (NSDictionary* dict in resultsArray) {
                Game *g = [[Game alloc]init];
                g.game_id = (NSString*)[dict objectForKey:@"game_id"];
                g.leader_id = (NSString*)[dict objectForKey:@"leader_id"];
                g.current_round_id = (NSString*)[dict objectForKey:@"current_round_id"];
                g.date_created = (NSString*)[dict objectForKey:@"date_created"];
                g.last_modified = (NSString*)[dict objectForKey:@"last_modified"];
                [retArray addObject:g];
            }
        } else {
            NSLog(@"Parse error %@", requestError);
        }
        
        return [[NSArray alloc] initWithArray:retArray];
    } else {
        NSLog(@"Request error %@, %i", requestError, [response statusCode]);
        return nil;
    }
}

-(void) createGameWithMembers:(NSArray *)members andWinningScore:(NSInteger *)score andSession:(NSString *)session_id {
    NSString *urlString = [@"http://134.53.148.103:8002/rest/v1/games/?access_token=" stringByAppendingString:session_id];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    // make request body
    for (NSString* str in members) {
        NSString *ns = [NSString stringWithFormat:@"\"%@\"", str];
        [arr addObject:ns];
    }
    members = [[NSArray alloc] initWithArray:arr];
    NSString* members_str = [members componentsJoinedByString:@", "];
    members_str = [@"[" stringByAppendingString:members_str];
    members_str = [members_str stringByAppendingString:@"]"];
    NSLog(@"Member str: %@", members_str);
    NSArray *objects = [NSArray arrayWithObjects: members_str,[NSNumber numberWithInt:score], nil];
    NSArray *keys = [NSArray arrayWithObjects:@"game_members",@"winning_score", nil];
    NSDictionary *postDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *requestError = nil;
    NSData *jsonRequest = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&requestError];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonRequest];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode]==200){
        NSLog(@"Game Created");
        
    } else {
        NSLog(@"Game Creation Error %@, %i", requestError, [response statusCode]);
    }
}
-(NSArray*) getGameMembersForGameID:(NSString *)game_id andSession:(User*)user {
    NSString *urlString = [@"http://134.53.148.103:8002/rest/v1/games/" stringByAppendingString:game_id];
    urlString = [urlString stringByAppendingString:@"/members/?access_token="];
    urlString = [urlString stringByAppendingString:user.session_id];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSError *requestError = nil;
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        NSLog(@"Friend Requests received for: %@", user.user_id);
        
        NSError *parseError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        //NSDictionary *real_dict = (NSDictionary*)[dict objectForKey:@"d"];
        NSLog(@"%@", dict);
        NSMutableArray *retArray = [[NSMutableArray alloc]init];
        FriendService *fs = [[FriendService alloc]init];
        for (NSDictionary* user_d in dict) {
            User *u = [[User alloc]init];
            //u.game_id = (NSString*)[user objectForKey:@"game_id"];
            //u.leader_id = (NSString*)[user objectForKey:@"leader_id"];
            //u.current_round_id = (NSString*)[user objectForKey:@"current_round_id"];
            u.user_id = (NSString*)[user_d objectForKey:@"user_id"];
            u.username = ((Friend*)[fs getFriendWithUserID:u.user_id andSession:user.session_id]).username;
            u.date_created = (NSString*)[user_d objectForKey:@"date_created"];
            u.last_modified = (NSString*)[user_d objectForKey:@"last_modified"];
            u.status = [[user_d objectForKey:@"status"]integerValue];
            NSString *leader = (NSString*)[user_d objectForKey:@"leader_id"];
            u.isLeader = ([leader isEqualToString:u.user_id]) ? YES : NO;
            
            [retArray addObject:u];
        }
        
        return [[NSArray alloc] initWithArray:retArray];
    } else {
        NSLog(@"Friend Request error %@, %i", requestError, [response statusCode]);
        return nil;
    }

}
// games/<id>/rounds/current/
// returns {round_id, selector_id, selection_id, phrase_card_id, game_id, date_created, last_modified}

-(Round*) getCurrentRoundForGameID:(NSString *)game_id andSession:(User *)user {
    NSString *urlString = [@"http://134.53.148.103:8002/rest/v1/games/" stringByAppendingString:game_id];
    urlString = [urlString stringByAppendingString:@"/rounds/current/?access_token="];
    urlString = [urlString stringByAppendingString:user.session_id];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSError *requestError = nil;
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        
        NSError *parseError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        NSLog(@"Current round received: %@", dict);
        //NSDictionary *real_dict = (NSDictionary*)[dict objectForKey:@"requests"];
        Round *r = [[Round alloc]init];
        r.selector_id = (NSString*)[dict objectForKey:@"selector_id"];
        r.selection_id = (NSString*)[dict objectForKey:@"selection_id"];
        r.phrase_card_id = (NSString*)[dict objectForKey:@"phrase_card_id"];
        r.last_modified = (NSString*)[dict objectForKey:@"last_modified"];
        r.date_created = (NSString*)[dict objectForKey:@"date_created"];
        r.round_id = (NSString*)[dict objectForKey:@"round_id"];
        r.game_id = (NSString*)[dict objectForKey:@"game_id"];
        
        return r;
    } else {
        NSLog(@"Current round error %@, %i", requestError, [response statusCode]);
        return nil;
    }

}

-(Round*) startGameWithGameID:(NSString *)game_id andSession:(User *)user {
    // games/<game_id>/rounds/ POST
    // deck_id = 13713f98-810b-11e3-8eca-fa163e50388f
    NSString *urlString = [@"http://134.53.148.103:8002/rest/v1/games/" stringByAppendingString:game_id];
    urlString = [urlString stringByAppendingString:@"/rounds/?access_token="];
    urlString = [urlString stringByAppendingString:user.session_id];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
   
    NSArray *objects = [NSArray arrayWithObjects: @"13713f98-810b-11e3-8eca-fa163e50388f", nil];
    NSArray *keys = [NSArray arrayWithObjects:@"deck_id", nil];
    NSDictionary *postDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *requestError = nil;
    NSData *jsonRequest = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&requestError];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonRequest];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];

    //Handle the response
    if(adata && [response statusCode] == 200){
        NSLog(@"Game has been started: %@", game_id);
        
        NSError *parseError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        NSDictionary *real_dict = (NSDictionary*)[dict objectForKey:@"requests"];
        NSMutableArray *retArray = [[NSMutableArray alloc]init];
        Round *r = [[Round alloc]init];
        r.selector_id = (NSString*)[dict objectForKey:@"selector_id"];
        r.selection_id = (NSString*)[dict objectForKey:@"selection_id"];
        r.phrase_card_id = (NSString*)[dict objectForKey:@"phrase_card_id"];
        r.last_modified = (NSString*)[dict objectForKey:@"last_modified"];
        r.date_created = (NSString*)[dict objectForKey:@"date_created"];
        r.round_id = (NSString*)[dict objectForKey:@"round_id"];
        r.game_id = (NSString*)[dict objectForKey:@"game_id"];
        return r;
         
    } else {
        NSLog(@"Friend Request error %@, %i", requestError, [response statusCode]);
        
        return nil;
        
    }

}

-(NominationCard*) nominateWithNomination:(NominationCard *)nomination andGame:(Game*)game andSession:(User *)user {
    NSString *urlString = [@"http://134.53.148.103:8002/rest/v1/games/" stringByAppendingString:game.game_id];
    urlString = [urlString stringByAppendingString:@"/rounds/nominations/?access_token="];
    urlString = [urlString stringByAppendingString:user.session_id];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    
    NSArray *objects = [NSArray arrayWithObjects: game.game_id, nomination.nomination_card_id, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"game_id", @"nomination_card_id", nil];
    NSLog(@"Objects: %@", objects);
    NSLog(@"Keys: %@", keys);
    NSDictionary *postDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *requestError = nil;
    NSData *jsonRequest = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&requestError];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonRequest];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        NSLog(@"Game has been started: %@", nomination);
        
        NSError *parseError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        NSDictionary *real_dict = (NSDictionary*)[dict objectForKey:@"requests"];
        NSMutableArray *retArray = [[NSMutableArray alloc]init];
        
        return nomination;
        
    } else {
        NSLog(@"Nomination Request error %@, %i", requestError, [response statusCode]);
        
        return nil;
        
    }

}

-(PhraseCard*) getCardWithRound:(Round*)round andSession:(User *)user {
    NSString *urlString = [@"http://134.53.148.103:8002/rest/v1/cards/" stringByAppendingString:round.phrase_card_id];
    urlString = [urlString stringByAppendingString:@"?access_token=" ];
    urlString = [urlString stringByAppendingString:user.session_id];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSError *requestError = nil;
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        
        NSError *parseError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        NSLog(@"Current round received: %@", dict);
        PhraseCard *r = [[PhraseCard alloc]init];
        r.phrase_card_id = (NSString*)[dict objectForKey:@"phrase_card_id"];
        r.term = (NSString*)[dict objectForKey:@"term"];
        r.description = (NSString*)[dict objectForKey:@"description"];
        return r;
        
    } else {
        NSLog(@"Current round error %@, %i", requestError, [response statusCode]);
        return nil;
    }
}

@end
