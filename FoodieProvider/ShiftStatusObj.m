//
//  ShiftStatusObj.m
//  FoodieProvider
//
//  Created by APPLE on 9/27/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "ShiftStatusObj.h"

@implementation ShiftStatusObj

- (id)iniWithDictionary:(NSDictionary*)response {
    
    NSArray * shiftTimesArr  = [response objectForKey:@"shiftbreaktimes"];
       self.providerShiftID  = [response objectForKey:@"id"];
       self.transporterIDStr = [response objectForKey:@"transporter_id"];
       self.total_amount = [response objectForKey:@"total_amount"];
       self.total_amount_pay = [response objectForKey:@"total_amount_pay"];
       self.total_order = [response objectForKey:@"total_order"];
    
    if ([[response objectForKey:@"end_time"] isEqual:[NSNull null]]) {
        
        self.shiftEndTime = nil;
    }
    else{
        
        self.shiftEndTime = [self datetoTimeConversionStr:[response objectForKey:@"end_time"]];
        
    }
    
    self.shiftStarttime = [self datetoTimeConversionStr:[response objectForKey:@"start_time"]];
    
    NSMutableArray * breaksArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [shiftTimesArr count]; i++) {
        
        ShiftBreaks * shiftObj = [[ShiftBreaks alloc]init];
        
        NSString * breakStartTime =[[shiftTimesArr valueForKey:@"start_time"] objectAtIndex:i];
        shiftObj.shiftBreakstarTimeStr = [self datetoTimeConversionStr:breakStartTime];
        
        NSString * breakendTime =[[shiftTimesArr valueForKey:@"end_time"] objectAtIndex:i];
        shiftObj.shiftBreakendTimeStr = [self datetoTimeConversionStr:breakendTime];
        
        shiftObj.shiftBreakID = [[[shiftTimesArr valueForKey:@"id"] objectAtIndex:i] integerValue];
        shiftObj.transporter_shift_id = [[shiftTimesArr valueForKey:@"transporter_shift_id"] objectAtIndex:i];
        shiftObj.order_count = [[shiftTimesArr valueForKey:@"order_count"] objectAtIndex:i];

        
        [breaksArr addObject:shiftObj];
    }
    
    if (breaksArr.count > 0) {
        self.shiftBreaks = [NSArray arrayWithArray:breaksArr];
    }
    return self;
}

-(NSString *)datetoTimeConversionStr:(NSString *)getThestringTime{
    
    if ([getThestringTime isEqual:[NSNull null]]) {
        
        return @"";
    }
    else{
        
        NSString * getTitleforTimeStr = [Utilities removeNullFromString:[NSString stringWithFormat:@"%@",getThestringTime]];
        NSArray * splitEndDateString = [getTitleforTimeStr componentsSeparatedByString:@" "];
//        NSString *dateString = [splitEndDateString objectAtIndex:0];
        NSString *timeString = [splitEndDateString objectAtIndex:1];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss";
        NSDate *date = [dateFormatter dateFromString:timeString];
        
        dateFormatter.dateFormat = @"hh:mm a";
        NSString *pmamStartDateString = [dateFormatter stringFromDate:date];
        
        return pmamStartDateString;
        
    }
}

@end
