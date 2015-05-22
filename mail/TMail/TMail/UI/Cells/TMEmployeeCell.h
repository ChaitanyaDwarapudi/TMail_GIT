//
//  EmployeeCell.h
//  TMail
//
//  Created by Ranjith on 5/12/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMSecondaryButton.h"

@interface TMEmployeeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *employeeDetail;
@property (weak, nonatomic) IBOutlet TMSecondaryButton *addButton;

- (void)employeeInputs:(NSDictionary*)employeeDetail;

@end
