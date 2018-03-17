//
//  SignInViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/15/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCarrier.h>
#import <Crashlytics/Crashlytics.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "CountryCodeController.h"

@import Firebase;


@interface SignInViewController : GAITrackedViewController <PNObjectEventListener, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *mobileView;
@property (weak, nonatomic) IBOutlet UITextField *mobileTxt;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *taptohide;
@property (strong, nonatomic) UIView * alertView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (strong, nonatomic) FIRRemoteConfig * remoteConfig;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) PubNub *client;
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLbl;
@property (nonatomic, strong) PubNub *pubnub;
@property (nonatomic, strong) NSString *currentChannel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImg;


- (IBAction)signInAction:(id)sender;
- (IBAction)taptohideKeyboard:(id)sender;
- (IBAction)flagAction:(id)sender;

@end
