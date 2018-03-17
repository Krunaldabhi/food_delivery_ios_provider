//
//  Orders.h
//  FoodieProvider
//
//  Created by APPLE on 10/9/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Orders : NSObject

@property (nonatomic , strong)NSNumber * IdStr;
@property (nonatomic , strong)NSNumber * order_id;
@property (nonatomic , strong)NSString * status;
@property (nonatomic , strong)NSString * created_at;
@property (nonatomic , strong)NSString * updated_at;

//-(id)initWithOrderDictionary:(NSDictionary *)response;


@end
