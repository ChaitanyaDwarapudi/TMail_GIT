//
//  TMContentViewController.h
//  TMail
//
//  Created by Ranjith on 5/11/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGTextField.h"
#import "TMSendEmailServiceCall.h"

@interface TMContentViewController : UITableViewController<MPGTextFieldDelegate,UITextFieldDelegate,SendEmailDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet MPGTextField *to_TextFeild;
@property (weak, nonatomic) IBOutlet UITextField *email_TextField;
@property (weak, nonatomic) IBOutlet UITextField *from_TextFeld;
@property (weak, nonatomic) IBOutlet UITextField *subject_TextField;
@property (weak, nonatomic) IBOutlet UILabel *attachedPDFFileLabel;
@property (weak, nonatomic) IBOutlet UITextView *body_Label;
@property (strong, nonatomic)     NSDictionary *recieverInfo;
@property (strong, nonatomic)     NSMutableDictionary *selectedRecieverInfo;

@end
