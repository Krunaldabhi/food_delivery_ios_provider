//
//  MessageObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/4/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "MessageObj.h"

@implementation MessageObj

-(id) initIMessageWithName:(NSString *)name
                   message:(NSString *)message
                      time:(NSString *)time
                      type:(NSString *)type
{
    self = [super init];
    if(self)
    {
        self.userName = name;
        self.userMessage = message;
        self.userTime = time;
        self.messageType = type;
    }
    
    return self;
}

- (id) initWithHistoryMessage:(NSMutableArray *)responseArr{
    
    self.messageArray = [[NSMutableArray alloc]init];
    
    [responseArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj[@"username"] isEqualToString:@"admin"]) {
            
            self.userMessage = obj[@"message"];
            self.messageType = @"admin";

        }
        else if ([obj[@"username"] isEqualToString:@"user"])
        {
            self.userMessage = obj[@"message"];
            self.messageType = @"self";

        }
        [self.messageArray addObject:self];
        
    }];

    return self;
}


@end
