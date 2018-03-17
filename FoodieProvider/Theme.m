//
//  Theme.m
//  FoodieUser
//
//  Created by apple on 9/5/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "Theme.h"
#import "config.h"

@implementation Theme

NSString *const FONT_BLACK = @"Nunito-Black";
NSString *const FONT_BOLD = @"Nunito-Bold";
NSString *const FONT_EXTRABOLD = @"Nunito-ExtraBold";
NSString *const FONT_EXTRALIGHT = @"Nunito-ExtraLight";
NSString *const FONT_LIGHT = @"Nunito-Light";
NSString *const FONT_MEDIUM = @"Nunito-Medium";
NSString *const FONT_REGULAR = @"Nunito-Regular";
NSString *const FONT_SEMIBOLD = @"Nunito-SemiBold";


+(void)foursideBorders:(UIView *)topBorder getBottom: (UIView *)bottomBorder getLeftBorder:(UIView *)leftBorder getRightBorder:(UIView *)rightBoder getWidth:(CGFloat)point getColor:(UIColor *)color{
    
    CALayer * bottomLayerBorder = [CALayer layer];
    bottomLayerBorder.frame = CGRectMake(0.0f, bottomBorder.frame.size.height - point, bottomBorder.frame.size.width, point);
    bottomLayerBorder.backgroundColor =  color.CGColor;
    [bottomBorder.layer addSublayer:bottomLayerBorder];
    
    CALayer * topLayerBorder = [CALayer layer];
    topLayerBorder.frame = CGRectMake(0.0f,0.0f, topBorder.frame.size.width, point);
    topLayerBorder.backgroundColor =  color.CGColor;
    [topBorder.layer addSublayer:topLayerBorder];
    
    CALayer * leftLayerBorder = [CALayer layer];
    leftLayerBorder.frame = CGRectMake(0.0f,0.0f, point,leftBorder.frame.size.height);
    leftLayerBorder.backgroundColor =  color.CGColor;
    [leftBorder.layer addSublayer:leftLayerBorder];
    
    CALayer * rightLayerBorder = [CALayer layer];
    rightLayerBorder.frame = CGRectMake(rightBoder.frame.size.width - point,0, point, rightBoder.frame.size.height);
    rightLayerBorder.backgroundColor =  color.CGColor;
    [rightBoder.layer addSublayer:rightLayerBorder];
}

+ (void)viewShadowDesign:(UIView *)shadowView
{
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    shadowView.layer.shadowRadius = 2;
    shadowView.layer.shadowOpacity = 0.1;
    shadowView.layer.cornerRadius = 2;
    CGRect shadowFrame = shadowView.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    shadowView.layer.shadowPath = shadowPath;
}

+ (void)circleviewDesignwithShadow:(UIView *)shadowView
{
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    shadowView.layer.shadowRadius = 2;
    shadowView.layer.shadowOpacity = 0.2;
    shadowView.layer.cornerRadius = shadowView.frame.size.width/2;

}

+ (void)circleLblDesignwithShadow:(UILabel *)shadowLbl
{
    shadowLbl.clipsToBounds = YES;
    shadowLbl.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowLbl.layer.shadowOffset = CGSizeMake(0, 0);
    shadowLbl.layer.shadowRadius = 2;
    shadowLbl.layer.shadowOpacity = 1;
    shadowLbl.layer.cornerRadius = shadowLbl.frame.size.width/2;
}

+ (void)circleView:(UIView *)cirecleView
{
    
    cirecleView.clipsToBounds = YES;
    cirecleView.layer.cornerRadius = cirecleView.frame.size.width/2;
}

+(void)cornerRadius:(UIView *)forView forLabel:(UILabel *)label fortextfield:(UITextField *)textField forButton:(UIButton *)button{
    
    forView.clipsToBounds = YES;
    forView.layer.cornerRadius = 3;
    
    label.clipsToBounds = YES;
    label.layer.cornerRadius = 3;
    
    textField.clipsToBounds = YES;
    textField.layer.cornerRadius = 3;
    
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 3;
}

+ (void)baseButton:(UIButton *)button
{
    button.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:16];
    button.layer.cornerRadius = 2.0f;
    [button setTitleColor:WHITE forState:UIControlStateNormal];
    [button.titleLabel.text uppercaseString];
    button.clipsToBounds = NO;
    button.backgroundColor = BASECOLOR;
}

+ (void)baseButtonWhite:(UIButton *)button
{
    button.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:16];
    button.layer.cornerRadius = 2.0f;
    [button setTitleColor:BASECOLOR forState:UIControlStateNormal];
    [button.titleLabel.text uppercaseString];
    button.clipsToBounds = NO;
    button.backgroundColor = WHITE;
}

+ (void)header:(UILabel *)label;
{
    label.backgroundColor = [UIColor clearColor];
    label.textColor = BASETEXT;
    [label setFont:[UIFont fontWithName:FONT_BOLD size:22]];
}

+ (void)subHeader:(UILabel *)label
{
    label.backgroundColor = [UIColor clearColor];
    label.textColor = BASETEXT;
    [label setFont:[UIFont fontWithName:FONT_SEMIBOLD size:18]];
}

+ (void)descriptionHeader:(UILabel *)label;
{
    label.backgroundColor = [UIColor clearColor];
    label.textColor = DESCCOLOR;
    [label setFont:[UIFont fontWithName:FONT_REGULAR size:16]];
}

+ (void)fontForTextfield:(UITextField *)textField{
    
    textField.font=[UIFont fontWithName:FONT_SEMIBOLD size:16.0];
    textField.textColor = DESCCOLOR;
    
}

+ (void)fontForTextView:(UITextView *)textView{
    
    textView.font=[UIFont fontWithName:FONT_SEMIBOLD size:14.0];
    textView.textColor = DESCCOLOR;
    
}


+ (void)smallLabel:(UILabel *)label{
    
    label.font=[UIFont fontWithName:FONT_REGULAR size:12.0];
    label.textColor = DESCCOLOR;
    
}

+ (void)genericFontforLabel:(UILabel *)label{
    
    label.font=[UIFont fontWithName:FONT_REGULAR size:14.0];
    
}

+ (void)regularFontlabel:(UILabel *)label
{
    label.backgroundColor = [UIColor clearColor];
    label.textColor = BASETEXT;
    [label setFont:[UIFont fontWithName:FONT_REGULAR size:16]];
}

+ (void)regularSemiBoldFontlabel:(UILabel *)label
{
    label.backgroundColor = [UIColor clearColor];
    label.textColor = BLACK;
    [label setFont:[UIFont fontWithName:FONT_SEMIBOLD size:16]];
}

+ (void)lightFontlabel:(UILabel *)label
{
    label.backgroundColor = [UIColor clearColor];
    label.textColor = BASETEXT;
    [label setFont:[UIFont fontWithName:FONT_LIGHT size:14]];
}

+ (void)chooseFontforlabel:(UILabel *)label font:(NSString *)fontName fontSize:(CGFloat )fontZize
{
    label.backgroundColor = [UIColor clearColor];
    label.textColor = BASETEXT;
    [label setFont:[UIFont fontWithName:fontName size:fontZize]];
}



+ (void)textfieldInfocus:(UITextField *)textField
{
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.font=[UIFont fontWithName:FONT_REGULAR size:16];
    
    textField.textColor = BASECOLOR;
    textField.backgroundColor = [UIColor clearColor];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height - 1, textField.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = RGB(200, 200, 200).CGColor;
    [textField.layer addSublayer:bottomBorder];
}


+ (void)textfieldOutfocus:(UITextField *)textField
{
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.font=[UIFont fontWithName:FONT_REGULAR size:16];
    
    textField.textColor = BASECOLOR;
    textField.backgroundColor = [UIColor clearColor];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height - 1, textField.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = RGB(200, 200, 200).CGColor;
    [textField.layer addSublayer:bottomBorder];
}



+ (void)placeHolder:(UITextField *)textField withPlaceholderString:(NSString *)text
{
    if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)])
    {
        UIColor *color = RGB(211, 211, 211);
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
}

@end
