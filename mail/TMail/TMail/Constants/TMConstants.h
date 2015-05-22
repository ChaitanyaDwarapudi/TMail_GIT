//
//  TMDTConstants.h
//  DiagnosticTool
//
//  Created by Ragunath on 02/04/15.
//  Copyright (c) 2015 T-Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

//TMContainerViewController Constants..
#define kSearchAddressSection 2
#define kCancelSendSection 5
#define kEmptyRow 0
#define kSearchAddressHeaderHeight 70
#define kSearchAddressFooterHeight 25;
#define kdefaultSectionHeight 50
#define kCancelSendSectionHeight 50



//TMApplication log constants..
#define kREST_URL_LOG_PROD @"https://reta.internal.t-mobile.com"
#define kREST_URL_LOG_DEV @"http://10.133.114.187:8003"

#define kKeyTapestry_Config_RESTURL @"Url"
#define kREST_EndPoint_Log @"rest/log"
#define kAPP_NAME @"Firmware Update Tool"
#define kDEVICE_ID @"007"
#define kLogManagerFileName @"ApplicationLog.txt"
#define kUsageTrackQueue  "com.tmonotepad.usagetracker"

#define kLogAlwaysWhenActive @"logAlwaysWhenActive"
#define kLogServerType @"inProduction"
#define kIsMessageSavedLocally @"logsSavedLocally"

#define kREST_AccessibleNotification @"logRestAccessibleNotification"

#define kTapestryTimestampKey @"tapestryTimestamp"
#define kDeviceNameKey @"deviceName"
#define kDeviceIdKey @"deviceId"
#define kUserIdKey @"userId"
#define kAppNameKey @"appName"
#define kBusinessFlowTagKey @"businessFlowTag"
#define kTapestryVersionKey @"tapestryVersion"
#define kMenuItemNameKey @"menuItemName"
#define kLogLevelKey @"logLevel"
#define kNoteKey @"note"

//////////////All Buttons Constants
//Primary Button Constants...
#define kPrimaryButtonDefaultStateBackGroundColor @"#e20074"
#define kPrimaryButtonTitleColor @"#ffffff"
#define kPrimaryButtonDownStateTitleColor @"#ffffff"
#define kPrimaryButtonDownStateBackgroundColor @"#BA0060"
#define kPrimaryButtonCornerRadius 22.0f

//Secondary Button Constants
#define kSecondaryButtonDefaultStateBackGroundColor @"#ffffff"
#define kSecondaryButtonTitleColor @"#e20074"
#define kSecondaryButtonDownStateTitleColor @"#BA0060"

#define kSecondaryButtonDownStateBackgroundColor @"#ffffff"
#define kSecondaryButtonCornerRadius 22.0f

#define kSecondaryButtonBorderColor @"#cecece"
#define kSecondaryButtonDownStateBorderColor @"#e20074"
#define kSecondaryButtonBorderWidth 1.0f


//////TMContainerViewController Constants

//Suggestion List Constants
#define kSuggestionListBackgroundColor @"#fafafa"
#define kEmployeeCellNibName @"TMEmployeeCell"
#define kEmployeeCellIdentifier @"employeeCellIdentifier"

//Body constants
#define kBodyTextColor @"#9B9B9B"
#define kBodyPlaceHolderText @"Enter Message"
#define kBodyBorderWidth 1.0f
#define kBodyBorderColor @"#6a6a6a"

///////File Names
#define kActiveDirectoryFileName @"ActiveDirectoryFile"
#define kActiveDirectoryFileType @"txt"
#define kSuggestionListDataFileName @"sample_data"
#define kSuggestionListDataFileType @"json"

#define kZero 0

/////////Search Header and Default Header Constants
#define kSearchHeaderBackGroundColor @"#ffffff"
#define kSearchTitleHeaderFrame CGRectMake(35, 25, 150, 18)
#define kSearchIndicatorArrowframe CGRectMake(703, 30, 18, 11)
#define kSearchIndicatorArrowImage @"caretDown_default.png"
#define kSearchIndicatorActiveArrowImage @"caretUp_click-active.png"
#define kSearchHeaderSeparatorFrame CGRectMake(25, 1, 718, 1)
#define kSearchFooterSeparatorFrame CGRectMake(25, 69, 718, 1)

#define kSectionSeparatorColor @"#6a6a6a"
#define kSectionTitleTextColor @"#6a6a6a"
#define kSectionTitleTextSize 15
#define kSectionDefaultTitleFrame CGRectMake(25, 25, 150, 22)

///////Alert Note Constants
#define kALertSuccessEmailNote @"Email Successfully Sent!!"
#define kALertOkNote @"Ok"
#define kAlertCancelNote @""
#define kAlertErrorEmailNote @"Failed to Send Email."
#define kAlertFromFieldValidationNote @"Please enter from email Id."
#define kAlertToFieldValidationNote @"Please enter receiver email id."
#define kAlertBodyFieldValidationNote @"Please enter message body."
#define kAlertSubjectFieldValidationNote1 @"This message has no subject. Are you sure you want to send it?"
#define kAlertSubjectFieldValidationNote2 @"Send Anyway"
#define kAlertDefaultNote @"Please Enter all required fields"

////TextField
#define kAllTextFieldBorderColor @"#6a6a6a"
#define kAllTextFieldBorderWidth 1.0f
/*
 
 //Text Field
 
 Default
 
 Label Color: #9B9B9B Label size: 16px Background: #fafafa Text Field Height: 45px
 
 Active Focused Field
 
 Label Color: #9B9B9B
 Label Size: 12px
 Active Text Field Content Color: #6a6a6a Active Text Field Content Size: 16px Border : 1px solid #6a6a6a
 Background: #fafafa
 Text Field Height: 45px
 
 Drop down text field
 
 Border : 1px solid #6a6a6a
 Background: #fafafa
 Drop Down Top Border : 1px solid #6a6a6a List Item Size: 16px
 Hover/Clicked List item: Italic #e20074
 
 
 //Buttons
 
 Default Magenta..
 
 Text Color: #ffffff Height: 45px
 Width: 180px
 Corner Radius: 22px Background: #e20074
 
 Hover/Click
 
 Text Color: #ffffff Height: 45px
 Width: 180px
 Corner Radius: 22px Background: #BA0060
 
 Disabled
 
 Text Color: #ffffff Height: 45px
 Width: 180px
 Corner Radius: 22px Background: #CECECE
 
 
 Default White..
 
 Text Color: #e20074 Height: 45px
 Width: 180px
 Corner Radius: 22px Background: #ffffff Border: 1px solid #cecece
 
 Hover/Click
 
 Text Color: #BA0060 Height: 45px
 Width: 180px
 Corner Radius: 22px Background: #ffffff
 Border: 1px solid #e20074
 
 Disabled
 
 Text Color: #cecece Height: 45px
 Width: 180px
 Corner Radius: 22px Background: #ffffff
 
 Inline Error Single Field
 
 Label Color: #FF0000
 Label Size: 12px
 Active Text Field Content Size: 16px Active Text Field Content Color: #FF0000 Error Message Size: 16px
 Error Message Color: #FF0000
 Border : 1px solid #FF0000
 Background: #fafafa
 Text Field Height: 45px
 
 */

extern NSString *const kTMFontName;
extern NSString *const kTMFontNameNavBarTitle;

//SENT EMAIL REQUEST BASE URL
extern NSString *const kSendEmailURL;

//PASTEBOARD
extern NSString *const kPDFPasteBoadKey;