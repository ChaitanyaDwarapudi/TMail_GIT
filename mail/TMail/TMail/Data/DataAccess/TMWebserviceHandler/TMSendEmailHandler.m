//
//  TMSendEmailHandler.m
//  TMail
//
//  Created by Ranjith on 5/14/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//
#import "TMSendEmailHandler.h" 


@implementation TMSendEmailHandler


///Origin Return Type:ESIBaseResponseType
- (void)sendEmail:(TMSendEmailRequestType *)sendEmailRequest {
    NSMutableString *params = [NSMutableString string];
    [params appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ema=\"http://services.tmobile.com/esi/email\" xmlns:base=\"http://www.t-mobile.com/esi/base\"><soapenv:Header/><soapenv:Body><ema:sendEmailRequest><base:requestHeader></base:requestHeader><ema:senderInfo><ema:fromName>"];
       // FromName
    [params appendFormat:@"%@",sendEmailRequest.fromEmailName];
    [params appendString:@"</ema:fromName><ema:emailId>"];
       // From Email Id
    [params appendFormat:@"%@",sendEmailRequest.fromEmailId];
    [params appendString:@"</ema:emailId></ema:senderInfo><ema:email><ema:subject>"];
       // Mail Subject
    [params appendFormat:@"%@",sendEmailRequest.mailSubject];
    [params appendString:@"</ema:subject><ema:contentInfo><ema:content>"];
       //Email Content
    [params appendFormat:@"%@",sendEmailRequest.mailContent];
    [params appendString:@"</ema:content><ema:display>"];
       // Hard coded value as " body "
    [params appendFormat:@"%@",sendEmailRequest.body];
    [params appendString:@"</ema:display><ema:displayType>"];
       //Hard coded value as " text/plain "
    [params appendFormat:@"%@",sendEmailRequest.bodyType];
    [params appendString:@"</ema:displayType><ema:attachment><ema:fileName>"];
       // attchment file name with "." format
    [params appendFormat:@"%@",sendEmailRequest.attachmentName];
    [params appendString:@"</ema:fileName><ema:content>"];
       // pdf content with base64 encoded format
    [params appendFormat:@"%@",sendEmailRequest.attachmentContent];
    [params appendString:@"</ema:content><ema:displayType>"];
       //Hard coded valud as application/pdf
    [params appendFormat:@"%@",sendEmailRequest.attachmentType];
    [params appendString:@"</ema:displayType></ema:attachment></ema:contentInfo><ema:receiverInfo><ema:fullName>"];
       //Receiver Name
    [params appendFormat:@"%@",sendEmailRequest.receiverEmailName];
    [params appendString:@"</ema:fullName><ema:emailId>"];
       //Receiver Mail Id
    [params appendFormat:@"%@",sendEmailRequest.receiverEmailId];
     [params appendString:@"</ema:emailId></ema:receiverInfo></ema:email></ema:sendEmailRequest></soapenv:Body></soapenv:Envelope>"];
    
    NSURL *onwURL = [[NSURL alloc] initWithString:[self url]];
    NSMutableURLRequest *onwreq = [NSMutableURLRequest requestWithURL:onwURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];
    NSString *messageLen = [NSString stringWithFormat:@"%lu", (unsigned long)[params length]];
    [onwreq addValue:[onwURL host] forHTTPHeaderField:@"Host"];
    
    //Ranjith Changed SOAP action to match to our requirment
    //[onwreq addValue:@"http://services.tmobile.com/notification/SendEmail" forHTTPHeaderField:@"SOAPAction"];
    
    [onwreq addValue:@"/Notification/Email/Send" forHTTPHeaderField:@"SOAPAction"];
    [onwreq addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [onwreq addValue:messageLen forHTTPHeaderField:@"Content-Length"];
    [onwreq setHTTPMethod:@"POST"];
    [onwreq setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    for (NSString *key  in [self.requestHeaders allKeys]) {
    		[onwreq addValue:[self.requestHeaders valueForKey:key] forHTTPHeaderField:key];
    }
    self.wsConnection = [[NSURLConnection alloc] initWithRequest:onwreq delegate:self];
    [self setEventName:@"http://services.tmobile.com/notificationSendEmailDidFinish"];
}

- (id)init{
    self = [super init];
    if (self){
        [self setUrl:@""];
    }
    return self;
}

- (id)initWithTarget:(id)target  AndAction:(void(*)(id target,id sender ,NSString* xml))action {
    self = [super init];
    if (self != nil) {
        [self setTargetAction:action];
        [self setActionDelegate:target];
    }
    return self;
}

- (void) addTarget:(id)target AndAction:(void(*)(id target,id sender,NSString* xml))action {
    self.actionDelegate = target;
    self.targetAction = action;
}

- (void)cancelConnection{
[self.wsConnection cancel];
}

#pragma mark - NSConnection events

-(void)connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response
{
    self.webData = [[NSMutableData alloc] init];
    [self.webData setLength:0];
}

-(void)connection:(NSURLConnection *) connection didReceiveData:(NSData *) data
{
    [self.webData appendData:data];
}

-(void)connection:(NSURLConnection *) connection didFailWithError:(NSError *) err
{
    [self setError:err];
    if (self.targetAction !=nil)
        self.targetAction(self.actionDelegate,self,nil);
}

-(void)connectionDidFinishLoading:(NSURLConnection *) connection
{
    NSString *xml = [[NSString alloc] initWithBytes:[self.webData mutableBytes] length:[self.webData length] encoding:NSUTF8StringEncoding];
    [self setError:nil];
    if (self.targetAction !=nil)
        self.targetAction(self.actionDelegate,self,xml);
}

@end
