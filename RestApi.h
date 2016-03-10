//
//  RestApi.h
//  HTTP
//
//  Created by Nikolay on 10.03.16.
//  Copyright © 2016 Nikolay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestApi;
@protocol RectApiDelegate
-(void)getReceivedData:(NSMutableArray *)data sendar:(RestApi *)sendar;
@end

@interface RestApi : NSObject
-(void)httpRquest:(NSMutableURLRequest *)request;

@property (nonatomic, weak) id <RectApiDelegate> delegate;
@end

#define POST @"POST"
#define  GET @"GET"