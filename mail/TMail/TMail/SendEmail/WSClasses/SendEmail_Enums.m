#import "SendEmail_Enums.h"

@implementation  SendEmail_Enums
+(SoapProtocolVersion)StringToSoapProtocolVersion:(NSString*)str{
    if( NSOrderedSame == [str compare:@"Default" options:NSCaseInsensitiveSearch])
        return kSoapProtocolVersionDefault;
    if( NSOrderedSame == [str compare:@"Soap11" options:NSCaseInsensitiveSearch])
        return kSoapProtocolVersionSoap11;
    if( NSOrderedSame == [str compare:@"Soap12" options:NSCaseInsensitiveSearch])
        return kSoapProtocolVersionSoap12;
    return -1;
}
+(NSString*)SoapProtocolVersionToString:(SoapProtocolVersion)soapVersion;{
    switch (soapVersion){
        case kSoapProtocolVersionDefault:
            return @"Default";
        case kSoapProtocolVersionSoap11:
            return @"Soap11";
        case kSoapProtocolVersionSoap12:
            return @"Soap12";
        default:
            return @"";
    }
}
+(EmailSenderInfoTypePreferenceType)StringToEmailSenderInfoTypePreferenceType:(NSString*)str{
    if( NSOrderedSame == [str compare:@"EMAIL_PREF" options:NSCaseInsensitiveSearch])
        return kEmailSenderInfoTypePreferenceTypeEMAIL_PREF;
    if( NSOrderedSame == [str compare:@"DATA_NOTIFY_EMAIL" options:NSCaseInsensitiveSearch])
        return kEmailSenderInfoTypePreferenceTypeDATA_NOTIFY_EMAIL;
    return -1;
}
+(NSString*)EmailSenderInfoTypePreferenceTypeToString:(EmailSenderInfoTypePreferenceType)preferenceType;{
    switch (preferenceType){
        case kEmailSenderInfoTypePreferenceTypeEMAIL_PREF:
            return @"EMAIL_PREF";
        case kEmailSenderInfoTypePreferenceTypeDATA_NOTIFY_EMAIL:
            return @"DATA_NOTIFY_EMAIL";
        default:
            return @"";
    }
}
+(EmailContentInfoTypeDisplay)StringToEmailContentInfoTypeDisplay:(NSString*)str{
    if( NSOrderedSame == [str compare:@"body" options:NSCaseInsensitiveSearch])
        return kEmailContentInfoTypeDisplaybody;
    if( NSOrderedSame == [str compare:@"inline" options:NSCaseInsensitiveSearch])
        return kEmailContentInfoTypeDisplayinline;
    if( NSOrderedSame == [str compare:@"attachment" options:NSCaseInsensitiveSearch])
        return kEmailContentInfoTypeDisplayattachment;
    return -1;
}
+(NSString*)EmailContentInfoTypeDisplayToString:(EmailContentInfoTypeDisplay)display;{
    switch (display){
        case kEmailContentInfoTypeDisplaybody:
            return @"body";
        case kEmailContentInfoTypeDisplayinline:
            return @"inline";
        case kEmailContentInfoTypeDisplayattachment:
            return @"attachment";
        default:
            return @"";
    }
}
@end
