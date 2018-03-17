//
//  LiveTaskObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductObj.h"
#import "AddressObj.h"
#import "ShopObj.h"
#import "ItemsObj.h"
#import "UserDetailsObj.h"
#import "ItemsObj.h"
#import "InvoiceObj.h"
#import "Orders.h"
#import "TransporterObj.h"
#import "DisputeObj.h"

@interface LiveTaskObj : NSObject

@property (nonatomic , strong)NSNumber * orderIdStr;
@property (nonatomic , strong)NSString * route_key;
@property (nonatomic , strong)NSString * dispute;
@property (nonatomic , strong)NSString * status;
@property (nonatomic , strong)NSString * created_at;

@property (nonatomic, strong)NSArray * itemsArray;
@property (nonatomic, strong)NSArray * ordersArr;


@property (nonatomic , strong)ProductObj * productObj;
@property (nonatomic , strong)AddressObj * addressObj;
@property (nonatomic , strong)ShopObj * shopObj;
@property (nonatomic , strong)ItemsObj * itemObj;
@property (nonatomic , strong)UserDetailsObj * userDetailsObj;
@property (nonatomic , strong)InvoiceObj * invoiceObj;
@property (nonatomic , strong)Orders * orderObj;
@property (nonatomic , strong)TransporterObj * transporterObj;
@property (nonatomic , strong)DisputeObj * disputeObj;





-(id)initWithDictionary:(NSDictionary *)response;

@end
