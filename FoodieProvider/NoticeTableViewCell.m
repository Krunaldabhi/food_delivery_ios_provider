//
//  NoticeTableViewCell.m
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "NoticeTableViewCell.h"
#import "Theme.h"
#import "config.h"


@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setLabels];

    [self settViewDesign];

}

-(void)settViewDesign{
    
    self.noticeContentView.layer.cornerRadius = 4.0f;
    self.noticeContentView.clipsToBounds = YES;
    
    self.noticeContentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.noticeContentView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.noticeContentView.layer.shadowRadius = 2;
    self.noticeContentView.layer.shadowOpacity =0.2;
    self.noticeContentView.layer.masksToBounds = NO;
}

-(void)setLabels{
    
    [Theme regularFontlabel:self.mainLbl];
    [Theme smallLabel:self.dateLbl];
    [Theme smallLabel:self.toLbl];
    [Theme smallLabel:self.messageLbl];
    [Theme smallLabel:self.precautionLbl];
    
    self.mainLbl.textColor = BLACK;
    self.toLbl.textColor = DESCDARKCOLOR;
    self.precautionLbl.textColor = BASECOLOR;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
