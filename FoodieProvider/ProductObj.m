//
//  ProductObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "ProductObj.h"

@implementation ProductObj

-(id)initWithProductDictionary:(NSDictionary *)response{
    
    self.name = [response objectForKey:@"name"];
    self.descriptionStr = [response objectForKey:@"description"];
    self.food_type = [response objectForKey:@"food_type"];
    self.status = [response objectForKey:@"status"];
    
    self.priceObj =[[PriceObj alloc]initWithPriceDictionary:[response objectForKey:@"prices"]];
    
    return self;
}

@end
