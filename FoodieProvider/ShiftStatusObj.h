//
//  ShiftStatusObj.h
//  FoodieProvider
//
//  Created by APPLE on 9/27/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShiftBreaks.h"

@interface ShiftStatusObj : NSObject

@property(nonatomic, copy)NSString * providerShiftID;
@property(nonatomic, copy)NSString * shiftStarttime;
@property(nonatomic, copy)NSString * shiftEndTime;
@property(nonatomic, copy)NSString * transporterIDStr;
@property(nonatomic, copy)NSString * transporterIVehicleIDStr;
@property(nonatomic, copy)NSNumber * total_amount;
@property(nonatomic, copy)NSNumber * total_amount_pay;
@property(nonatomic, copy)NSNumber * total_order;

@property(nonatomic, copy)NSArray * shiftBreaks;

- (id)iniWithDictionary:(NSDictionary*)response;

@end
