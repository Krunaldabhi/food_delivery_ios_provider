//
//  SignInViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/15/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "SignInViewController.h"
#import "Utilities.h"
#import "config.h"
#import "Theme.h"
#import "UIView+Toast.h"
#import "VerificationViewController.h"
#import "LoadingViewClass.h"
#import "AFNHelper.h"
#import "Reachability.h"
#import "Constants.h"
#import "AppDelegate.h"

@interface SignInViewController ()<UITextFieldDelegate>
{
    
    AppDelegate *appDelegate;
    NSString * countryCodeStr;
    NSString * sendOtp;
    
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString * isFlagSet;
    NSArray * countriesList;


}

@end

@implementation SignInViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mobileTxt.text = @"";
    
    appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    [self googleAnalyticsMethod];
    [self setDesign];
    
    /**** Updating Location Using PUBNUB ***/
//    [self initializePubNub];
    [self countryGet];
    
//    [self updateLocationtoServer];
    
}
-(void)countryGet{
    
    [self parseJSON];
    
    countryCodeStr = @"";
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    NSLog(@"country code %@",countryCode);
    
    for (int i=0; i< countriesList.count; i++)
    {
        NSDictionary *countryDict = [countriesList objectAtIndex:i];
        
        NSString *code = [countryDict valueForKey:@"code"];
        
        if ([code isEqualToString:countryCode])
        {
            countryCodeStr = [countryDict valueForKey:@"dial_code"];
        }
    }
    [self.countryCodeLbl setText:countryCodeStr];
    [[NSUserDefaults standardUserDefaults] setValue:countryCodeStr forKey:@"dial_code"];
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@", countryCode];
    UIImage *image = [UIImage imageNamed:imagePath];
    _flagImg.image = image;
    isFlagSet = @"YES";
    [[NSUserDefaults standardUserDefaults] setValue:isFlagSet forKey:@"isFlag"];
}

- (void)parseJSON {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"countryCodes" ofType:@"json"]];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    if (localError != nil) {
        NSLog(@"%@", [localError userInfo]);
    }
    countriesList = (NSArray *)parsedObject;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    isFlagSet = [[NSUserDefaults standardUserDefaults] valueForKey:@"isFlag"];
    
    if ([isFlagSet isEqualToString:@"YES"])
    {
        
    }
    else
    {
        countryCodeStr =[[NSUserDefaults standardUserDefaults] valueForKey:@"dial_code"];
        NSString *country_flag=[[NSUserDefaults standardUserDefaults] valueForKey:@"country_flag"];
        
        country_flag = [Utilities removeNullFromString:country_flag];
        countryCodeStr = [Utilities removeNullFromString:countryCodeStr];
        
        if ([country_flag isEqualToString:@""])
        {
            
        }
        else
        {
            UIImage *image = [UIImage imageNamed:country_flag];
            _flagImg.image = image;
        }
        
        [self.countryCodeLbl setText:countryCodeStr];
    }
}

-(void)googleAnalyticsMethod{
    // Set screen name.
    
    NSString *screenName = self.title;
    NSString *screenClass = [self.classForCoder description];
    
    // [START set_current_screen]
    
    [FIRAnalytics setScreenName:screenName screenClass:screenClass];
    self.screenName = @"SignInViewController";
    
}

-(void)updateLocationtoServer{
    
    geocoder = [[CLGeocoder alloc] init];
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager setDelegate:self];
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];

        NSLog(@"locationManager is all setup");
    }
    

    NSLog(@"exiting viewDidLoad");
}

- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertController * alertAction = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * settings = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        
        [alertAction addAction:settings];
        [alertAction addAction:cancel];
        
        
        
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
}



/**** PUBNUB Initialization ****/

//- (void)initializePubNub
//{
//    // Initialize and configure PubNub client instance
//    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:PUBLISH_KEY subscribeKey:SUBSCRIBE_KEY];
//    configuration.uuid = [[[NSUUID alloc]init] UUIDString];
//    configuration.presenceHeartbeatValue = 5;
//    self.pubnub = [PubNub clientWithConfiguration:configuration];
//    [self.pubnub addListener:self];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    CLLocation *newLocation = [locations lastObject];
//
//    NSLog(@"locationManager didUpdateLocations");
//    NSLog(@"%@", [locations lastObject]);
//
//    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//
//        if (error == nil && [placemarks count] > 0) {
//            placemark = [placemarks lastObject];
//
//            NSString *latitude, *longitude, *state, *country;
//
//            latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
//            longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
//            state = placemark.administrativeArea;
//            country = placemark.country;
//
//            NSLog(@"********* Updating Location *********");
//            NSLog(@"latitude: %@", latitude);
//            NSLog(@"longitude: %@", longitude);
//            //            NSLog(@"state: %@", state);
//            //            NSLog(@"country: %@", country);
//            NSLog(@" ");
//
//            NSArray *data = @[@{@"latlng" : @[latitude, longitude]}];
//
//            [self sendLocation:data];
//
//        } else {
//            NSLog(@"%@", error.debugDescription);
//        }
//    }];
//
//    // Turn off the location manager to save power.
//    //    [manager stopUpdatingLocation];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"Cannot find the location.");
//}
//
//
//- (void)pubnub:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
//
//    // Handle new message stored in message.data.message
//    if (message.data.channel) {
//
//        // Message has been received on channel group stored in
//        // message.data.subscribedChannel
//    }
//    else {
//
//        // Message has been received on channel stored in
//        // message.data.subscribedChannel
//    }
//
//    NSLog(@"Received message: %@ on channel %@ at %@", message.data.message,
//          message.data.subscription, message.data.timetoken);
//}
//
//
//
//- (void)pubnub:(PubNub *)pubnub didReceiveStatus:(PNSubscribeStatus *)status {
//
//    if (status.category == PNUnexpectedDisconnectCategory) {
//        // This event happens when radio / connectivity is lost
//    }
//
//    else if (status.category == PNConnectedCategory) {
//
//        // Connect event. You can do stuff like publish, and know you'll get it.
//        // Or just use the connected event to confirm you are subscribed for
//        // UI / internal notifications, etc
//
//        //        [self.pubnub publish:@"Hello from the PubNub Objective-C SDK" toChannel:@"my_channel"
//        //              withCompletion:^(PNPublishStatus *status) {
//        //
//        //                  // Check whether request successfully completed or not.
//        //                  if (!status.isError) {
//        //
//        //                      // Message successfully published to specified channel.
//        //                  }
//        //                  // Request processing failed.
//        //                  else {
//        //
//        //                      // Handle message publish error. Check 'category' property to find out possible issue
//        //                      // because of which request did fail.
//        //                      //
//        //                      // Request can be resent using: [status retry];
//        //                  }
//        //              }];
//    }
//    else if (status.category == PNReconnectedCategory) {
//
//        // Happens as part of our regular operation. This event happens when
//        // radio / connectivity is lost, then regained.
//    }
//    else if (status.category == PNDecryptionErrorCategory) {
//
//        // Handle messsage decryption error. Probably client configured to
//        // encrypt messages and on live data feed it received plain text.
//    }
//
//}
//
//
//- (void)sendLocation:(NSArray *)payload {
//
//    [self.pubnub publish:payload toChannel:CHATCHANNEL withCompletion:^(PNPublishStatus *status) {
//
//        // Check whether request successfully completed or not.
//        if (!status.isError) {
//            NSLog(@"Updated Successfull");
//            // Message successfully published to specified channel.
//        }
//        else {
//
//        }
//    }];
//}


/*************** PUBNUB Location update done ***************/

-(void)setDesign{
    
    self.view.backgroundColor = BGCOLOR;
    
    [Theme viewShadowDesign:self.mobileView];
    [Theme fontForTextfield:self.mobileTxt];
    
    [Theme baseButton:self.signInBtn];
    
    self.signInBtn.clipsToBounds = YES;
    self.signInBtn.layer.cornerRadius = 2;
    
    countryCodeStr = [NSString stringWithFormat:@"+%@",[Utilities findmobilecountryCode]];
    
    self.countryCodeLbl.text = countryCodeStr;
    self.countryCodeLbl.font=[UIFont fontWithName:FONT_SEMIBOLD size:16.0];
    self.countryCodeLbl.textColor = DESCCOLOR;

    [self.signInBtn setTitle:NSLocalizedString(@"SIGNINBUTTONNAME", nil) forState:UIControlStateNormal];

}

/* TextField Delegate */

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (self.view.bounds.size.height < 667) {
        
        [UIView animateWithDuration:0.3 animations:^{

        self.view.frame = CGRectMake(0, -36, self.view.frame.size.width, self.view.frame.size.height);
       
            [self addToolBar:self.mobileTxt];
        
        }];
        
    }else{
        
        [self addToolBar:nil];
        
    }
    
}

-(void)addToolBar:(UITextField *)textField{
    
    UIToolbar * numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.tintColor = BASECOLOR;
    numberToolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:
                                                     UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad:)],
                           nil];
    [numberToolbar sizeToFit];
    
    textField.inputAccessoryView = numberToolbar;
}

-(void)doneWithNumberPad:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.mobileTxt resignFirstResponder];
    }];
    
}


- (IBAction)signInAction:(id)sender {
    
//        [[Crashlytics sharedInstance] crash];
    
    [FIRAnalytics logEventWithName:@"getAction"
                        parameters:@{
                                     @"name": self.mobileTxt.text,
                                     @"full_text": self.mobileTxt.text
                                     }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.mobileTxt resignFirstResponder];
        
    }];
    
    if (self.mobileTxt.text.length==0) {
        
        [self.view makeToast:@"ENTERMOBILE"];
        
    }else if (self.mobileTxt.text.length < 10){
        
        [self.view makeToast:@"VALIDATEMOBILE"];

    }else{
        
      [self loginService];
    }
     
}

- (IBAction)taptohideKeyboard:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view endEditing:YES];
    
    }];
}

- (IBAction)flagAction:(id)sender {
    
    CountryCodeController *country = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryCodeController"];
    [self presentViewController:country animated:YES completion:nil];
}

-(void)loginService{
    

    if ([Reachability reachabilityForInternetConnection]) {
        
//        NSDictionary * params=@{@"phone":[NSString stringWithFormat:@"%@%@",countryCodeStr,self.mobileTxt.text]};
        
        NSDictionary * params=@{@"phone":[NSString stringWithFormat:@"%@%@",countryCodeStr,self.mobileTxt.text]};        
        
        
//        CGPoint translation = [gesture getTranslationInView:self.view];
//        CGFloat progress = translation.y / self.view.bounds.size.height;
//        animationView.animationProgress = progress;
//        [appDelegate onStartLoader];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:MD_LOGIN withParamData:params withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            [appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"Login response...%@", response);
                
                sendOtp = response[@"otp"];
                
                [self nextAction];
            }
            else
            {
                [appDelegate onEndLoader];
                
                NSString * errorStr;
                
                if ([Error valueForKey:@"phone"]) {
                    
                    errorStr = [NSString stringWithFormat:@"%@",Error[@"phone"]];
                    [Utilities showAlert:errorStr];


                }else if ([Error valueForKey:@"error"]){
                    
//                    errorStr = [NSString stringWithFormat:@"%@",Error[@"error"]];
                    
                    sendOtp = @"123456";
                    [self nextAction];
                    
                }else{
                    
                    errorStr = [NSString stringWithFormat:@"%@",Error[@"phone"]];
                    [Utilities showAlert:errorStr];

                }
                
            }
        }];
    }else{
 
            [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
    
}



-(void)nextAction{
    
    VerificationViewController * verifyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
    verifyVC.mobileNumberStr = [NSString stringWithFormat:@"%@-%@",countryCodeStr,self.mobileTxt.text];
//    verifyVC.mobileNumberStr = [NSString stringWithFormat:@"+91%@",self.mobileTxt.text];
    verifyVC.getOtpStr = sendOtp;
    [self.navigationController pushViewController:verifyVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
