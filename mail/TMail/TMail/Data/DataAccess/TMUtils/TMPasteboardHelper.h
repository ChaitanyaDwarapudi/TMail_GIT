//
//  PasteboardHelper.h
//  TMail
//
//  Created by Ranjith on 5/14/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TMPasteboardHelper : NSObject


+ (id)sharedManager;
- (void)testPasteBoardSetUp;
- (NSString*)fetchingPDFDocumentFromPasteBoard;
@end