//
//  DisputeViewController.h
//  FoodieProvider
//
//  Created by APPLE on 11/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisputeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderIdwithcontentLabel;
@property (weak, nonatomic) IBOutlet UILabel *yourDisputeLbl;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)callOrCancelAction:(id)sender;

@end
