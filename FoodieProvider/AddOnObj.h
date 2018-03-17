//
//  AddOnObj.h
//  FoodieProvider
//
//  Created by APPLE on 11/24/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddOnProductObj.h"

@interface AddOnObj : NSObject



@property (nonatomic , strong)NSNumber * addOnid;
@property (nonatomic , strong)NSNumber * quantity;
@property (nonatomic, strong) NSNumber * overallAmnt;
@property (nonatomic, strong) NSArray * addOnTotalAmountArr;

@property (nonatomic , strong)AddOnProductObj * addOnProductObj;

-(id)initWithAddonDictionary:(NSDictionary *)response;


@end
