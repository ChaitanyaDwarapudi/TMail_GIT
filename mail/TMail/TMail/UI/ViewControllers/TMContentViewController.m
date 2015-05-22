//
//  TMContentViewController.m
//  TMail
//
//  Created by Ranjith on 5/11/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
//

#import "TMContentViewController.h"
#import "TMAdditions.h"
#import "TMEmployeeCell.h"
#import "TMWebserviceHandler.h"
#import "TMSendEmailServiceCall.h"
#import "TMConstants.h"
#import "TMPasteboardHelper.h"
#import "TMParseSendEmailResponse.h"
#import "MBProgressHUD.h"
#import "TMPrimaryButton.h"
#import "TMSecondaryButton.h"

@interface TMContentViewController ()<TMWebserviceHanderDelegate,MBProgressHUDDelegate>
{
    TMPasteboardHelper *pasteboardHelper;
    BOOL showSearchAdrress;
    NSMutableArray *data;
    NSArray *sectionTitlesArray;
    NSMutableArray *directoryArray;
    TMWebserviceHandler *webServiceActiveDirectory;
 
    //Action Buttons
    __weak IBOutlet TMSecondaryButton *cancel_Button;
    __weak IBOutlet TMPrimaryButton *send_Button;
    
    //Search Address Book Arrow
    UIImageView *arrowImageView;
    __weak IBOutlet TMSecondaryButton *search_Button;
    
    //MBProgressHUD
    MBProgressHUD  *HUD;
    
}

@property(nonatomic,retain) TMSendEmailServiceCall *sendEmailServiceCall;

- (IBAction)cancel_Tapped:(id)sender;
- (IBAction)send_Tapped:(id)sender;
- (IBAction)directorySearchTapped:(id)sender;
@end

@implementation TMContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetUp];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialSetUp
{
    directoryArray = [NSMutableArray new];
    //create instance for the receiver info selected dictionary
    _selectedRecieverInfo = [NSMutableDictionary dictionary];
    sectionTitlesArray = [NSArray arrayWithObjects:@"From",@"To",@"Search Address Book",@"Subject",@"Body",@"", nil];//@""//Last section "Cancel and Send Button"
    [self generateData];
    [self.to_TextFeild setDelegate:self];
    [self.to_TextFeild setTableBackgroundColor:[UIColor colorFromHexString:kSuggestionListBackgroundColor]];
    [[self tableView] registerNib:[UINib nibWithNibName:kEmployeeCellNibName bundle:nil] forCellReuseIdentifier:kEmployeeCellIdentifier];
    webServiceActiveDirectory = [[TMWebserviceHandler alloc]init];
    webServiceActiveDirectory.delegate = self;
    
    //Static EmailID Text
    self.from_TextFeld.text = @"Chaitanya D";
    self.subject_TextField.text = @"Observation Form";
    
    CATransform3D textFieldPadding = CATransform3DMakeTranslation(15.0f, 0.0f, 0.0f);
    self.to_TextFeild.layer.sublayerTransform = textFieldPadding;
    self.from_TextFeld.layer.sublayerTransform = textFieldPadding;
    self.email_TextField.layer.sublayerTransform = textFieldPadding;
    self.subject_TextField.layer.sublayerTransform = textFieldPadding;
    self.body_Label.layer.sublayerTransform = textFieldPadding;
    
    pasteboardHelper = [TMPasteboardHelper sharedManager];
    [pasteboardHelper testPasteBoardSetUp];
    
    self.body_Label.text = kBodyPlaceHolderText;
    self.body_Label.textColor = [UIColor colorFromHexString:kBodyTextColor]; //setup in IB
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.view addGestureRecognizer:singleTap];

}

#pragma mark - Tap Gesture Handler.

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    NSArray *windowSubViews = [[[[UIApplication sharedApplication]windows]objectAtIndex:0]subviews];
    
    if ([windowSubViews count] > 0) {
        for (id suggestionTable in windowSubViews) {
            if ([suggestionTable isKindOfClass:[UITableView class]]) {
                UITableView *sugTable = (UITableView*)suggestionTable;
                if (sugTable.tag == 5) {
                    [sugTable removeFromSuperview];
                }
            }
        }
    }
    [self.to_TextFeild resignFirstResponder];
    [self.email_TextField resignFirstResponder];
    [self.subject_TextField resignFirstResponder];
    [self.body_Label resignFirstResponder];
}

- (void)generateData
{
    _recieverInfo = [NSDictionary new];
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              NSError* err = nil;
        data = [[NSMutableArray alloc] init];
        NSString* dataPath = [[NSBundle mainBundle] pathForResource:kSuggestionListDataFileName ofType:kSuggestionListDataFileType];
        NSArray* contents = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
        dispatch_async( dispatch_get_main_queue(), ^{
            [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [data addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[obj objectForKey:@"first_name"] stringByAppendingString:[NSString stringWithFormat:@" %@", [obj objectForKey:@"last_name"]]], @"DisplayText", [obj objectForKey:@"email"], @"DisplaySubText",obj,@"CustomObject", nil]];
            }];
        });
    });
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == kSearchAddressSection)
        return [directoryArray count];
    return [super tableView:tableView numberOfRowsInSection:section];
}


-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kSearchAddressSection)
        return kZero;
    else
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kSearchAddressSection)
    {
        UITableViewCell *searchCell = nil;
        TMEmployeeCell *employeeAddCell = nil;
        if (indexPath.row == kZero) {
            searchCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
            return searchCell;
        }
        else
        {
            static NSString *employeeCellIdentifier =kEmployeeCellIdentifier;
            employeeAddCell = [tableView dequeueReusableCellWithIdentifier:employeeCellIdentifier];
            if (!employeeAddCell)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:kEmployeeCellNibName owner:self options:nil];
                employeeAddCell = [topLevelObjects objectAtIndex:0];
            }
            [employeeAddCell employeeInputs:[directoryArray objectAtIndex:indexPath.row]];
          // [employeeAddCell.addButton setTag:indexPath.row];
            [employeeAddCell.addButton addTarget:self action:@selector(addEmailID:) forControlEvents:UIControlEventTouchUpInside];
            return employeeAddCell;
        }
    }
    else
    {
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell;
    }
    // Configure the cell...
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeader = nil;
    if (section == kSearchAddressSection)
    {
        sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kSearchAddressHeaderHeight)];
        [sectionHeader setBackgroundColor:[UIColor colorFromHexString:kSearchHeaderBackGroundColor]];
        
        UILabel *titleHeaderLabel = [[UILabel alloc]initWithFrame:kSearchTitleHeaderFrame];
        [titleHeaderLabel applyFontWithSize:kSectionTitleTextSize textColorFromHexString:kSectionTitleTextColor];
        [titleHeaderLabel setText:[sectionTitlesArray objectAtIndex:section]];
        [sectionHeader addSubview:titleHeaderLabel];

        arrowImageView = [[UIImageView alloc]initWithFrame:kSearchIndicatorArrowframe];
        [arrowImageView setImage:[UIImage imageNamed:kSearchIndicatorArrowImage]];
        [sectionHeader addSubview:arrowImageView];
        
        UIView *sectionHeaderSeparotor = [[UIView alloc]initWithFrame:kSearchHeaderSeparatorFrame];
        [sectionHeaderSeparotor setBackgroundColor:[UIColor colorFromHexString:kSectionSeparatorColor]];
        [sectionHeader addSubview:sectionHeaderSeparotor];
        UIView *sectionFooterSeparotor = [[UIView alloc]initWithFrame:kSearchFooterSeparatorFrame];
        [sectionFooterSeparotor setBackgroundColor:[UIColor colorFromHexString:kSectionSeparatorColor]];
        [sectionHeader addSubview:sectionFooterSeparotor];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expendEmployeeSearch:)];
        tapRecognizer.numberOfTapsRequired = 1;
        [sectionHeader addGestureRecognizer:tapRecognizer];
    }
    else
    {
        sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kdefaultSectionHeight)];
        [sectionHeader setBackgroundColor:[UIColor colorFromHexString:kSearchHeaderBackGroundColor]];
        UILabel *titleHeaderLabel = [[UILabel alloc]initWithFrame:kSectionDefaultTitleFrame];
        [titleHeaderLabel applyFontWithSize:kSectionTitleTextSize textColorFromHexString:kSectionTitleTextColor];
        [titleHeaderLabel setText:[sectionTitlesArray objectAtIndex:section]];
        [sectionHeader addSubview:titleHeaderLabel];
    }
    return sectionHeader;
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == kSearchAddressSection) {
        UIView *searchFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 10)];
        UIView *footerViewSeparator = [[UIView alloc]initWithFrame:CGRectMake(25, 8, 718, 1)];
        [footerViewSeparator setBackgroundColor:[UIColor colorFromHexString:@"#6a6a6a"]];
        [searchFooterView addSubview:footerViewSeparator];
        return searchFooterView;
    }
    return nil;
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kSearchAddressSection)
        return (indexPath.row == 0) ? [super tableView:tableView heightForRowAtIndexPath:indexPath] : 74.0;//74.0 of Employee Add Cell Height
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == kSearchAddressSection)
        return kSearchAddressHeaderHeight;
    else if (section == kCancelSendSection)
        return kCancelSendSectionHeight;
    return kdefaultSectionHeight;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == kSearchAddressSection)
        return kSearchAddressFooterHeight;
    return kEmptyRow;
}
*/

#pragma mark - UITableView Scroll Delegate..

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *windowSubViews = [[[[UIApplication sharedApplication]windows]objectAtIndex:0]subviews];
    
    if ([windowSubViews count] > 0) {
        for (id suggestionTable in windowSubViews) {
            if ([suggestionTable isKindOfClass:[UITableView class]]) {
                UITableView *sugTable = (UITableView*)suggestionTable;
                if (sugTable.tag == 5) {
                    [sugTable removeFromSuperview];
                }
            }
        }
        
    }
//    [self.to_TextFeild resignFirstResponder];
//    [self.email_TextField resignFirstResponder];
//    [self.subject_TextField resignFirstResponder];
//    [self.body_Label resignFirstResponder];
}

#pragma mark- IB and Normal Button Actions..

- (void)expendEmployeeSearch:(id)sender
{
    if ([arrowImageView.image isEqual:[UIImage imageNamed:kSearchIndicatorArrowImage]])
    {
        [arrowImageView setImage:[UIImage imageNamed:kSearchIndicatorActiveArrowImage]];
        [directoryArray addObject:@"AddDefaultCell"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
    else
    {
        [arrowImageView setImage:[UIImage imageNamed:kSearchIndicatorArrowImage]];
        NSMutableArray *indexpaths = [NSMutableArray new];
        for (int index=0 ; index<[directoryArray count]; index++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:kSearchAddressSection];
            [indexpaths addObject:indexPath];
        }
        [directoryArray removeAllObjects];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];

    }
}

- (IBAction)directorySearchTapped:(id)sender
{
    [search_Button setBackgroundColor:[UIColor colorFromHexString:kSecondaryButtonDefaultStateBackGroundColor]]; //setup in IB
    search_Button.layer.borderColor = [UIColor colorFromHexString:kSecondaryButtonBorderColor].CGColor;
    search_Button.layer.borderWidth = kSecondaryButtonBorderWidth;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:kActiveDirectoryFileName ofType:kActiveDirectoryFileType];
    [webServiceActiveDirectory activeDirectoryWebserviceURL:filePath];
}

- (void)addEmailID:(id)sender
{
    UIButton *addBtn = (UIButton*)sender;
    UITableViewCell *clickedCell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *clickedButtonIndexPath = [self.tableView indexPathForCell:clickedCell];
    
    [addBtn setBackgroundColor:[UIColor colorFromHexString:kSecondaryButtonDefaultStateBackGroundColor]]; //setup in IB
    addBtn.layer.borderColor = [UIColor colorFromHexString:kSecondaryButtonBorderColor].CGColor;
    addBtn.layer.borderWidth = kSecondaryButtonBorderWidth;
    
    NSDictionary *employeeDetail =  [directoryArray objectAtIndex:clickedButtonIndexPath.row];
    NSString *receiverName = [NSString stringWithFormat:@"%@ %@",[employeeDetail objectForKey:@"first_name"],[employeeDetail objectForKey:@"last_name"]];
    NSString *receiverEmailID = [NSString stringWithFormat:@"%@",[employeeDetail objectForKey:@"email"]];
    
    TMSendEmailRequestType *emailRequest = [TMSendEmailRequestType sharedManager];
    NSMutableDictionary *receiverList = [emailRequest receiverInfo];
    [receiverList setObject:receiverEmailID forKey:receiverName];
    [_selectedRecieverInfo setObject:receiverName forKey:receiverEmailID];
    NSMutableString *newToEmailList = [[NSMutableString alloc]init];
    NSString *currentToEmailField = [self.to_TextFeild text];
    NSArray *listItems = [currentToEmailField componentsSeparatedByString:@";"];
    if(listItems.count>0)
    {
        for (int toEmail = 0; toEmail < listItems.count-1 ; toEmail++){
            [newToEmailList appendFormat:@"%@",[listItems[toEmail] stringByTrimmingCharactersInSet:
                                                [NSCharacterSet whitespaceCharacterSet]]];
            [newToEmailList appendString:@"; "];
        }
    }

    [newToEmailList appendFormat:@"%@; ",receiverName] ;
    
    [self.to_TextFeild setText:newToEmailList];
    [directoryArray removeObjectAtIndex:addBtn.tag];//Remove from search Directory Array...
    NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:clickedButtonIndexPath.row inSection:kSearchAddressSection];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[deleteIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
}

- (IBAction)cancel_Tapped:(id)sender
{
    [cancel_Button setBackgroundColor:[UIColor colorFromHexString:kSecondaryButtonDefaultStateBackGroundColor]];
    cancel_Button.layer.borderColor = [UIColor colorFromHexString:kSecondaryButtonBorderColor].CGColor;
    cancel_Button.layer.borderWidth = kSecondaryButtonBorderWidth;
}

- (IBAction)send_Tapped:(id)sender
{
    [send_Button setBackgroundColor:[UIColor colorFromHexString:kPrimaryButtonDefaultStateBackGroundColor]];
    
    TMSendEmailRequestType *emailRequest = [TMSendEmailRequestType sharedManager];
    [emailRequest setFromEmailName:self.from_TextFeld.text];//PasteBoard //contentViewController.from_TextFeld.text
    [emailRequest setFromEmailId:@"dchaitanya@prokarma.com"];//Pasteboard //contentViewController.from_TextFeld.text
    [emailRequest setMailSubject:self.subject_TextField.text];
    if (!([self.body_Label.textColor isEqual:[UIColor colorFromHexString:kBodyTextColor]]))
    {
    [emailRequest setMailContent:self.body_Label.text];
    }
    [emailRequest setBody:@"body"];
    [emailRequest setBodyType:@"text/plain"];
    [emailRequest setAttachmentName:@"obserationGuide.pdf"];//PasteBoad
    [emailRequest setAttachmentContent:[pasteboardHelper fetchingPDFDocumentFromPasteBoard]];//PasteBoard
    [emailRequest setAttachmentType:@"application/pdf"];
    
    NSString *toEmailFieldText = self.to_TextFeild.text;
    toEmailFieldText = [toEmailFieldText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(nil != toEmailFieldText && toEmailFieldText.length > 0)
    {
    NSMutableArray *recieverDetail = [self callReceiverInfo:toEmailFieldText];
    NSString *receiverName = [NSString stringWithFormat:@"%@",[recieverDetail objectAtIndex:0]];
    [emailRequest setReceiverEmailName:receiverName];
    NSString *receiverEmailID = [NSString stringWithFormat:@"%@",[recieverDetail objectAtIndex:1]];
    [emailRequest setReceiverEmailId:receiverEmailID];
    }
    else
    {
        [emailRequest setReceiverEmailName:nil];
        [emailRequest setReceiverEmailId:nil];
    }
    if([self isAllFieldValid:emailRequest])
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.labelText = @"Sending...";
        [HUD show:YES];
        self.sendEmailServiceCall =[[TMSendEmailServiceCall alloc]initWithUrl:kSendEmailURL AndDelegate:self];
        [self.sendEmailServiceCall sendEmail:emailRequest];
        self.view.userInteractionEnabled = false;
    }
    else
    {
        [self showAlertWithMessage:kAlertDefaultNote defaultButtonTitle:kALertOkNote];
    }
}

//TODO: Revisit change the NSArray to NSDictionary for mulitple email id's

/*
 // Transfer an existing job to Mary
 [jobs setObject:@"Mary" forKey:@"Audi TT"];
 // Finish a job
 [jobs removeObjectForKey:@"Audi A7"];
 // Add a new job
 jobs[@"Audi R8 GT"] = @"Jack";
 */

- (NSMutableArray *)callReceiverInfo:(NSString *)receiverInfo
{
    NSMutableArray *receiverNameAndId = [[NSMutableArray alloc]init];
    receiverInfo = [receiverInfo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *listItems = [receiverInfo componentsSeparatedByString:@";"];
    NSString *newToEmailField = nil;
    
    if(receiverInfo.length > 0 && listItems.count> 0)
    {
        newToEmailField = [listItems[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    if(nil!= newToEmailField)
    {
        [receiverNameAndId addObject:[NSString stringWithFormat:@"%@",newToEmailField]];
        TMSendEmailRequestType *emailRequest = [TMSendEmailRequestType sharedManager];
        NSMutableDictionary *receiverList = [emailRequest receiverInfo];
        [receiverNameAndId addObject:[NSString stringWithFormat:@"%@",[receiverList objectForKey:[NSString stringWithFormat:@"%@",newToEmailField]]]];
    }
    
    return receiverNameAndId;
}

#pragma mark Response callback for send email web service


- (void)sendEmailSuccess:(id)dataString InMethod:(NSString *)method{
    NSLog(@"Service %@ Done!", method);
    
    NSData *dataXML = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:dataXML];
    // create and init our delegate
    TMParseSendEmailResponse *parser = [[TMParseSendEmailResponse alloc]init];
    
    [nsXmlParser setDelegate:parser]; // set delegate
    BOOL success = [nsXmlParser parse];
    [HUD hide:YES];
    self.view.userInteractionEnabled = true;
    if (success)
    {
        NSLog(@"Send Email Service Status : %@",parser.sendEmailResponseStatus);
        NSLog(@"Send Email Service Message : %@",parser.sendEmailResponseMessage);
        if ([parser.sendEmailResponseStatus isEqualToString:@"S"] && [parser.sendEmailResponseMessage isEqualToString:@"Success"])
            [self showAlertWithMessage:kALertSuccessEmailNote defaultButtonTitle:kALertOkNote];
        //Send Email success Alert dialog
    }
    else
    {
        NSLog(@"Error parsing document!");
        [self showAlertWithMessage:kAlertErrorEmailNote defaultButtonTitle:kALertOkNote];
    }
}

- (void)sendEmailError:(NSException *)ex InMethod:(NSString *)method
{
    NSLog(@"Exception in Service %@", method);
    [HUD hide:YES];
    self.view.userInteractionEnabled = true;
    //Send Email Failed Alert dialog.
    [self showAlertWithMessage:kALertSuccessEmailNote defaultButtonTitle:kALertOkNote];
}

#pragma mark - TMWebservice Handler Delegates.

- (void)successWebserviceResponse:(id)successResponse
{
    if ([successResponse isKindOfClass:[NSArray class]])
    {
        if([directoryArray count] > 1)
        {
            NSMutableArray *deleteIndexPathArray = [NSMutableArray array];
            for (NSInteger row = 1; row < [directoryArray count]; row++)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row  inSection:kSearchAddressSection];
                [deleteIndexPathArray addObject:indexPath];
            }
            
            [directoryArray removeObjectsInRange:NSMakeRange(1, ([directoryArray count]-1))];
            
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:deleteIndexPathArray withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
        
        [directoryArray addObjectsFromArray:[successResponse mutableCopy]];
        NSMutableArray *indexPathArray = [NSMutableArray array];
        for (NSInteger row = 1; row < [directoryArray count]; row++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row  inSection:kSearchAddressSection];
            [indexPathArray addObject:indexPath];
        }
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

- (void)failureWebserviceResponse:(id)failureResponse
{
    
}


#pragma mark - Empty All.

- (void)emptyAll
{
    self.to_TextFeild.text = nil;
    self.email_TextField.text = nil;
    self.body_Label.text = kBodyPlaceHolderText;
    self.body_Label.textColor = [UIColor colorFromHexString:kBodyTextColor];
}


#pragma mark - Form Validation..

- (BOOL)isAllFieldValid:(TMSendEmailRequestType *)sendEmailFields
{
    bool isAllFieldValid = false;
    
    if(nil== sendEmailFields.fromEmailId || nil == sendEmailFields.fromEmailName)
        [self showAlertWithMessage:kAlertFromFieldValidationNote defaultButtonTitle:kALertOkNote];
    else if(nil== sendEmailFields.receiverEmailId || nil == sendEmailFields.receiverEmailName)
        [self showAlertWithMessage:kAlertToFieldValidationNote defaultButtonTitle:kALertOkNote];
    else if ( nil == sendEmailFields.mailContent ||!sendEmailFields.mailContent.length>0 || [self.body_Label.textColor isEqual:[UIColor colorFromHexString:kBodyTextColor]])
        [self showAlertWithMessage:kAlertBodyFieldValidationNote defaultButtonTitle:kALertOkNote];
    else if((nil== sendEmailFields.mailSubject || !sendEmailFields.mailSubject.length>0))
        [self showAlertWithMessage:kAlertSubjectFieldValidationNote1 cancelTitle:kAlertCancelNote sendAnyway:kAlertSubjectFieldValidationNote2 sendEmailRequestField:sendEmailFields];
    else
        isAllFieldValid = true;
    
    return isAllFieldValid;
}

#pragma mark - Alerts...

-(void)showAlertWithMessage:(NSString *)message defaultButtonTitle:(NSString *)defaultButton
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:defaultButton style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          //    if ([message isEqualToString: @"Email Successfully Sent!!"])
                                                                   //[self emptyAll];

                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)showAlertWithMessage:(NSString *)message cancelTitle:(NSString *)cancel sendAnyway:(NSString *)send sendEmailRequestField:(TMSendEmailRequestType *)request{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* positiveAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               NSLog(@"Send Email Cancel clicked");
                                                            //   [self emptyAll];

                                                               
                                                           }];
    UIAlertAction* negativeAction = [UIAlertAction actionWithTitle:send style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               NSLog(@"Without Subject or Contend but send anyway clicked");
                                                               self.sendEmailServiceCall =[[TMSendEmailServiceCall alloc]initWithUrl:kSendEmailURL AndDelegate:self];
                                                               [self.sendEmailServiceCall sendEmail:request];
                                                               //Progress indicator shown for send email service call
                                                               [HUD show:YES];
                                                               self.view.userInteractionEnabled = false;
                                                           }];
    
    [alert addAction:positiveAction];
    [alert addAction:negativeAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark MPGTextField Delegate Methods

- (NSArray *)dataForPopoverInTextField:(MPGTextField *)textField
{
    if (textField == self.to_TextFeild)
        return  data;
    return data;
}


- (BOOL)textFieldShouldSelect:(MPGTextField *)textField
{
    return YES;
}

- (void)textField:(MPGTextField *)textField didEndEditingWithSelection:(NSDictionary *)result
{
    _recieverInfo = [result copy];
}


#pragma mark - Textfield Delegate



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderWidth = kAllTextFieldBorderWidth;
    textField.layer.borderColor = [UIColor colorFromHexString:kAllTextFieldBorderColor].CGColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderWidth = 0;
    textField.layer.borderColor = [UIColor clearColor].CGColor;
}

#pragma mark - TextView Delegate


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.body_Label) {
        textView.layer.borderWidth = kBodyBorderWidth;
        textView.layer.borderColor = [UIColor colorFromHexString:kBodyBorderColor].CGColor;
        
        if ([textView.text isEqualToString:kBodyPlaceHolderText]) {
            textView.text = @"";
            textView.textColor = [UIColor colorFromHexString:kBodyBorderColor]; //optional
        }
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.layer.borderWidth = 0;
    textView.layer.borderColor = [UIColor clearColor].CGColor;

    if ([textView.text isEqualToString:@""]) {
        textView.text = kBodyPlaceHolderText;
        textView.textColor = [UIColor colorFromHexString:kBodyTextColor];
    }
}



@end
