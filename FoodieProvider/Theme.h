//
//  Theme.h
//  FoodieUser
//
//  Created by apple on 9/5/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "config.h"

@interface Theme : NSObject

extern NSString *const FONT_BLACK;
extern NSString *const FONT_BOLD;
extern NSString *const FONT_EXTRABOLD;
extern NSString *const FONT_EXTRALIGHT;
extern NSString *const FONT_LIGHT;
extern NSString *const FONT_MEDIUM;
extern NSString *const FONT_REGULAR;
extern NSString *const FONT_SEMIBOLD;

+ (void)lightFontlabel:(UILabel *)label;

+ (void)regularSemiBoldFontlabel:(UILabel *)label;

+ (void)fontForTextView:(UITextView *)textView;

+ (void)genericFontforLabel:(UILabel *)label;

+ (void)circleviewDesignwithShadow:(UIView *)shadowView;

+ (void)circleLblDesignwithShadow:(UILabel *)shadowLbl;

+ (void)viewShadowDesign:(UIView *)shadowView;

+ (void)baseButton:(UIButton *)button;

+ (void)baseButtonWhite:(UIButton *)button;

+ (void)header:(UILabel *)label;

+ (void)subHeader:(UILabel *)label;

+ (void)chooseFontforlabel:(UILabel *)label font:(NSString *)fontName fontSize:(CGFloat )fontZize;


+ (void)regularFontlabel:(UILabel *)label;

+ (void)circleView:(UIView *)cirecleView;

+ (void)descriptionHeader:(UILabel *)label;

+ (void)smallLabel:(UILabel *)label;

+ (void)textfieldInfocus:(UITextField *)textField;

+ (void)textfieldOutfocus:(UITextField *)textField;

+ (void)placeHolder:(UITextField *)textField withPlaceholderString:(NSString *)text;

+ (void)fontForTextfield:(UITextField *)textField;

+(void)cornerRadius:(UIView *)forView forLabel:(UILabel *)label fortextfield:(UITextField *)textField forButton:(UIButton *)button;

+(void)foursideBorders:(UIView *)topBorder getBottom: (UIView *)bottomBorder getLeftBorder:(UIView *)leftBorder getRightBorder:(UIView *)rightBoder getWidth:(CGFloat)point getColor:(UIColor *)color;

@end
