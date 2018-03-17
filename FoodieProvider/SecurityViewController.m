//
//  SecurityViewController.m
//  FoodieProvider
//
//  Created by APPLE on 10/7/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "SecurityViewController.h"

@interface SecurityViewController ()<UITextFieldDelegate>

@end

@implementation SecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Theme viewShadowDesign:self.passTextField];
    [Theme fontForTextfield:self.passTextField];
    [Theme baseButton:self.conitnue];
    
    
    // Do any additional setup after loading the view.
}

- (IBAction)submitAction:(id)sender {


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
