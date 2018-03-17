//
//  CartAddOnObj.h
//  FoodieProvider
//
//  Created by APPLE on 11/24/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddOnObj.h"
#import "AddOnProductObj.h"

@interface CartAddOnObj : NSObject

@property (nonatomic, strong)NSArray * cartArr;
@property (nonatomic, strong)AddOnObj * addOnObj;
@property (nonatomic, strong)NSArray * nameArr;
@property (nonatomic, strong)NSArray * totalAddOnArr;
@property (nonatomic, strong)NSArray * totalAddOnAmountArr;
@property (nonatomic, strong) NSNumber * overallAmnt;
@property (nonatomic, strong) NSNumber * overallwithAddedAmnt;






-(id)initWithCartDictionary:(NSDictionary *)response;

@end
