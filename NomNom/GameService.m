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
        NSLog(@"Request error %@", requestError);
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
        NSMutableArray *retArray = [[NSMutableArray alloc]init];
        NSArray *keys = [dict allKeys];
        for (NSString* key in keys) {
            Friend *fr = [[Friend alloc]init];
            fr.user_id = key;
            fr.date_created = (NSString *)[dict objectForKey:key];
            FriendService *fs = [[FriendService alloc]init];
            Friend *u = [fs getFriendWithUserID:fr.user_id andSession:user.session_id];
            fr.username = u.username;
            [retArray addObject:fr];
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
        NSLog(@"Friend Requests received for: %@", user.user_id);
        NSError *parseError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        NSDictionary *real_dict = (NSDictionary*)[dict objectForKey:@"requests"];
        NSMutableArray *retArray = [[NSMutableArray alloc]init];
        NSArray *keys = [real_dict allKeys];
        for (NSString* key in keys) {
            Friend *fr = [[Friend alloc]init];
            fr.user_id = key;
            fr.date_created = (NSString *)[real_dict objectForKey:key];
            FriendService *fs = [[FriendService alloc]init];
            Friend *u = [fs getFriendWithUserID:fr.user_id andSession:user.session_id];
            fr.username = u.username;
            [retArray addObject:fr];
        }
        
        return [[NSArray alloc] initWithArray:retArray];
    } else {
        NSLog(@"Friend Request error %@, %i", requestError, [response statusCode]);
        return nil;
    }

}

@end
