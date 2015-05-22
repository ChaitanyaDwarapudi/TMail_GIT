//
//  TMPrimaryButton.m
//  TMail
//
//  Created by Ranjith on 5/22/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
//

#import "TMPrimaryButton.h"
#import "TMAdditions.h"



@implementation TMPrimaryButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setCustomFeatures];
    }
    return self;
}

- (void)setCustomFeatures
{
    self.layer.cornerRadius = kPrimaryButtonCornerRadius;
    [self setBackgroundColor:[UIColor colorFromHexString:kPrimaryButtonDefaultStateBackGroundColor]]; //setup in IB
    [self setTitleColor:[UIColor colorFromHexString:kPrimaryButtonTitleColor] forState:UIControlStateNormal];
    self.tag = -1;
    [self addTarget:self action:@selector(downnStateButtonAction:) forControlEvents:UIControlEventTouchDown]; //setup in IB
    [self addTarget:self action:@selector(dragStateButtonAction:) forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(dragStateButtonAction:) forControlEvents:UIControlEventTouchDragInside];
}

- (void)downnStateButtonAction:(id)sender
{
    UIButton *selected_Button = (UIButton *)sender;
    [selected_Button setBackgroundColor:[UIColor colorFromHexString:kPrimaryButtonDownStateBackgroundColor]]; //setup in IB
    [selected_Button setTitleColor:[UIColor colorFromHexString:kPrimaryButtonDownStateTitleColor] forState:UIControlStateNormal];
    }

- (void)dragStateButtonAction:(id)sender
{
    UIButton *selected_Button = (UIButton *)sender;
    [selected_Button setBackgroundColor:[UIColor colorFromHexString:kPrimaryButtonDefaultStateBackGroundColor]];
    [selected_Button setTitleColor:[UIColor colorFromHexString:kPrimaryButtonTitleColor] forState:UIControlStateNormal];
}



@end
