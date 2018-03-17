//
//  ShiftStatusTableViewCell.h
//  FoodieProvider
//
//  Created by APPLE on 9/20/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShiftStatusTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *verticalLineImg;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (weak, nonatomic) IBOutlet UILabel *numberOfOrdersLbl;
@property (weak, nonatomic) IBOutlet UILabel *startorEndLbl;
@property (weak, nonatomic) IBOutlet UILabel *timingLbl;



@end
