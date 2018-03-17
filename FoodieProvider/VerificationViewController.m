//
//  VerificationViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/15/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "VerificationViewController.h"
#import "ShiftStatusViewController.h"
#import "UIView+Toast.h"
#import "Theme.h"
#import "config.h"
#import "Utilities.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "AFNHelper.h"


@interface VerificationViewController ()<UITextFieldDelegate>{
    
    AppDelegate * appDelegate;
}

@end

@implementation VerificationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self userinferfaceDesign];

    appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)userinferfaceDesign{
    
    self.view.backgroundColor = BGCOLOR;
    
    [Theme header:self.verfyLbl];
    [Theme regularFontlabel:self.otpLabel];
    [Theme descriptionHeader:self.didntgetLabel];
    [Theme descriptionHeader:self.textNumberLbl];

    self.textNumberLbl.font = [UIFont fontWithName:FONT_SEMIBOLD size:14.0];
    self.resendBtn.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:14.0];
    
    [Theme smallLabel:self.textNumberLbl];
    
    [Theme smallLabel:self.mobileNoLbl];
    
    [Theme baseButton:self.nextBtn];
    
    [self.nextBtn setTitle:NSLocalizedString(@"SIGNINBUTTONNAME", nil) forState:UIControlStateNormal];
    self.textNumberLbl.text = NSLocalizedString(@"PLEASEENTEROTP", nil);
    self.otpLabel.text = [NSString stringWithFormat:@"Your OTP is: %@",self.getOtpStr];
    self.verfyLbl.text = NSLocalizedString(@"VERIFYCODELABEL", nil);
    self.mobileNoLbl.text = self.mobileNumberStr;
    self.didntgetLabel.text = NSLocalizedString(@"DIDNTGETOTPLABEL", nil);
    [self.resendBtn setTitle:NSLocalizedString(@"RESENDOTPLABEL", nil) forState:UIControlStateNormal];
    [self.resendBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];

    self.mobileNoLbl.textColor = BASECOLOR;

    
    [self textfieldInterface];

}
- (void)textfieldInterface
{
    
    self.firstTxt.backgroundColor = DESCCOLOR;
    self.secontTxt.backgroundColor = DESCCOLOR;
    self.thirdTxt.backgroundColor = DESCCOLOR;
    self.fourthTxt.backgroundColor = DESCCOLOR;
    self.fifthTxt.backgroundColor = DESCCOLOR;
    self.sixthText.backgroundColor = DESCCOLOR;


    [Theme cornerRadius:nil forLabel:nil fortextfield:self.firstTxt forButton:nil];
    [Theme cornerRadius:nil forLabel:nil fortextfield:self.secontTxt forButton:nil];
    [Theme cornerRadius:nil forLabel:nil fortextfield:self.thirdTxt forButton:nil];
    [Theme cornerRadius:nil forLabel:nil fortextfield:self.fourthTxt forButton:nil];
    [Theme cornerRadius:nil forLabel:nil fortextfield:self.fifthTxt forButton:nil];
    [Theme cornerRadius:nil forLabel:nil fortextfield:self.sixthText forButton:nil];

    
    [Theme fontForTextfield:self.firstTxt];
    [Theme fontForTextfield:self.secontTxt];
    [Theme fontForTextfield:self.thirdTxt];
    [Theme fontForTextfield:self.fourthTxt];
    [Theme fontForTextfield:self.fifthTxt];
    [Theme fontForTextfield:self.sixthText];

    
    self.firstTxt.font = [UIFont fontWithName:FONT_BOLD size:16.0];
    self.secontTxt.font = [UIFont fontWithName:FONT_BOLD size:16.0];
    self.thirdTxt.font = [UIFont fontWithName:FONT_BOLD size:16.0];
    self.fourthTxt.font = [UIFont fontWithName:FONT_BOLD size:16.0];
    self.fifthTxt.font = [UIFont fontWithName:FONT_BOLD size:16.0];
    self.sixthText.font = [UIFont fontWithName:FONT_BOLD size:16.0];

    
    self.firstTxt.textColor = WHITE;
    self.secontTxt.textColor = WHITE;
    self.thirdTxt.textColor = WHITE;
    self.fourthTxt.textColor = WHITE;
    self.fifthTxt.textColor = WHITE;
    self.sixthText.textColor = WHITE;

    
    [self addToolBar:self.firstTxt];
    [self addToolBar:self.secontTxt];
    [self addToolBar:self.thirdTxt];
    [self addToolBar:self.fourthTxt];
    [self addToolBar:self.fifthTxt];
    [self addToolBar:self.sixthText];

    
    [self.firstTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.secontTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.thirdTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.fourthTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.fifthTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.sixthText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];


}

//TextField delegate

-(void)textFieldDidChange:(UITextField *)textField{
    
    NSString * stringText = textField.text;
    
    if (stringText.length >=1) {

        switch (textField.tag) {
           
            case 1:
                [self.secontTxt becomeFirstResponder];
                break;
                
            case 2:
                [self.thirdTxt becomeFirstResponder];
                break;
                
            case 3:
                [self.fourthTxt becomeFirstResponder];
                break;
                
            case 4:
                [self.fifthTxt becomeFirstResponder];
                break;

            case 5:
                [self.sixthText becomeFirstResponder];
                break;
                
            case 6:
                [self.sixthText resignFirstResponder];
                self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

                break;
                
            default:
                break;
        }
        
        }
    }
    


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.view.bounds.size.height < 667) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height);
            
        }];
        
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);

        }];
        
    }
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((textField.text.length == 1) && (string.length == 1))
    {
        NSInteger nextTag = textField.tag + 1;
        // Try to find next responder
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        if (! nextResponder)
            nextResponder = [textField.superview viewWithTag:1];
        
        if (nextResponder){
            // Found next responder, so set it.
            [nextResponder becomeFirstResponder];
        }
        
        return NO;
    }
        return YES;
 
}
 


-(void)addToolBar:(UITextField *)textField{
    
    UIToolbar * numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.tintColor = BASECOLOR;
    numberToolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:
                                                     UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    textField.inputAccessoryView = numberToolbar;
}

-(void)doneWithNumberPad{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.firstTxt resignFirstResponder];
        [self.secontTxt resignFirstResponder];
        [self.thirdTxt resignFirstResponder];
        [self.fourthTxt resignFirstResponder];
        [self.fifthTxt resignFirstResponder];
        [self.sixthText resignFirstResponder];

    }];
    
}

- (IBAction)taptokeyboardAction:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view endEditing:YES];
        
    }];
}

- (IBAction)nextAction:(id)sender {

    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view endEditing:YES];
        
    }];
    
    if (self.firstTxt.text.length==0 || self.secontTxt.text.length==0 || self.thirdTxt.text.length==0|| self.fourthTxt.text.length==0 || self.fifthTxt.text.length==0|| self.sixthText.text.length==0) {
        
        [self.view makeToast:@"ENTEROTP"];
        
    }else{
        
        [self registerService];
    }
    
}

-(void)registerService{
    
    NSString * otpStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",self.firstTxt.text,self.secontTxt.text,self.thirdTxt.text,self.fourthTxt.text,self.fifthTxt.text,self.sixthText.text];

    if (!([otpStr intValue] == [self.getOtpStr integerValue])) {
        
        [Utilities showAlert:NSLocalizedString(@"CHKOTP", nil)];
        
    }else{
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        NSString * mobileNoStr = [self.mobileNumberStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        NSDictionary * params=@{@"phone":mobileNoStr,@"otp":otpStr};
        
        [appDelegate onStartLoader];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:MD_VERFYOTP withParamData:params withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            [appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"OTP response...%@", response);
                
                NSUserDefaults * userAuthDefault = [NSUserDefaults standardUserDefaults];
                [userAuthDefault setValue:response[@"access_token"] forKey:@"access_token"];
                [userAuthDefault setValue:response[@"token_type"] forKey:@"token_type"];
     
                [userAuthDefault synchronize];
                
                [self nextVC];
            }
            else
            {
                
                    [appDelegate onEndLoader];
                    
                    NSString * errorStr = [NSString stringWithFormat:@"%@",Error[@"error"]];
                    
                    [Utilities showAlert:errorStr];
                    
                }
            }];
        }else{
            
            [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
        }
    }
}

- (IBAction)resendAction:(id)sender {
    
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        //        NSDictionary * params=@{@"phone":[NSString stringWithFormat:@"%@%@",countryCodeStr,self.mobileTxt.text]};
        NSString * mobileNoStr = [self.mobileNumberStr stringByReplacingOccurrencesOfString:@"-" withString:@""];

        NSDictionary * params=@{@"phone":mobileNoStr};
        
        
        [appDelegate onStartLoader];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:MD_LOGIN withParamData:params withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            [appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"Login response...%@", response);
                
                self.getOtpStr = response[@"otp"];
                
            }
            else
            {
                [appDelegate onEndLoader];
                
                NSString * errorStr = [NSString stringWithFormat:@"%@",Error[@"phone"]];
                
                [Utilities showAlert:errorStr];
                
            }
        }];
    }else{
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
    
}


-(void)nextVC{
    
    ShiftStatusViewController * shiftVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShiftStatusViewController"];
    [self.navigationController pushViewController:shiftVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
