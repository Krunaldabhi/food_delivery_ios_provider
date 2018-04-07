//
//  LiveTaskIncomeTableViewCell.m
//  FoodieProvider
//
//  Created by CSS09 on 28/03/18.
//  Copyright © 2018 Tanjara Infotech. All rights reserved.
//

#import "LiveTaskIncomeTableViewCell.h"

@implementation LiveTaskIncomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)layoutSubviews{
    
    
    [self roundView:self.celltopView onCorner:UIRectCornerTopRight radius:4.0];
 //   [self.waitingtaskLbl setText:self.waitingtaskLbl.text.uppercaseString];
    
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
@end
