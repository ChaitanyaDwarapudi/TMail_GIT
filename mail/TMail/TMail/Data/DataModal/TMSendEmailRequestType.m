//
//  SendEmailRequestType.m
//  TMail
//
//  Created by Ranjith on 5/14/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import "TMSendEmailRequestType.h" 


@implementation TMSendEmailRequestType
@synthesize receiverInfo;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static TMSendEmailRequestType *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        receiverInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
