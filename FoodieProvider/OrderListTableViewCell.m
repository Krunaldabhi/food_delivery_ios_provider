//
//  OrderListTableViewCell.m
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "OrderListTableViewCell.h"
#import "Theme.h"
#import "config.h"

@implementation OrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.orderImgView.clipsToBounds = YES;
    self.orderImgView.layer.cornerRadius = 4;
    
    [Theme regularFontlabel:self.restaurentLbl];
    self.restaurentLbl.textColor = [UIColor blackColor];
    
    [Theme smallLabel:self.orderIdLbl];
    self.orderIdLbl.textColor = BASECOLOR;
    
    self.statusLbl.textColor = WHITE;
    self.statusLbl.font = [UIFont fontWithName:FONT_REGULAR size:10.0];
    
    [Theme smallLabel:self.timeLbl];
    [Theme smallLabel:self.noofItems];
    [Theme smallLabel:self.amountLbl];
    
    self.timeLbl.font = [UIFont fontWithName:FONT_SEMIBOLD size:12.0];
    self.noofItems.font = [UIFont fontWithName:FONT_SEMIBOLD size:12.0];
    self.amountLbl.font = [UIFont fontWithName:FONT_SEMIBOLD size:12.0];
    
    self.timeLbl.textColor = DESCDARKCOLOR;
    self.amountLbl.textColor = DESCDARKCOLOR;
    self.noofItems.textColor = DESCDARKCOLOR;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
