//
//  TMWebserviceHandler.m
//  TMail
//
//  Created by Chaitanya on 5/15/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import "TMWebserviceHandler.h"

@implementation TMWebserviceHandler



- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)activeDirectoryWebserviceURL:(NSString*)urlString
{
    NSURL *url = [NSURL fileURLWithPath:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark- NSURL Connection


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    mutabledata = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [mutabledata appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *error;
    id  parsedData = [NSJSONSerialization JSONObjectWithData:mutabledata options:kNilOptions error:&error];
    NSLog(@"register data: %@",parsedData);
    [self.delegate successWebserviceResponse:parsedData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Failure  Description: %@",[error description]);
    [self.delegate failureWebserviceResponse:[error description]];
}



@end
