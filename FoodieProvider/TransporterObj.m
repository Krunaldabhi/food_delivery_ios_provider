//
//  TransporterObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "TransporterObj.h"

@implementation TransporterObj

-(id)initWithTransporterDictionary:(NSDictionary *)response{
    
    self.transporterId  = [response objectForKey:@"id"];
    self.avatar  = [response objectForKey:@"avatar"];
    self.device_id = [response objectForKey:@"device_id"];
    self.device_token  = [response objectForKey:@"device_token"];
    self.device_type = [response objectForKey:@"device_type"];
    self.email  = [response objectForKey:@"email"];
    self.latitude = [response objectForKey:@"latitude"];
    self.longitude  = [response objectForKey:@"longitude"];
    self.name = [response objectForKey:@"name"];
    self.phone  = [response objectForKey:@"phone"];
    self.status = [response objectForKey:@"status"];
    
    
    return self;
}

@end
