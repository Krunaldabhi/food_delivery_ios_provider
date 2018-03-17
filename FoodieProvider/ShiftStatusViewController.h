//
//  ShiftStatusViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/15/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShiftStatusObj.h"
#import "VehicleObj.h"
#import "ProfileObj.h"
#import <UserNotifications/UserNotifications.h>

@interface ShiftStatusViewController : UIViewController<UNUserNotificationCenterDelegate>{
    
    UIView * blackbgView;
}

@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UILabel *shiftstatusLbl;
@property (weak, nonatomic) IBOutlet UIButton *sideBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sideIconImg;
@property (weak, nonatomic) IBOutlet UIImageView *purchaseImg;
@property (weak, nonatomic) IBOutlet UILabel *tapLbl;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmEndBtn;

@property (weak, nonatomic) IBOutlet UIView *vehiclenoEnterView;
@property (weak, nonatomic) IBOutlet UIImageView *typoImg;
@property (weak, nonatomic) IBOutlet UIButton *vehiclenoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *dropImg;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIView *orView;
@property (weak, nonatomic) IBOutlet UILabel *orLbl;

@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (weak, nonatomic) IBOutlet UILabel *enterLbl;
@property (weak, nonatomic) IBOutlet UITextField *enterTxtField;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UISwitch *shiftstatusSwitch;
@property (weak, nonatomic) IBOutlet UIView *youOwnedView;
@property (weak, nonatomic) IBOutlet UILabel *youOwnedLbl;
@property (weak, nonatomic) IBOutlet UILabel *ownedAmountLbl;
@property (weak, nonatomic) IBOutlet UITableView *shiftTableView;

@property (weak, nonatomic) IBOutlet UIView *amountToBePaidView;
@property (weak, nonatomic) IBOutlet UILabel *amountToBePaidLbl;
@property (weak, nonatomic) IBOutlet UILabel *amountLbl;
@property (weak, nonatomic) IBOutlet UILabel *pleaseHandoverLbl;
@property (weak, nonatomic) IBOutlet UIButton *amountendShiftBtn;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *taptohide;
@property (weak, nonatomic) IBOutlet UILabel *vehicleTxt;
@property (strong, nonatomic)AppDelegate * appDelegate;



- (IBAction)amountshiftEndAction:(id)sender;

- (IBAction)shiftAction:(UISwitch *)sender;

- (IBAction)starAction:(id)sender;
- (IBAction)sideAction:(id)sender;
- (IBAction)listVehicleAction:(id)sender;
- (IBAction)continueAction:(id)sender;
- (IBAction)bgAction:(id)sender;

@end
