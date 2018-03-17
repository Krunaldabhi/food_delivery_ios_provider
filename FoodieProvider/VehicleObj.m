
//
//  VehicleObj.m
//  FoodieProvider
//
//  Created by APPLE on 9/28/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "VehicleObj.h"

@implementation VehicleObj

- (id)initWithresposeArray:(NSArray *)response {
    
    self.vehicleArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [response count]; i++) {
        
        self.vehicle_Id = [[response valueForKey:@"id "] objectAtIndex:i];
        self.vehicle_no = [[response valueForKey:@"vehicle_no"] objectAtIndex:i];
        self.transporter_id = [[response valueForKey:@"transporter_id"] objectAtIndex:i];
        
        [self.vehicleArr addObject:self.vehicle_no];
        
    }
    
    return self;
}

@end
