//
//  TMSendEmailServiceCall.m
//  TMail
//
//  Created by Ranjith on 5/14/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
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
- (void)sendEmail:(SendEmailRequestType *)sendEmailRequest {
    [self.service addTarget:self AndAction:&sendEmailTarget];
    [self.service SendEmail:sendEmailRequest ];
}

void sendEmailTarget(TMSendEmailServiceCall* target, id sender, NSString* xml){
    
    if (nil!= xml && xml.length>0) {
        [target.proxyDelegate sendEmailSuccess:xml InMethod:@"SendEmail"];
        return;
    }else{
        [target.proxyDelegate sendEmailError:@"Reponse nil" InMethod:@"SendEmail"];
        return;
    }
    
    /*@try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://services.tmobile.com/notification\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate sendEmailError:exception InMethod:@"SendEmail"];
                return;
            }
        }
        NSArray* array0 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        ESIBaseResponseType* result = [[ESIBaseResponseType alloc]initWithArray:array0];
         if (target.proxyDelegate != nil){
            [target.proxyDelegate sendEmailSuccess:result InMethod:@"SendEmail"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate sendEmailError:ex InMethod:@"SendEmail"];
            return;
        }
    }*/
}


@end
