//
//  NSString+TMail.m
//  TMail
//
//  Created by Ranjith on 5/11/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import "NSString+TMail.h"

@implementation NSString (TMail)

- (CGFloat)calculateHeightWithFont:(UIFont *)aFont maximumSize:(CGSize)maximumSize
{
    CGSize sizeOfText = [self boundingRectWithSize: maximumSize
                                           options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes: [NSDictionary dictionaryWithObject:aFont
                                                                                forKey:NSFontAttributeName]
                                           context: nil].size;
    
    return ceilf(sizeOfText.height);
}

- (NSString *)base64EncodedString
{
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    return base64String;
}


@end
