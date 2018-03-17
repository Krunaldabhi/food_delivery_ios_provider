//
//  Constants.m
//  Truck
//
//  Created by veena on 1/12/17.
//  Copyright © 2017 appoets. All rights reserved.
//
//

#import "Constants.h"

@implementation Constants

+(void)setupRemoteConfig{
    
    //    self.remoteConfig = [FIRRemoteConfig remoteConfig];
    
    [[FIRRemoteConfig remoteConfig]setDefaultsFromPlistFileName:@"ProviderDefaultsRemoteConfig"];
    
    NSLog(@"Last fetched time ---> %@ ",[FIRRemoteConfig remoteConfig].lastFetchTime);
    NSString * getString = [[FIRRemoteConfig remoteConfig] configValueForKey:@"baseurl"].stringValue;
    NSLog(@"Here is the String----->%@",getString);
    
}

+(void)enableDeveloperMode{
    
    FIRRemoteConfigSettings * configureSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:YES];
    [FIRRemoteConfig remoteConfig].configSettings = configureSettings;
}

+(void)fetchRemoteConfig{
    
    NSTimeInterval expirationTime;
    
#ifdef DEBUG
    
    expirationTime = 0;
    [self enableDeveloperMode];
    
#else
    expirationTime = 43200.0;
    
#endif
    
    [[FIRRemoteConfig remoteConfig] fetchWithExpirationDuration:expirationTime completionHandler:^(FIRRemoteConfigFetchStatus status, NSError * _Nullable error) {
        if (error == nil) {
            [[FIRRemoteConfig remoteConfig]activateFetched];
            
            NSString * getString = [[FIRRemoteConfig remoteConfig] objectForKeyedSubscript:@"baseurl"].stringValue;
            NSLog(@"Here is the String----->%@",getString);
            
        }else{
            
            
        }
    }];
}

@end

//NSString *const PICTURE=@"picture"; //
NSString *const PICTURE=@"avatar"; //


#pragma mark - userdefaults
#pragma mark -
NSString *const UD_TOKEN_TYPE =@"token_type";
NSString *const UD_ACCESS_TOKEN =@"access_token";
NSString *const UD_REFERSH_TOKEN =@"ref_token";
NSString *const UD_PROFILE_IMG =@"profile_img";
NSString *const UD_PROFILE_NAME =@"profile_name";
NSString *const UD_REQUESTID=@"request_id";

#pragma mark - Parameters
#pragma mark - --   Seque

NSString *const LOGIN=@"segLogin";
NSString *const REGISTER=@"segRegister";

NSString *const MD_LOGIN = @"api/transporter/login";
NSString *const MD_VERFYOTP =@"api/transporter/verify/otp";
NSString *const MD_GETVEHICLELIST =@"api/transporter/vehicles";
NSString *const MD_STARTSHIFT =@"api/transporter/shift";
NSString *const MD_GETSHIFT =@"api/transporter/shift";
NSString *const MD_SHIFTBREAKSTART =@"/api/transporter/shift/timing";
NSString *const MD_SHIFTBREAKEND = @"/api/transporter/shift/timing";
NSString *const MD_SHIFTEND = @"api/transporter/shift";
NSString *const MD_GETPROFILE =@"/api/transporter/profile";
NSString *const MD_UPDATEPROFILE =@"api/transporter/profile";
NSString *const MD_LOCATIONUPDATE =@"api/transporter/profile/location";
NSString *const MD_TRANPORTER_REQUEST_ORDER =@"api/transporter/request/order";

NSString *const MD_UPDATESTATUS =@"api/transporter/order/";
NSString *const MD_GETORDER =@"api/transporter/order";
NSString *const MD_SENDRATING =@"api/transporter/rating";
NSString *const MD_GETORDERHISTORYLIST =@"api/transporter/history";
NSString *const MD_LOGOUT =@"api/transporter/logout";
NSString *const MD_GETNOTICEBOARD =@"api/transporter/notice";
NSString *const MD_RESETPASSWORD =@"api/user/reset/password";
NSString *const MD_GETCOSTCONTROL =@"api/user/costcontrol";
NSString *const MD_COSTCONTROL =@"api/user/costcontrol";
NSString *const MD_GETCOUNTRY =@"api/user/country";
NSString *const MD_ADD_TRIP =@"api/user/trip";
NSString *const MD_ADD_FAVORITES =@"api/user/trip/update/favourite";
NSString *const MD_GET_FAVORITES =@"api/user/trip/show/favourite";
NSString *const MD_GET_ROAMING_COST_CONTROL =@"api/user/rcc";
NSString *const MD_SAVE_ROAMING_COST_CONTROL =@"api/user/rcc/save";
NSString *const MD_GET_DAILY_ROAMING_COST_CONTROL =@"api/user/rcc/show/usage";
NSString *const MD_SAVE_DAILY_ROAMING_COST_CONTROL =@"api/user/rcc/usage";
NSString *const MD_UPDATE_ROAMING_COST_CONTROL =@"api/user/rcc/update";
NSString *const MD_ROAMING_ON_OFF_UPDATE =@"api/user/rcc/onoff";
NSString *const MD_GET_EXPENSE =@"api/user/expense";
NSString *const MD_GET_BUDGET =@"api/user/expenses/sum";
NSString *const MD_EDIT_BUDGET =@"api/user/budget/update";
NSString *const MD_EDIT_EXPENSE =@"api/user/expense/update";
NSString *const MD_GET_PLAN =@"api/user/plan";
NSString *const MD_EDIT_PLAN =@"api/user/plan/update";
NSString *const MD_GET_ADVISORY_LIST =@"api/user/advise";
NSString *const MD_GET_ADVISORY_RECOMMENDED_LIST =@"api/user/recommended";
NSString *const MD_GET_PLACE_DETAIL =@"api/user/place";
NSString *const MD_GET_CITY_LIST =@"api/user/city";
NSString *const MD_GET_RECOMMENDED_CITY_LIST =@"api/user/recommended/city";
NSString *const MD_ADD_BOOKMARK =@"api/user/bookmark";
NSString *const MD_GET_COUNTRYDETAIL =@"api/user/country/details";
NSString *const MD_SEND_FEEDBACK =@"api/user/feedback";

/* Currency is declared in shift status VC from profile service */

NSString * CURRENCY = @"";



