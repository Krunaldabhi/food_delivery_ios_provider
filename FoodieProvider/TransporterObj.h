//
//  TransporterObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransporterObj : NSObject

@property (nonatomic , strong)NSNumber * transporterId;
@property (nonatomic , strong)NSString * avatar;
@property (nonatomic , strong)NSString * device_id;
@property (nonatomic , strong)NSString * device_token;
@property (nonatomic , strong)NSString * device_type;
@property (nonatomic , strong)NSString * email;
@property (nonatomic , strong)NSString * latitude;
@property (nonatomic , strong)NSString * longitude;
@property (nonatomic , strong)NSString * name;
@property (nonatomic , strong)NSString * phone;
@property (nonatomic , strong)NSString * status;

-(id)initWithTransporterDictionary:(NSDictionary *)response;


@end
