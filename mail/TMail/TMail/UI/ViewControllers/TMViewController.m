//
//  ViewController.m
//  TMail
//
//  Created by Eshwar Rao on 5/7/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
//

#import "TMViewController.h"
#import "TMConstants.h"



@interface TMViewController ()
{
 
}

@property (strong,nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation TMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initialSetUp];
}

- (void)initialSetUp
{
    
 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)backBtnPressed:(id)sender {
    NSLog(@"Back button pressed");
}




@end
