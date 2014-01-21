//
//  FriendService.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "FriendService.h"

@implementation FriendService

-(NSArray*)getFriendsOfUserID:(User *)user {
    NSString *urlString = [@"http://134.53.148.103:8001/rest/v1/friends/?access_token=" stringByAppendingString:user.session_id];
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
        NSDictionary *resultsArray = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        NSLog(@"%@", resultsArray);
        NSMutableArray *retArray = [[NSMutableArray alloc] init];
        
        if(resultsArray){
            NSArray * friends = (NSArray*)[resultsArray objectForKey:@"friends_list"];
            for (NSString* temp in friends) {
                Friend *f = [self getFriendWithUserID:temp andSession:user.session_id];
                [retArray addObject:f];
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

-(Friend*) getFriendWithUserID:(NSString *)user_id andSession:(NSString *)session_id {
    NSString *urlString = [@"http://134.53.148.103/rest/v1/users/" stringByAppendingString:user_id];
    urlString = [urlString stringByAppendingString:@"?access_token="];
    urlString = [urlString stringByAppendingString:session_id];
    NSLog(@"%@", urlString);
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSError *requestError = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        NSLog(@"User Query Success");
        
        NSError *parseError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        Friend* friend = [[Friend alloc] init];

        if(dict){
            friend.user_id = user_id;
            friend.username = (NSString*)[dict objectForKey:@"username"];
        } else {
            NSLog(@"Parse error %@", requestError);
        }
        NSLog(@"Friend: %@, %@", friend.user_id, friend.username);
        return friend;
    } else {
        NSLog(@"Request error %@", requestError);
        return nil;
    }
    
}

-(void) removeFriendWithUserID:(NSString *)user_id andSession:(NSString *)session_id {
    NSString *urlString = [@"http://134.53.148.103:8001/rest/v1/friends/" stringByAppendingString:user_id];
    urlString = [urlString stringByAppendingString:@"?access_token="];
    urlString = [urlString stringByAppendingString:session_id];
    NSLog(@"%@", urlString);
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"DELETE"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSError *requestError = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        NSLog(@"Friend Removed: %@", user_id);
        
    } else {
        NSLog(@"Request error %@, %i", requestError, [response statusCode]);
    }
    

}

-(void) sendFriendRequestWithUserID:(NSString *)user_id andSession:(NSString *)session_id {
    NSString *urlString = [@"http://134.53.148.103:8001/rest/v1/friends/requests/?access_token=" stringByAppendingString:session_id];
    NSLog(@"%@", urlString);
    
    // make request body
    NSArray *objects = [NSArray arrayWithObjects:user_id, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"user_id", nil];
    NSDictionary *postDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *requestError = nil;
    NSData *jsonRequest = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&requestError];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonRequest];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode] == 200){
        NSLog(@"Friend Request: %@", user_id);
        
    } else {
        NSLog(@"Request error %@, %i", requestError, [response statusCode]);
    }
}

@end
