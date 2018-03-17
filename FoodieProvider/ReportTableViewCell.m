//
//  ReportTableViewCell.m
//  FoodieProvider
//
//  Created by APPLE on 9/22/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "ReportTableViewCell.h"
#import "config.h"
#import "Theme.h"

@implementation ReportTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self interfaceDesign];

}

-(void)interfaceDesign{
    
    [Theme regularFontlabel:self.reportLbl];
    
    self.reportLbl.textColor = BLACK;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
