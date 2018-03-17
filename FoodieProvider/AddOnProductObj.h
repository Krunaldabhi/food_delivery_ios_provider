//
//  AddOnProductObj.h
//  FoodieProvider
//
//  Created by APPLE on 11/24/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddOnProductObj : NSObject

@property (strong, nonatomic) NSNumber *addon_id;
@property (strong, nonatomic) NSNumber *product_id;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *add_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *shop_id;
@property (strong, nonatomic) NSMutableArray * nameArr;



-(id)initWithAddOnProductDictionary:(NSDictionary *)response;

@end
