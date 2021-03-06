//
//  UIColor+TMail.m
//  TMail
//
//  Created by Ranjith on 5/11/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import "UIColor+TMail.h"

@implementation UIColor (TMail)
+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
@end
