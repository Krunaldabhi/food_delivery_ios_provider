//
//  LiveTaskObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "LiveTaskObj.h"

@implementation LiveTaskObj


-(id)initWithDictionary:(NSDictionary *)response{
    
    self.orderIdStr  = [response objectForKey:@"id"];
    self.route_key = [response objectForKey:@"route_key"];
    self.dispute  = [response objectForKey:@"dispute"];
    self.status = [response objectForKey:@"status"];
    self.created_at = [self datetoTimeConversionStr:[response objectForKey:@"created_at"]];
    
    self.addressObj = [[AddressObj alloc]initWithAddressDictionary:response[@"address"]];
    
    self.shopObj = [[ShopObj alloc]initWithShopDictionary:response[@"shop"]];
    
    self.userDetailsObj = [[UserDetailsObj alloc]initWithUserDictionary:response[@"user"]];
    
    self.invoiceObj = [[InvoiceObj alloc]initWithInvoiceDictionary:response[@"invoice"]];
    
    if ([[response valueForKey:@"transporter"] isKindOfClass:[NSString class]]) {
        
    }
    else if ([[response valueForKey:@"transporter"] isKindOfClass:[NSDictionary class]])
    {
        self.transporterObj = [[TransporterObj alloc]initWithTransporterDictionary:response[@"transporter"]];
    }
    else {
    }

    NSArray *disputeArr = [response valueForKey:@"dispute_manager"];
    
    if (disputeArr.count != 0) {
        
        self.disputeObj = [[DisputeObj alloc]initWithDisputeDictionary:[response[@"dispute_manager"] objectAtIndex:0]];
        
    }else{
        //        self.disputeObj = [[DisputeObj alloc]initWithDisputeDictionary:response[@"dispute_manager"]];
    }

    NSArray * itemsArr  = [response objectForKey:@"items"];
    NSArray * ordertimingArr  = [response objectForKey:@"ordertiming"];


    NSMutableArray * totalItemsArr = [[NSMutableArray alloc]init];
    NSMutableArray * totalorderTimingArr = [[NSMutableArray alloc]init];

    
    for (int i = 0; i < [itemsArr count]; i++) {
        
        ItemsObj * itemsObj = [[ItemsObj alloc]init];
        
        itemsObj.itemIdStr =[[itemsArr valueForKey:@"id"] objectAtIndex:i];
        itemsObj.quantity =[[itemsArr valueForKey:@"quantity"] objectAtIndex:i];
        
        itemsObj.productObj =[[ProductObj alloc]initWithProductDictionary:[[itemsArr valueForKey:@"product"] objectAtIndex:i]];
        itemsObj.cartObj =[[CartAddOnObj alloc]initWithCartDictionary:[[itemsArr valueForKey:@"cart_addons"] objectAtIndex:i]];        
        
        [totalItemsArr addObject:itemsObj];
        
    }

    if (ordertimingArr.count > 3) {
        
        for (int i = 0; i < [ordertimingArr count]; i++) {
            
            Orders * orderObj = [[Orders alloc]init];
            
            orderObj.IdStr =[[ordertimingArr valueForKey:@"id"] objectAtIndex:i];
            orderObj.status =[[ordertimingArr valueForKey:@"status"] objectAtIndex:i];
            orderObj.created_at =[[ordertimingArr valueForKey:@"created_at"] objectAtIndex:i];
            
            [totalorderTimingArr addObject:orderObj];
            
        }
        
    }

     if (totalItemsArr.count > 0) {
        self.itemsArray = [NSArray arrayWithArray:totalItemsArr];
    }

    if (totalorderTimingArr.count > 0) {
        self.ordersArr = [NSArray arrayWithArray:totalorderTimingArr];
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
