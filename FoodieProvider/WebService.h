//
//  WebService.h
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject
@property (strong, nonatomic) NSTimer *presenceTimer;

+ (instancetype)shared;
- (void)startSendPresence;
- (void)stopSendPresence;

@end
