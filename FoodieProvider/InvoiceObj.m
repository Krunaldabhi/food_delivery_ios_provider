//
//  InvoiceObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/6/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "InvoiceObj.h"

@implementation InvoiceObj

-(id)initWithInvoiceDictionary:(NSDictionary *)response{
    
    self.invoiceIdStr  = [response objectForKey:@"id"];
    self.order_id  = [response objectForKey:@"order_id"];
    self.quantity = [response objectForKey:@"quantity"];
    self.paid  = [response objectForKey:@"paid"];
    self.gross = [response objectForKey:@"gross"];
    self.discount  = [response objectForKey:@"discount"];
    self.delivery_charge = [response objectForKey:@"delivery_charge"];
    self.tax  = [response objectForKey:@"tax"];
    self.payable = [response objectForKey:@"payable"];
    self.net = [response objectForKey:@"net"];
    self.wallet_amount = [response objectForKey:@"wallet_amount"];
    self.total_pay  = [Utilities removeNullFromNumber:[response objectForKey:@"total_pay"]];
    self.tender_pay =  [Utilities removeNullFromNumber:[response objectForKey:@"tender_pay"]];
    
    if (self.total_pay != nil) {
        
        self.total_pay  = [response objectForKey:@"total_pay"];
        
    }else{
        
        self.total_pay = [NSNumber numberWithInteger:0];
    }
    
    if (self.tender_pay != nil) {
        
        self.tender_pay  = [response objectForKey:@"tender_pay"];
        
    }else{
        
        self.tender_pay = [NSNumber numberWithInteger:0];
    }
    self.payment_mode = [response objectForKey:@"payment_mode"];
    
    return self;
}



@end
