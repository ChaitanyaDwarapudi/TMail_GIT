//
//  ViewController.m
//  TMail
//
//  Created by Eshwar Rao on 5/7/15.
//  Copyright (c) 2015 ProKarma. All rights reserved.
//

#import "TMViewController.h"

@interface TMViewController ()

@property (strong,nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong,nonatomic) IBOutlet UIButton *sendBtn;
@property (strong,nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation TMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendBtnPressed:(id)sender {
    NSLog(@"Send button pressed ");
}

-(IBAction)cancelBtnPressed:(id)sender {
    NSLog(@"Cancel button pressed");
}


-(IBAction)backBtnPressed:(id)sender {
    NSLog(@"Back button pressed");
}

@end
