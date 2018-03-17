//
//  NoticeObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/14/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeObj : NSObject

@property (nonatomic , strong)NSNumber * noticeid;
@property (nonatomic , strong)NSString * title;
@property (nonatomic , strong)NSString * notice;
@property (nonatomic , strong)NSString * note;
@property (nonatomic , strong)NSString * created_at;

-(id)initWithNoticeData:(NSDictionary *)response;

@end
