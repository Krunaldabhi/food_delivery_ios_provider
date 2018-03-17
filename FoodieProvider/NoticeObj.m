//
//  NoticeObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/14/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "NoticeObj.h"

@implementation NoticeObj

-(id)initWithNoticeData:(NSDictionary *)response{
    
    self.noticeid = [response objectForKey:@"id"];
    self.title = [response objectForKey:@"title"];
    self.notice = [response objectForKey:@"notice"];
    self.note = [response objectForKey:@"note"];
    self.created_at = [response objectForKey:@"created_at"];
    
    return self;
}

@end
