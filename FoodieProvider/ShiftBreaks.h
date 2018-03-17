//
//  ShiftBreaks.h
//  FoodieProvider
//
//  Created by APPLE on 9/27/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShiftBreaks : NSObject

@property(nonatomic, copy)NSString * transporter_shift_id;
@property(nonatomic, copy)NSString * shiftBreakstarTimeStr;
@property(nonatomic, copy)NSString * shiftBreakendTimeStr;
@property(nonatomic, copy)NSNumber * order_count;
@property(nonatomic, assign)NSInteger shiftBreakID;

@end
