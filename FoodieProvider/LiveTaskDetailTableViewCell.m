//
//  LiveTaskDetailTableViewCell.m
//  FoodieProvider
//
//  Created by APPLE on 9/19/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "LiveTaskDetailTableViewCell.h"
#import "Theme.h"
#import "config.h"
#import "Utilities.h"

@implementation LiveTaskDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.itemName.font = [UIFont fontWithName:FONT_SEMIBOLD size:15.0];
    
    self.itemName.textColor = BLACK;
    
    self.itemPrice.font = [UIFont fontWithName:FONT_SEMIBOLD size:15.0];
    self.itemPrice.textColor = BLACK;
    
    self.addOnsLbl.font = [UIFont fontWithName:FONT_REGULAR size:12.0];
    self.addOnsLbl.textColor = BASETEXT;

    
    self.itemQuantity.textColor = BLACK;
    self.itemQuantity.font = [UIFont fontWithName:FONT_SEMIBOLD size:15.0];

    self.mutliplyLbl.textColor = BLACK;
    self.mutliplyLbl.text = @"*";
    self.mutliplyLbl.font = [UIFont fontWithName:FONT_SEMIBOLD size:15.0];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
