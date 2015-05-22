//
//  TMApplicationLog.h
//  T-Mail
//
//  Created by Chaitanya on 5/18/15.
//  Copyright (c) 2015 T-Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMApplicationLog.h"
#import "TMConstants.h"
typedef enum TMApplicationLogLevel
{
    kTapestryLogLevel_off = 0,
    kTapestryLogLevel_Usage,
    kTapestryLogLevel_Error,
    kTapestryLogLevel_Warning
}TMApplicationLogLevel;


/*
 #define TapestryLogError(device,module,function,msg,...) [TapestryLog Log:kTapestryLogLevel_Error device:devie module:module function:function message:msg]
 
 #define TapestryLogWarning(device,module,function,msg,...)  [TapestryLog Log:kTapestryLogLevel_Warning device:devie module:module function:function message:msg]
 
 #define TapestryLogUsage(device,tool,msg,...) [TapestryLog Log:kTapestryLogLevel_Usage device:devie module:tool function:nil message:msg]
 */

/**
 TMApplication log class hold the logic of logging functionality webservice.
 */
@interface TMApplicationLog : NSObject

@property(nonatomic) TMApplicationLogLevel currentLogLevel;
+ (TMApplicationLog *)sharedLog;
/**
 This method gerenates log message and send generated message to log webservice
 */
- (void)Log :(NSString *)note;
/**
 This is post notification method, its fire when log message saved in directory.
 */
- (void)pushLogMessagesToServer;
/**
 This method which saves log information when network is disable.
 */
- (void)logSavedMessages;
/**
 This method which returns a boolean value whether to save log message everytime when application is become active state.
 */
- (BOOL)canLogMesage;

@end
