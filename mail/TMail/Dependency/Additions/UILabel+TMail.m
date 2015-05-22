//
//  UILabel+TMail.m
//  TMail
//
//  Created by Ranjith on 5/11/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import "UILabel+TMail.h"
#import "TMAdditions.h"


@implementation UILabel (TMail)

- (void)applyFontWithSize:(CGFloat)size
{
    self.font = [UIFont fontWithName:kTMFontName size:size];
}

- (void)applyTextColorFromHexString:(NSString *)hexString
{
    self.textColor = [UIColor colorFromHexString:hexString];
}

- (void)applyFontWithSize:(CGFloat)size textColorFromHexString:(NSString *)hexString
{
    self.font = [UIFont fontWithName:kTMFontName size:size];
    self.textColor = [UIColor colorFromHexString:hexString];
}

- (CGFloat)calculateActualHeightWithMinimumHeight:(CGFloat)minimumHeight
{
    CGFloat height = [self.text calculateHeightWithFont:self.font
                                            maximumSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    height = MAX(height, minimumHeight);
    
    //    self.frame = CGRectMake(self.frame.origin.x,
    //                             self.frame.origin.y,
    //                             self.frame.size.width,
    //                             height);
    return height;
}



@end
