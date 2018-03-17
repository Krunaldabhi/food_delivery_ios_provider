//
//  ProfileObj.h
//  FoodieProvider
//
//  Created by APPLE on 9/28/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileObj : NSObject

@property(nonatomic, assign)NSInteger idStr;
@property(nonatomic, copy)NSString * name;
@property(nonatomic, copy)NSString * email;
@property(nonatomic, copy)NSString * phone;
@property(nonatomic, copy)NSString * avatar;
@property(nonatomic, copy)NSString * currencyStr;
@property(nonatomic, copy)NSString * latitude;
@property(nonatomic, copy)NSString * longitude;
@property(nonatomic, copy)NSString * status;
@property(nonatomic, copy)NSString * payment_mode;
@property(nonatomic, copy)NSString * device_id;
@property(nonatomic, copy)NSString * device_token;
@property(nonatomic, copy)NSString * device_type;


- (id)iniWithDictionary:(NSDictionary*)response;


@end
