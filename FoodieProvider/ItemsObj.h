//
//  ItemsObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductObj.h"
#import "CartAddOnObj.h"

@interface ItemsObj : NSObject

@property (nonatomic , strong)NSArray * ItemsArr;
@property (nonatomic , strong)NSNumber * itemIdStr;
@property (nonatomic , strong)NSNumber * quantity;
@property (nonatomic , strong)ProductObj * productObj;
@property (nonatomic , strong)CartAddOnObj * cartObj;


@end

