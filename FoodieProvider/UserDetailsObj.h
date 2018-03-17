//
//  UserDetailsObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetailsObj : NSObject

@property (nonatomic , assign)NSNumber * userIdStr;
@property (nonatomic , strong)NSString * name;
@property (nonatomic , strong)NSString * email;
@property (nonatomic , strong)NSString * phone;
@property (nonatomic , strong)NSString * avatar;

-(id)initWithUserDictionary:(NSDictionary *)response;

@end
