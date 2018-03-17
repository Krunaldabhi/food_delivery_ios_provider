//
//  AddressObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressObj : NSObject

@property (nonatomic , strong)NSNumber * addressIdStr;
@property (nonatomic , strong)NSString * building;
@property (nonatomic , strong)NSString * street;
@property (nonatomic , strong)NSString * city;
@property (nonatomic , strong)NSString * state;
@property (nonatomic , strong)NSString * country;
@property (nonatomic , strong)NSString * pincode;
@property (nonatomic , strong)NSString * landmark;
@property (nonatomic , strong)NSString * map_address;
@property (nonatomic , strong)NSString * latitude;
@property (nonatomic , strong)NSString * longitude;
@property (nonatomic , strong)NSString * type;

-(id)initWithAddressDictionary:(NSDictionary *)response;

@end
