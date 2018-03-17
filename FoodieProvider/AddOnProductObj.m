//
//  AddOnProductObj.m
//  FoodieProvider
//
//  Created by APPLE on 11/24/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "AddOnProductObj.h"

@implementation AddOnProductObj


-(id)initWithAddOnProductDictionary:(NSDictionary *)response{
    
    
    NSDictionary * checkAddonDic = [response valueForKey:@"addon"];
    
    self.addon_id = [response valueForKey:@"addon_id"];
    self.product_id = [response valueForKey:@"product_id"];
    self.price = [response valueForKey:@"price"];
    self.add_id = [checkAddonDic valueForKey:@"id"];
    self.name = [checkAddonDic valueForKey:@"name"];
    self.shop_id = [checkAddonDic valueForKey:@"shop_id"];
    
    self.nameArr = [[NSMutableArray alloc]init];
    
    [self.nameArr addObject:self.name];
    
    return self;
}


@end
