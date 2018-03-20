//
//  LiveTaskTableViewCell.h
//  FoodieProvider
//
//  Created by APPLE on 9/18/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LiveTaskTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *listcontentView;
@property (weak, nonatomic) IBOutlet UIImageView *orderImg;
@property (weak, nonatomic) IBOutlet UILabel *restaurentName;
@property (weak, nonatomic) IBOutlet UILabel *orderLbl;
@property (weak, nonatomic) IBOutlet UILabel *cellTopLbl;

@property (strong, nonatomic) IBOutlet UIView *celltopView;
@property (strong, nonatomic) IBOutlet UILabel *topOrderLabel;
@property (strong, nonatomic) IBOutlet UILabel *fewSecondAgo;
@property (weak, nonatomic) IBOutlet UIImageView *testLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitingtaskLbl;
@property (weak, nonatomic) IBOutlet UIView *waitingView;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImg;
@property (weak, nonatomic) IBOutlet UIButton *acceptBtn;
@property (weak, nonatomic) IBOutlet UIButton *rejectBtn;

-(void)roundView:(UIView *)view onCorner:(UIRectCorner)rectCorner radius:(float)radius;


@end
