//
//  AddressObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "AddressObj.h"

@implementation AddressObj


-(id)initWithAddressDictionary:(NSDictionary *)response{
    
    self.addressIdStr  = [response objectForKey:@"id"];
    self.building = [response objectForKey:@"building"];
    self.city = [response objectForKey:@"city"];
    self.state  = [response objectForKey:@"state"];
    self.street  = [response objectForKey:@"street"];
    self.country = [response objectForKey:@"country"];
    self.pincode  = [response objectForKey:@"pincode"];
    self.landmark = [response objectForKey:@"landmark"];
    self.map_address  = [response objectForKey:@"map_address"];
    self.latitude = [response objectForKey:@"latitude"];
    self.longitude  = [response objectForKey:@"longitude"];
    self.type = [response objectForKey:@"type"];    
    
    return self;
}




@end
