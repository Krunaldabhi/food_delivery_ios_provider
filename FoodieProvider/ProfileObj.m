//
//  ProfileObj.m
//  FoodieProvider
//
//  Created by APPLE on 9/28/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "ProfileObj.h"

@implementation ProfileObj


- (id)iniWithDictionary:(NSDictionary*)response {
    
    self.idStr  = [[response objectForKey:@"id"]integerValue];
    self.name   = [response objectForKey:@"name"];
    self.email  = [response objectForKey:@"email"];
    self.phone  = [response objectForKey:@"phone"];
    self.currencyStr  = [response objectForKey:@"currency"];
    self.status  = [response objectForKey:@"status"];
    self.device_id  = [response objectForKey:@"device_id"];
    self.device_token  = [response objectForKey:@"device_token"];
    self.device_type  = [response objectForKey:@"device_type"];

    self.payment_mode  = [response objectForKey:@"payment_mode"];
    

    if (self.avatar !=nil) {
        
        self.avatar = [response objectForKey:@"avatar"];
        
    }else{
        
        self.avatar = [Utilities removeNullFromString:[response objectForKey:@"avatar"]];

    }
    

    return self;
}


@end
