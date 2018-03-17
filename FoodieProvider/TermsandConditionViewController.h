//
//  TermsandConditionViewController.h
//  FoodieProvider
//
//  Created by APPLE on 10/17/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsandConditionViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *closeImg;
@property (strong, nonatomic) IBOutlet UIButton *closeAction;
@property (strong, nonatomic) IBOutlet UIWebView *webPageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


- (IBAction)closeFunction:(id)sender;

@end
