//
//  NoticeTableViewCell.h
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *noticeContentView;
@property (weak, nonatomic) IBOutlet UILabel *mainLbl;

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *toLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UILabel *precautionLbl;

@end
