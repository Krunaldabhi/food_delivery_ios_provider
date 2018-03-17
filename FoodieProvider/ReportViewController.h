//
//  ReportViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/22/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *reportTableView;
@property (weak, nonatomic) IBOutlet UILabel *navLbl;
@property (weak, nonatomic) IBOutlet UIButton *backbtn;
@property (weak, nonatomic) NSString *titleStr;

- (IBAction)backAction:(id)sender;

@end
