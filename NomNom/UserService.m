//
//  UserService.m
//  Nominal Nominations
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "UserService.h"

@implementation UserService

-(User *) loginUserWithCredentials:(Login *)creds {
    NSString *urlString = @"http://134.53.148.103:8000/rest/v1/sessions/";
    NSLog(@"%@", urlString);
    // make request body
    
    
    NSArray *objects = [NSArray arrayWithObjects:creds.username, creds.password,nil];
    NSArray *keys = [NSArray arrayWithObjects:@"username", @"password",nil];
    NSDictionary *postDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *requestError = nil;
    NSData *jsonRequest = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&requestError];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"POST"];
    NSString* postBody = [[NSString alloc] initWithData:jsonRequest encoding:NSUTF8StringEncoding];
    [request setHTTPBody:jsonRequest];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata && [response statusCode]==200){
        NSLog(@"User Login Success");
        
        NSError *parseError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        User* user = [[User alloc] init];
        user.username = creds.username;

        if(dict){
            user.session_id = (NSString*)[dict objectForKey:@"session_id"];
            user.user_id = (NSString*)[dict objectForKey:@"user_id"];
            user.date_created = (NSString*)[dict objectForKey:@"date_created"];
            user.last_modified = (NSString*)[dict objectForKey:@"last_modified"];
        } else {
            NSLog(@"Parse error %@", requestError);
        }
        
        return user;
    } else {
        NSLog(@"Request error %@", requestError);
        return nil;
    }
}

-(NSArray*) getUserWithUsername:(NSString*)username andSession:(NSString *)session_id {
    NSString *urlString = [@"http://134.53.148.103/rest/v1/users/?username=" stringByAppendingString:username];
    urlString = [urlString stringByAppendingString:@"&access_token="];
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
        NSMutableArray *retArray = [[NSMutableArray alloc]init];
        
        if(dict){
            NSArray *real_dict = [dict objectForKey:@"data"];
            for (NSDictionary *user in real_dict) {
                Friend *temp = [[Friend alloc] init];
                temp.username = (NSString*)[user objectForKey:@"username"];
                temp.user_id = (NSString*)[user objectForKey:@"user_id"];
                [retArray addObject:temp];
            }
        } else {
            NSLog(@"Parse error %@", requestError);
        }
        
        NSLog(@"Results: %@", retArray);
        return [[NSArray alloc] initWithArray:retArray];
    } else {
        NSLog(@"Request error %@", requestError);
        return nil;
    }

}

@end
