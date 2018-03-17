//
//  PriceObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/5/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "PriceObj.h"

@implementation PriceObj


-(id)initWithPriceDictionary:(NSDictionary *)response{
    
    self.price = [response objectForKey:@"price"];
    self.currency = [response objectForKey:@"currency"];

    return self;
}


@end
