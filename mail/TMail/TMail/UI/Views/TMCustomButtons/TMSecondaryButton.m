//
//  TMSecondaryButton.m
//  TMail
//
//  Created by Ranjith on 5/22/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
//

#import "TMSecondaryButton.h"
#import "TMAdditions.h"



@implementation TMSecondaryButton

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
    [self setBackgroundColor:[UIColor colorFromHexString:kSecondaryButtonDefaultStateBackGroundColor]]; //setup in IB
    [self setTitleColor:[UIColor colorFromHexString:kSecondaryButtonTitleColor] forState:UIControlStateNormal];
    self.layer.borderColor = [UIColor colorFromHexString:kSecondaryButtonBorderColor].CGColor;
    self.layer.borderWidth = kSecondaryButtonBorderWidth;
    self.layer.cornerRadius = kSecondaryButtonCornerRadius;
    [self addTarget:self action:@selector(downnStateButtonAction:) forControlEvents:UIControlEventTouchDown]; //setup in IB
    [self addTarget:self action:@selector(dragStateButtonAction:) forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(dragStateButtonAction:) forControlEvents:UIControlEventTouchDragInside];
}

- (void)downnStateButtonAction:(id)sender
{
    UIButton *selected_Button = (UIButton *)sender;
    [selected_Button setBackgroundColor:[UIColor colorFromHexString:kSecondaryButtonDownStateBackgroundColor]]; //setup in IB
    [selected_Button setTitleColor:[UIColor colorFromHexString:kSecondaryButtonDownStateTitleColor] forState:UIControlStateNormal];
    selected_Button.layer.borderWidth = 1;
    selected_Button.layer.borderColor = [[UIColor colorFromHexString:kSecondaryButtonDownStateBorderColor]CGColor];
}

- (void)dragStateButtonAction:(id)sender
{
    UIButton *selected_Button = (UIButton *)sender;
    [selected_Button setTitleColor:[UIColor colorFromHexString:kSecondaryButtonTitleColor] forState:UIControlStateNormal];
    selected_Button.layer.borderColor = [UIColor colorFromHexString:kSecondaryButtonBorderColor].CGColor;
    selected_Button.layer.borderWidth = kSecondaryButtonBorderWidth;
}


@end
