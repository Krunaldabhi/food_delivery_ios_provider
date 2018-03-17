//
//  LiveTaskTableViewCell.m
//  FoodieProvider
//
//  Created by APPLE on 9/18/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "LiveTaskTableViewCell.h"

@implementation LiveTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)layoutSubviews{
    
    
        [self roundView:self.celltopView onCorner:UIRectCornerTopRight radius:4.0];
        [self.waitingtaskLbl setText:self.waitingtaskLbl.text.uppercaseString];

}

-(void)roundView:(UIView *)view onCorner:(UIRectCorner)rectCorner radius:(float)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    [view.layer setMask:maskLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
