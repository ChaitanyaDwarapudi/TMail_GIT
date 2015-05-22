//
//  EmployeeCell.m
//  TMail
//
//  Created by Ranjith on 5/12/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
//

#import "TMEmployeeCell.h"
#import "TMAdditions.h"

@implementation TMEmployeeCell

- (void)awakeFromNib {
    // Initialization code
    self.addButton.layer.cornerRadius = 24.0;
    [self.addButton setBackgroundColor:[UIColor colorFromHexString:@"#ffffff"]];
    [self.addButton setTitleColor:[UIColor colorFromHexString:@"#e20074"] forState:UIControlStateNormal];
    self.addButton.layer.borderColor = [UIColor colorFromHexString:@"#cecece"].CGColor;
    self.addButton.layer.borderWidth = 1.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)employeeInputs:(NSDictionary*)employeeDetail
{
    [self.employeeDetail setText:[NSString stringWithFormat:@"%@, %@  %@",[employeeDetail objectForKey:@"first_name"],[employeeDetail objectForKey:@"last_name"],[employeeDetail objectForKey:@"desgination"]]];
    
}

@end
