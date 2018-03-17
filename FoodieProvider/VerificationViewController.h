//
//  VerificationViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/15/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileObj.h"

@interface VerificationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *verfyLbl;

@property (weak, nonatomic) IBOutlet UILabel *textNumberLbl;

@property (strong, nonatomic) ProfileObj * profileObjects;

@property (weak, nonatomic) IBOutlet UITextField *firstTxt;
@property (weak, nonatomic) IBOutlet UITextField *secontTxt;
@property (weak, nonatomic) IBOutlet UITextField *thirdTxt;
@property (weak, nonatomic) IBOutlet UITextField *fourthTxt;
@property (weak, nonatomic) IBOutlet UITextField *fifthTxt;
@property (weak, nonatomic) IBOutlet UITextField *sixthText;
@property (weak, nonatomic) IBOutlet UILabel *didntgetLabel;
@property (weak, nonatomic) IBOutlet UIButton *resendBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *mobileNoLbl;

@property(nonatomic, copy)NSString * mobileNumberStr;
@property(nonatomic, copy)NSString * getOtpStr;

- (IBAction)backAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *taptohideKeyboard;
- (IBAction)taptokeyboardAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *otpLabel;
- (IBAction)resendAction:(id)sender;

@end
