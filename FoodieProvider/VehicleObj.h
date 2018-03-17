//
//  VehicleObj.h
//  FoodieProvider
//
//  Created by APPLE on 9/28/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleObj : NSObject

@property (nonatomic,strong)NSString * vehicle_Id;
@property (nonatomic,strong)NSString * transporter_id;
@property (nonatomic,strong)NSString * vehicle_no;
@property (nonatomic, retain)NSMutableArray * vehicleArr;

- (id)initWithresposeArray:(NSArray *)response;

@end
