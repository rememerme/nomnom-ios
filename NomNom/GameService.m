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

@end
