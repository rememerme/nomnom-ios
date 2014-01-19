//
//  RequestService.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "RequestService.h"

@implementation RequestService

-(NSArray*) getFriendRequestsOfUserID:(User *)user {
    NSString *urlString = [@"http://134.53.148.103:8001/rest/v1/friends/requests/received/?access_token=" stringByAppendingString:user.session_id];
    NSLog(@"%@", urlString);
    
    NSError *requestError = nil;
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
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
            FriendRequest *fr = [[FriendRequest alloc]init];
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

-(NSArray*) getGameRequestsOfUserID:(User *)user {
    NSString *urlString = [@"http://134.53.148.103:8002/rest/v1/games/requests/?access_token=" stringByAppendingString:user.session_id];
    NSLog(@"%@", urlString);
    
    NSError *requestError = nil;
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        NSLog(@"Game Requests received for: %@", user.user_id);
        NSError *parseError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        NSMutableArray *retArray = [[NSMutableArray alloc]init];
        for (NSDictionary *ret in dict) {
            NSLog(@"%@", ret);
            GameRequest *gr = [[GameRequest alloc]init];
            
            gr.status = (NSInteger*)[[ret objectForKey:@"status"]integerValue];
            gr.game_id = (NSString *)[ret objectForKey:@"game_id"];
            gr.game_member_id = (NSString *)[ret objectForKey:@"game_member_id"];
            gr.user_id = (NSString *)[ret objectForKey:@"user_id"];
            gr.date_created = (NSString *)[ret objectForKey:@"date_created"];
            gr.last_modified = (NSString *)[ret objectForKey:@"last_modified"];
            FriendService *fs = [[FriendService alloc]init];
            Friend *u = [fs getFriendWithUserID:gr.user_id andSession:user.session_id];
            gr.username = u.username;
            [retArray addObject:gr];
        }
        
        return [[NSArray alloc] initWithArray:retArray];
    } else {
        NSLog(@"Game Request error %@, %i", requestError, [response statusCode]);
        return nil;
    }
}

-(void)removeFriendRequestWithUserID:(NSString*)user_id andSession:(NSString*)session_id {
    NSString *urlString = [@"http://134.53.148.103:8001/rest/v1/friends/requests/received/?" stringByAppendingString:user_id];
    urlString = [urlString stringByAppendingString:@"access_token="];
    urlString = [urlString stringByAppendingString:session_id];
    NSLog(@"%@", urlString);
    
    NSError *requestError = nil;
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"DELETE"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        NSLog(@"Friend Request denied for: %@", user_id);
    } else {
        NSLog(@"Friend Request deny error %@, %i", requestError, [response statusCode]);
    }
}

-(void) confimFriendRequestWithUserID:(NSString *)user_id andSession:(NSString *)session_id {
    NSString *urlString = [@"http://134.53.148.103:8001/rest/v1/friends/requests/received/" stringByAppendingString:user_id];
    urlString = [urlString stringByAppendingString:@"?access_token="];
    urlString = [urlString stringByAppendingString:session_id];
    NSLog(@"%@", urlString);
    
    NSError *requestError = nil;
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"PUT"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        NSLog(@"Friend Request accepted for: %@", user_id);
    } else {
        NSLog(@"Friend Request accept error %@, %i", requestError, [response statusCode]);
    }

}

@end
