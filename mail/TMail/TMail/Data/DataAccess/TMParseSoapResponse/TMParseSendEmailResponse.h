//
//  TMParseSendEmailResponse.h
//  TMail
//
//  Created by Ranjith on 5/18/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMParseSendEmailResponse : NSObject <NSXMLParserDelegate>
 //To keep track of the current element value.
 @property (nonatomic, strong) NSString *elementValue;
 //To parse, set and get the response status
 @property (nonatomic, strong) NSString *sendEmailResponseStatus;
 //To parse, set and get the response message
 @property (nonatomic, strong) NSString *sendEmailResponseMessage;

@end
