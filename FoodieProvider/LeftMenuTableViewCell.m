//
//  LeftMenuTableViewCell.m
//  caretaker_user
//
//  Created by apple on 12/15/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "LeftMenuTableViewCell.h"
#import "Theme.h"

@implementation LeftMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [Theme regularFontlabel:self.menuLbl];
    self.menuLbl.font = [UIFont fontWithName:FONT_BOLD size:14];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
