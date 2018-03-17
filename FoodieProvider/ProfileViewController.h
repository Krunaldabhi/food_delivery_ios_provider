//
//  ProfileViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/20/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileObj.h"

@interface ProfileViewController : UIViewController{
    
    AppDelegate * appDelegate;
}
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *navLbl;
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;
@property (weak, nonatomic) IBOutlet UIImageView *camIMg;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *mobileLbl;
@property (weak, nonatomic) IBOutlet UILabel *usernameLbl;
@property (weak, nonatomic) IBOutlet UITextField *usernameTxt;
@property (weak, nonatomic) IBOutlet UITextField *mobileTxt;
@property (weak, nonatomic) IBOutlet UILabel *userIDLbl;
@property (weak, nonatomic) IBOutlet UITextField *userIDText;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressTxt;
@property (weak, nonatomic) IBOutlet UILabel *emailAdderssLbl;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *taptohide;
- (IBAction)taptoHideAction:(id)sender;
- (IBAction)backAction:(id)sender;



@end
