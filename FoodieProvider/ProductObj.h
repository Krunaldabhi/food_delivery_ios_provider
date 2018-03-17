//
//  ProductObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PriceObj.h"

@interface ProductObj : NSObject

@property (nonatomic , strong)NSString * name;
@property (nonatomic , strong)NSString * descriptionStr;
@property (nonatomic , strong)NSString * food_type;
@property (nonatomic , strong)NSString * status;
@property (nonatomic , strong)PriceObj * priceObj;


-(id)initWithProductDictionary:(NSDictionary *)response;


@end
