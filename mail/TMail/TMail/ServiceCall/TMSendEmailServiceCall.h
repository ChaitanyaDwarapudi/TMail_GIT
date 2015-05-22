//
//  TMSendEmailServiceCall.h
//  TMail
//
//  Created by Ranjith on 5/14/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMSendEmailHandler.h"
#import "TMSendEmailRequestType.h"


@protocol SendEmailDelegate
//if service recieve an error this method will be called
-(void)sendEmailError:(NSString *)data InMethod:(NSString*)method;
//proxy finished, (id)data is the object of the relevant method service
-(void)sendEmailSuccess:(id)data InMethod:(NSString*)method;
@end

@interface TMSendEmailServiceCall : NSObject
@property (nonatomic,assign) id<SendEmailDelegate> proxyDelegate;
@property (nonatomic,copy)   NSString* url;
@property (nonatomic,retain) TMSendEmailHandler* service;

-(id)initWithUrl:(NSString*)url AndDelegate:(id<SendEmailDelegate>)delegate;
///Origin Return Type:ESIBaseResponseType
-(void)sendEmail:(TMSendEmailRequestType *)sendEmailRequest ;
@end
