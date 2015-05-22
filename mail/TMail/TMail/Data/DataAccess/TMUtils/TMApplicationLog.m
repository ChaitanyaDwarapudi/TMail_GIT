//
//  TMApplicationLog.m
//  T-Mail


//  Created by Chaitanya on 5/18/15.
//  Copyright (c) 2015 T-Mobile. All rights reserved.
//

#import "TMApplicationLog.h"
#import <UIKit/UIKit.h>

@interface TMApplicationLog ()
@property(nonatomic) dispatch_queue_t logQueue;
@property(nonatomic) NSString *logFilePath;
@end
@implementation TMApplicationLog {
    
    NSMutableURLRequest *urlRequest;
    NSMutableArray *logEntries;
}


+ (TMApplicationLog *)sharedLog {
    static TMApplicationLog *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance=[[self alloc] init];
        
    });
    return sharedInstance;
    
}

- (void)Log :(NSString *)note {
    
    if (logEntries == nil) {
        logEntries = [[NSMutableArray alloc] init];
    }
    
    NSMutableDictionary *dictData = [[NSMutableDictionary alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    [dictData setValue: strDate forKey:kTapestryTimestampKey];
    [dictData setValue: [UIDevice currentDevice].name forKey:kDeviceNameKey];
    [dictData setValue:[NSString stringWithFormat:@"TMAIL"] forKeyPath:kDeviceIdKey];
    [dictData setValue:[NSString stringWithFormat:@""] forKey:kUserIdKey];
    [dictData setValue:[NSString stringWithFormat:@"IOS TMAIL"] forKeyPath:kAppNameKey];
    [dictData setValue:[NSString stringWithFormat:@"OPEN"] forKeyPath:kBusinessFlowTagKey];
    [dictData setValue:version forKey:kTapestryVersionKey];
    [dictData setValue:[NSString stringWithFormat:@"IOSTMAIL"] forKey:kMenuItemNameKey];
    [dictData setValue:[NSNumber numberWithInt:1] forKey:kLogLevelKey];
    [dictData setValue:[NSString stringWithFormat:@""] forKey:kNoteKey];
    
    if(!self.logQueue) {
        self.logQueue=dispatch_queue_create(kUsageTrackQueue, NULL);
    }
    
    dispatch_async(self.logQueue, ^{
        [self logInBackGround:dictData];
    });
}

- (void)pushLogMessagesToServer {
    
    NSMutableArray *savedEntries = [[NSMutableArray alloc] initWithContentsOfFile:self.logFilePath];
    NSLog(@"Saved Entries : %@ ", [savedEntries description]);
    for (NSDictionary *myDict in savedEntries) {
        if(!self.logQueue) {
            self.logQueue=dispatch_queue_create(kUsageTrackQueue, NULL);
        }
        
        dispatch_async(self.logQueue, ^{
            [self logInBackGround:myDict];
        });
    }
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsMessageSavedLocally];
    [logEntries removeAllObjects];
}
/**
 @Description This method runs in background queue which performs log webservice implementation.
 @param dictData log message
 */
-(void)logInBackGround :(NSDictionary *)dictData {
    NSString *strURL = [self getLogServerURL];
    strURL= [NSString stringWithFormat:@"%@/%@",strURL, kREST_EndPoint_Log];
    NSLog(@"DEV LOG URL : %@ ", strURL);
    
    __block NSError *error;
    
    if(urlRequest==nil) {
        urlRequest=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
        [urlRequest setValue:@"json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setTimeoutInterval:10.0];
    }
    
    [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:dictData options:NSJSONWritingPrettyPrinted error:&error]];
    //[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if(response==nil || error) {
                                   NSLog(@"Data - Rest Accessible request failed %@ ,%@",response,error.localizedDescription);
                                   NSLog(@"Logged Message : %@ ", [dictData description]);
                                   if ([self logFileCreated]) {
                                       [self saveLogDataLocally:dictData];
                                       [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsMessageSavedLocally];
                                   }
                               }
                               else {
                                   NSLog(@"Data - Rest Accessible Succeed");
                               }
                           }];
    
}

- (dispatch_queue_t)logQueue {
    if(!_logQueue) {
        _logQueue=dispatch_queue_create(kUsageTrackQueue, NULL);
    }
    return _logQueue;
}

- (void)logSavedMessages {
    NSString *strURL = [self getLogServerURL];
    [self isRestAccessible:strURL];
}

- (BOOL)isRestAccessible:(NSString*)restURL {
    
    NSMutableURLRequest *restAccessCheckRequest=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:restURL]];
    
    [restAccessCheckRequest setHTTPMethod:@"POST"];
    [restAccessCheckRequest setTimeoutInterval:10.0];
    
    __block BOOL result;
    if(urlRequest == nil)
    {
        result = false;
        return result;
    }
    [NSURLConnection sendAsynchronousRequest:restAccessCheckRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if(response==nil || error) {
                                   result = NO;
                               }
                               else {
                                   result = YES;
                                   [[NSNotificationCenter defaultCenter] postNotificationName:kREST_AccessibleNotification object:nil];
                                   [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsMessageSavedLocally];
                               }
                               
                           }];
    return result;
}
/**
 This method returns URL based on plist information.
 */
- (NSString*)getLogServerURL {
    BOOL logToProduction = [[[[NSBundle mainBundle] infoDictionary] valueForKey:kLogServerType] boolValue];
    NSString *strURL;
    if (logToProduction) {
        strURL = kREST_URL_LOG_PROD;
    } else {
        strURL = kREST_URL_LOG_DEV;
    }
    
    return [NSString stringWithFormat:@"%@/%@",strURL, kREST_EndPoint_Log];
}
/**
 @Description This method returns boolean value whether log message is saved in directory or create new file manager.
 */
- (BOOL)logFileCreated{
    self.logFilePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:kLogManagerFileName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:self.logFilePath])
    {
        return [[NSFileManager defaultManager] createFileAtPath:self.logFilePath contents:nil attributes:nil];
    }
    return YES;
}
/**
 @Description This method returns path of document directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)saveLogMsgLocally:(NSString*)logMesaage {
    NSData *statuslogData=[logMesaage dataUsingEncoding:NSUTF8StringEncoding];
    [[self getLogFileHandler:self.logFilePath] writeData:statuslogData];
}

- (void)saveLogDataLocally:(NSDictionary*)logData {
    [logEntries addObject:logData];
    [logEntries writeToFile:self.logFilePath atomically:YES];
}

- (NSFileHandle *) getLogFileHandler:(NSString*)filePath
{
    //setting the file handle to the EOF to write
    NSFileHandle *fileHandler=[NSFileHandle fileHandleForWritingAtPath:filePath];
    [fileHandler truncateFileAtOffset:[fileHandler seekToEndOfFile]];
    return fileHandler;
}

-(BOOL)canLogMesage {
    return [[[[NSBundle mainBundle] infoDictionary] valueForKey:kLogAlwaysWhenActive] boolValue];
}

@end