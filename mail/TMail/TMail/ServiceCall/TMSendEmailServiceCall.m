//
//  TMSendEmailServiceCall.m
//  TMail
//
//  Created by Ranjith on 5/14/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import "TMSendEmailServiceCall.h"

@implementation TMSendEmailServiceCall

- (id)initWithUrl:(NSString*)url AndDelegate:(id<SendEmailDelegate>)delegate{
    self = [super init];
    if (self != nil){
        self.service = [[TMSendEmailHandler alloc] init];
        [self.service setUrl:url];
        [self setUrl:url];
        [self setProxyDelegate:delegate];
    }
    return self;
}

///Origin Return Type:ESIBaseResponseType
- (void)sendEmail:(TMSendEmailRequestType *)sendEmailRequest {
    [self.service addTarget:self AndAction:&sendEmailTarget];
    [self.service sendEmail:sendEmailRequest ];
}

void sendEmailTarget(TMSendEmailServiceCall* target, id sender, NSString* xml){
    
    if (nil!= xml && xml.length>0) {
        [target.proxyDelegate sendEmailSuccess:xml InMethod:@"SendEmail"];
        return;
    }else{
        [target.proxyDelegate sendEmailError:@"Reponse nil" InMethod:@"SendEmail"];
        return;
    }
}


@end
