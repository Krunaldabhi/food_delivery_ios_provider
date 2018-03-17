//
//  SecurityViewController.h
//  FoodieProvider
//
//  Created by APPLE on 10/7/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecurityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIButton *conitnue;
- (IBAction)submitAction:(id)sender;

@end
