//
//  CountryCodeCell.h
//  FoodieUser
//
//  Created by infos on 9/27/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCodeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flagsImageView;

@property (weak, nonatomic) IBOutlet UILabel *countrysNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *countrysCodeLbl;

@end
