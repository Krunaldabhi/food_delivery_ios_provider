//
//  LiveTaskDetailTableViewCell.h
//  FoodieProvider
//
//  Created by APPLE on 9/19/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveTaskDetailTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
@property (weak, nonatomic) IBOutlet UIView *itemView;
@property (weak, nonatomic) IBOutlet UILabel *itemQuantity;
@property (weak, nonatomic) IBOutlet UILabel *mutliplyLbl;
@property (weak, nonatomic) IBOutlet UILabel *addOnsLbl;


@end
