//
//  LiveTaskIncomeTableViewCell.h
//  FoodieProvider
//
//  Created by CSS09 on 28/03/18.
//  Copyright © 2018 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveTaskIncomeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *listcontentView;
@property (weak, nonatomic) IBOutlet UIImageView *orderImg;
@property (weak, nonatomic) IBOutlet UILabel *restaurentName;
@property (weak, nonatomic) IBOutlet UILabel *orderLbl;
@property (weak, nonatomic) IBOutlet UILabel *cellTopLbl;

@property (strong, nonatomic) IBOutlet UIView *celltopView;
@property (strong, nonatomic) IBOutlet UILabel *topOrderLabel;
@property (strong, nonatomic) IBOutlet UILabel *fewSecondAgo;


-(void)roundView:(UIView *)view onCorner:(UIRectCorner)rectCorner radius:(float)radius;

@property (weak, nonatomic) IBOutlet UIButton *acceptBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *viewH;
@property (weak, nonatomic) IBOutlet UIView *viewV;

@end
