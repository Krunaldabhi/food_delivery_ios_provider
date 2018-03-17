//
//  WebService.m
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "WebService.h"

@implementation WebService

+ (instancetype)shared{
    static id instance_ = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance_ = [[self alloc] init];
    });
    
    return instance_;
}

- (void)startSendPresence {
    
    [self sendPresence:nil]; //to make the first webservice call without waiting for timer to trigger
    
    if(!self.presenceTimer){
        
//        self.presenceTimer = [NSTimer scheduledTimerWithTimeInterval:self.presenceTimerInterval target:self selector:@selector(sendPresence:) userInfo:nil repeats:YES];
    }
}

- (void)sendPresence:(NSTimer *)timer {
    //make your web service call here to hit server
}

- (void)stopSendPresence {
    [self.presenceTimer invalidate];
    self.presenceTimer = nil;
}



@end
