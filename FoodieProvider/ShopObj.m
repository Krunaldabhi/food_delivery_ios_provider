//
//  ShopObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "ShopObj.h"

@implementation ShopObj


-(id)initWithShopDictionary:(NSDictionary *)response{

    self.shopIdStr  = [response objectForKey:@"id"];
    self.name  = [response objectForKey:@"name"];
    self.email = [response objectForKey:@"email"];
    self.phone  = [response objectForKey:@"phone"];
    self.avatar = [response objectForKey:@"avatar"];
    self.descriptionStr  = [response objectForKey:@"description"];
    self.estimated_delivery_time = [response objectForKey:@"estimated_delivery_time"];
    self.address  = [response objectForKey:@"address"];
    self.maps_address = [response objectForKey:@"maps_address"];
    self.latitude  = [response objectForKey:@"latitude"];
    self.longitude = [response objectForKey:@"longitude"];
    self.status = [response objectForKey:@"status"];
    self.pure_veg = [response objectForKey:@"pure_veg"];


    return self;
}

@end
