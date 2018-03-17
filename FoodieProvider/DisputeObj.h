//
//  DisputeObj.h
//  FoodieProvider
//
//  Created by APPLE on 11/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisputeObj : NSObject

@property (nonatomic , strong)NSNumber * disputeIdStr;
@property (nonatomic , strong)NSString * phone;


-(id)initWithDisputeDictionary:(NSDictionary *)response;

@end
