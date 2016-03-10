//
//  RestApi.m
//  HTTP
//
//  Created by Nikolay on 10.03.16.
//  Copyright © 2016 Nikolay. All rights reserved.
//

#import "RestApi.h"

@interface RestApi () <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) NSURLConnection *requestConnection;
@end

@implementation RestApi

-(NSMutableData *)receivedData{

    if (!self.receivedData) {
        self.receivedData = [[NSMutableData alloc] init];
    }
    return self.receivedData;
}

-(NSURLConnection *)requestConnection{

    if (!self.requestConnection) {
        self.requestConnection = [[NSURLConnection alloc]init];
    }
    return self.requestConnection;
}

-(void)httpRquest:(NSMutableURLRequest *)request{
    self.requestConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.delegate getReceivedData:self.receivedData sendar:self];
    self.delegate = nil;
    self.requestConnection = nil;
    self.receivedData = nil;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@" ,error.description);
}

@end
