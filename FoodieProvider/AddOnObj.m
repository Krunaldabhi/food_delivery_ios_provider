//
//  AddOnObj.m
//  FoodieProvider
//
//  Created by APPLE on 11/24/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "AddOnObj.h"

@implementation AddOnObj


-(id)initWithAddonDictionary:(NSDictionary *)response{
    
    self.addOnid = [response objectForKey:@"id"];
    self.quantity = [response objectForKey:@"quantity"];
    
    self.addOnProductObj = [[AddOnProductObj alloc]initWithAddOnProductDictionary:[response objectForKey:@"addon_product"]];
    

    
    return self;
}

@end
