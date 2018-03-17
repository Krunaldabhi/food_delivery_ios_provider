//
//  Reachability.h
//  TechAli
//
//  Created by CSCS on 16/11/15.
//  Copyright © 2015 CSCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface Reachability : NSObject
 +(BOOL)reachabilityForInternetConnection;
@end
