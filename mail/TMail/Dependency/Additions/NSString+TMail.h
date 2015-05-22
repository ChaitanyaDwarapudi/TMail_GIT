//
//  NSString+TMail.h
//  TMail
//
//  Created by Ranjith on 5/11/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (TMail)

- (CGFloat)calculateHeightWithFont:(UIFont *)aFont maximumSize:(CGSize)maximumSize;
- (NSString *)base64EncodedString;

@end
