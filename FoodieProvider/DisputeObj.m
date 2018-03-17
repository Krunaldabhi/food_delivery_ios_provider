//
//  DisputeObj.m
//  FoodieProvider
//
//  Created by APPLE on 11/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "DisputeObj.h"

@implementation DisputeObj

-(id)initWithDisputeDictionary:(NSDictionary *)response{
    
    self.disputeIdStr  = [response objectForKey:@"id"];
    self.phone = [response objectForKey:@"phone"];

    return self;
}

@end
