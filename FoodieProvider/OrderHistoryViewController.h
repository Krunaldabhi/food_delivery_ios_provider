//
//  OrderHistoryViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveTaskObj.h"
#import "ItemsObj.h"

@interface OrderHistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *orderlistTableView;
@property (weak, nonatomic) IBOutlet UIButton *daytodayBtn;
@property (weak, nonatomic) IBOutlet UIImageView *dropIconImg;
@property (weak, nonatomic) IBOutlet UILabel *daytodayLbl;
@property (weak, nonatomic) IBOutlet UIView *navMenuView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *navLbl;
@property (weak, nonatomic)AppDelegate * appDelegate;
@property (strong, nonatomic)LiveTaskObj * liveTaskObj;
@property (strong, nonatomic)NSMutableArray * ordersArr;
@property (weak, nonatomic) IBOutlet UIView *daytoDayView;
@property (weak, nonatomic) IBOutlet UIView *noResultView;
@property (weak, nonatomic) IBOutlet UILabel *noresultLbl;

- (IBAction)daytodayAction:(id)sender;

- (IBAction)backAction:(id)sender;

@end
