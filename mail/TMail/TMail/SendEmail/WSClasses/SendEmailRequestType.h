//
//  SendEmailRequestType.h
//  TMail
//
//  Created by Ranjith on 5/14/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SendEmailRequestType : NSObject
{
}


@property (nonatomic, strong) NSString *fromEmailName;
@property (nonatomic, strong) NSString *fromEmailId;
@property (nonatomic, strong) NSString *mailSubject;
@property (nonatomic, strong) NSString *mailContent;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *bodyType;
@property (nonatomic, strong) NSString *attachmentName;
@property (nonatomic, strong) NSString *attachmentContent;
@property (nonatomic, strong) NSString *attachmentType;
//Need to change as mutable array, Since we might need to send to multiple users
@property (nonatomic, strong) NSString *receiverEmailName;
@property (nonatomic, strong) NSString *receiverEmailId;


@end
