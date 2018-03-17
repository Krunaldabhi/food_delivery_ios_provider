//
//  ShopObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopObj : NSObject

@property (nonatomic , strong)NSNumber * shopIdStr;
@property (nonatomic , strong)NSString * name;
@property (nonatomic , strong)NSString * email;
@property (nonatomic , strong)NSString * phone;
@property (nonatomic , strong)NSString * avatar;
@property (nonatomic , strong)NSString * descriptionStr;
@property (nonatomic , strong)NSNumber * estimated_delivery_time;
@property (nonatomic , strong)NSString * address;
@property (nonatomic , strong)NSString * maps_address;
@property (nonatomic , strong)NSString * latitude;
@property (nonatomic , strong)NSString * longitude;
@property (nonatomic , strong)NSString * status;
@property (nonatomic , strong)NSString * pure_veg;


-(id)initWithShopDictionary:(NSDictionary *)response;

@end
