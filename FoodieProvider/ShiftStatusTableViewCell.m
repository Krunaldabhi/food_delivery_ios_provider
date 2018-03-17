//
//  ShiftStatusTableViewCell.m
//  FoodieProvider
//
//  Created by APPLE on 9/20/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "ShiftStatusTableViewCell.h"
#import "Theme.h"
#import "config.h"

@implementation ShiftStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [Theme regularFontlabel:self.startorEndLbl];
    [Theme smallLabel:self.timingLbl];
    [Theme smallLabel:self.numberOfOrdersLbl];
    self.timingLbl.textColor = BASECOLOR;
    self.numberOfOrdersLbl.textColor = BASETEXT;
    [self.numberOfOrdersLbl setText:self.numberOfOrdersLbl.text.uppercaseString];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
