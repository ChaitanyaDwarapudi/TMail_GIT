//
//  TMWebserviceHandler.h
//  TMail
//
//  Created by Chaitanya on 5/15/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TMWebserviceHanderDelegate <NSObject>

- (void)successWebserviceResponse:(id)successResponse;
- (void)failureWebserviceResponse:(id)failureResponse;

@end


@interface TMWebserviceHandler : NSObject<NSURLConnectionDelegate>
{
    NSURLConnection *connection;
    NSMutableData *mutabledata;
}
@property (nonatomic, weak) id <TMWebserviceHanderDelegate> delegate;

- (void)activeDirectoryWebserviceURL:(NSString*)URL;


@end
