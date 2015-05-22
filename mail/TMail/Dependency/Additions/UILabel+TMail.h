//
//  UILabel+TMail.h
//  TMail
//
//  Created by Ranjith on 5/11/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (TMail)

- (void)applyFontWithSize:(CGFloat)size;
- (void)applyTextColorFromHexString:(NSString *)hexString;
- (void)applyFontWithSize:(CGFloat)size textColorFromHexString:(NSString *)hexString;
- (CGFloat)calculateActualHeightWithMinimumHeight:(CGFloat)minimumHeight;

@end
