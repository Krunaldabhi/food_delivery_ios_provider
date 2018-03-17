//
//  UserDetailsObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "UserDetailsObj.h"

@implementation UserDetailsObj

-(id)initWithUserDictionary:(NSDictionary *)response{
    
    
    self.userIdStr = [response objectForKey:@"id"];
    self.name = [response objectForKey:@"name"];
    self.email = [response objectForKey:@"email"];
    self.phone = [response objectForKey:@"phone"];
    self.avatar = [response objectForKey:@"avatar"];
    
    if ([[response objectForKey:@"avatar"] isEqual:[NSNull null]]) {

      self.avatar =  [Utilities removeNullFromString:[response objectForKey:@"name"]];
    }
    
    return self;
}


@end
