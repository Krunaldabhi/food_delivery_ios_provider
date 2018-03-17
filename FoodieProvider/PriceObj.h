//
//  PriceObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/5/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceObj : NSObject

@property (nonatomic , strong)NSNumber * price;
@property (nonatomic , strong)NSString * currency;

-(id)initWithPriceDictionary:(NSDictionary *)response;

@end
