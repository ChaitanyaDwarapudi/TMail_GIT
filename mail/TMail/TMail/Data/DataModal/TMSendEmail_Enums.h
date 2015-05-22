#import <Foundation/Foundation.h>


#ifndef _SoapProtocolVersion_
#define _SoapProtocolVersion_
typedef enum {
    	kSoapProtocolVersionDefault = 0,
    	kSoapProtocolVersionSoap11 = 1,
    	kSoapProtocolVersionSoap12 = 2,
} SoapProtocolVersion;
#endif

#ifndef _EmailSenderInfoTypePreferenceType_
#define _EmailSenderInfoTypePreferenceType_
typedef enum {
    	kEmailSenderInfoTypePreferenceTypeEMAIL_PREF = 0,
    	kEmailSenderInfoTypePreferenceTypeDATA_NOTIFY_EMAIL = 1,
} EmailSenderInfoTypePreferenceType;
#endif

#ifndef _EmailContentInfoTypeDisplay_
#define _EmailContentInfoTypeDisplay_
typedef enum {
    	kEmailContentInfoTypeDisplaybody = 0,
    	kEmailContentInfoTypeDisplayinline = 1,
    	kEmailContentInfoTypeDisplayattachment = 2,
} EmailContentInfoTypeDisplay;
#endif
@interface TMSendEmail_Enums : NSObject
{
}
+(NSString*)SoapProtocolVersionToString:(SoapProtocolVersion)soapVersion;
+(SoapProtocolVersion)StringToSoapProtocolVersion:(NSString*)str;
+(NSString*)EmailSenderInfoTypePreferenceTypeToString:(EmailSenderInfoTypePreferenceType)preferenceType;
+(EmailSenderInfoTypePreferenceType)StringToEmailSenderInfoTypePreferenceType:(NSString*)str;
+(NSString*)EmailContentInfoTypeDisplayToString:(EmailContentInfoTypeDisplay)display;
+(EmailContentInfoTypeDisplay)StringToEmailContentInfoTypeDisplay:(NSString*)str;
@end
