//
//  InvoiceObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/6/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvoiceObj : NSObject

@property (nonatomic , strong)NSNumber * invoiceIdStr;
@property (nonatomic , strong)NSNumber * order_id;
@property (nonatomic , strong)NSNumber * quantity;
@property (nonatomic , strong)NSNumber * paid;
@property (nonatomic , strong)NSNumber * gross;
@property (nonatomic , strong)NSNumber * discount;
@property (nonatomic , strong)NSNumber * delivery_charge;
@property (nonatomic , strong)NSNumber * tax;
@property (nonatomic , strong)NSNumber * net;
@property (nonatomic , strong)NSNumber * total_pay;
@property (nonatomic , strong)NSNumber * tender_pay;
@property (nonatomic , strong)NSNumber * payable;
@property (nonatomic , strong)NSNumber * wallet_amount;
@property (nonatomic , strong)NSString * payment_mode;

-(id)initWithInvoiceDictionary:(NSDictionary *)response;


@end
