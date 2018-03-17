//
//  LocationUpdateObj.h
//  FoodieProvider
//
//  Created by APPLE on 10/16/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationUpdateObj : NSObject

@property (nonatomic, strong)AppDelegate * appDelegate;

-(id)initWithLocationUpdate:(NSString *)latitude getLongitute:(NSString *)longitude;


@end
