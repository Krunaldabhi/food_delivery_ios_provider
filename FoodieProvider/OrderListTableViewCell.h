//
//  OrderListTableViewCell.h
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *listContentView;
@property (weak, nonatomic) IBOutlet UIImageView *orderImgView;

@property (weak, nonatomic) IBOutlet UILabel *restaurentLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (weak, nonatomic) IBOutlet UIImageView *clockIcon;
@property (weak, nonatomic) IBOutlet UIImageView *listiCon;
@property (weak, nonatomic) IBOutlet UIImageView *moneyIcon;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *noofItems;
@property (weak, nonatomic) IBOutlet UILabel *amountLbl;
@property (weak, nonatomic) IBOutlet UIImageView *stripeImg;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

@end
