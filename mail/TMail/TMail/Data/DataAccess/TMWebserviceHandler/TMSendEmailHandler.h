//
//  TMSendEmailHandler.h
//  TMail
//
//  Created by Ranjith on 5/14/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TMSendEmail_Enums.h"
#import "TMSendEmailRequestType.h"


@interface TMSendEmailHandler : NSObject
{
}
@property SoapProtocolVersion soapVersion;
@property BOOL allowAutoRedirect;
@property BOOL enableDecompression;
@property (nonatomic, copy) NSString *userAgent;
@property BOOL unsafeAuthenticatedConnectionSharing;
@property BOOL useDefaultCredentials;
@property (nonatomic, copy) NSString *connectionGroupName;
@property BOOL preAuthenticate;
@property (nonatomic, copy) NSString *url;
@property int timeout;
@property (nonatomic, assign) void(*targetAction)(id target,id sender,NSString* xml);
@property (nonatomic,assign) id actionDelegate;
@property (nonatomic, strong) NSURLConnection *wsConnection;
@property (nonatomic, strong) NSMutableData *webData;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSMutableDictionary *requestHeaders;
@property (nonatomic, copy)   NSString *eventName;

///Origin Return Type:ESIBaseResponseType
-(void)sendEmail:(TMSendEmailRequestType *)sendEmailRequest ;
-(id) initWithTarget:(id)target  AndAction:(void(*)(id target,id sender ,NSString* xml))action;
-(void) addTarget:(id)target AndAction:(void(*)(id target,id sender ,NSString* xml))action;
@end
