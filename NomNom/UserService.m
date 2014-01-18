//
//  UserService.m
//  Nominal Nominations
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "UserService.h"

@implementation UserService

-(NSArray *) loginUserWithCredentials:(Login *)creds {
    NSString *urlString = @"http://134.53.148.103:8000/rest/v1/sessions/";
    NSLog(@"%@", urlString);
    // make request body
    NSData *postBody = [[NSData alloc] init];
    [postBody setValue:creds.username forKey:@"username"];
    [postBody setValue:creds.password forKey:@"password"];
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:postBody];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Make the request
    NSURLResponse* response = [[NSURLResponse alloc] init];
    NSError *requestError = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    
    //Handle the response
    if(adata){
        NSLog(@"Bus Response Success");
        
        NSError *parseError = nil;
        NSArray *resultsArray = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        
        if(resultsArray){
            for(NSDictionary *dict in resultsArray){
                NSLog(@"Woot it worked");
            }
        } else {
            NSLog(@"Parse error %@", requestError);
        }
        
        return [[NSArray alloc] initWithArray:res];
    } else {
        NSLog(@"Request error %@", requestError);
        return nil;
    }
}

@end
