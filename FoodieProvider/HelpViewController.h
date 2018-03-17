//
//  HelpViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/22/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *navLbl;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *topicLbl;
@property (weak, nonatomic) IBOutlet UITextView *reasonTxtView;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;

- (IBAction)backAction:(id)sender;
- (IBAction)chatAction:(id)sender;
- (IBAction)callAction:(id)sender;

@end
