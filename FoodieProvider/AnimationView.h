//
//  AnimationView.h
//  FoodieUser
//
//  Created by APPLE on 9/9/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimationView : NSObject

+ (void)animationFromBottom:(UIView *)view;

+ (void)animationFromLeft:(UIView *)view;

+ (void)animateBottomUp:(UIView *)view;

+(void)alertViewAnimation:(UIView *)animateView bgView:(UIView *)backGroundView;

+(void)closePopUp:(UIView *)animateView bgView:(UIView *)backGroundView;

@end
