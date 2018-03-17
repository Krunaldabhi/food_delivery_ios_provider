//
//  Constants.h
//  Truck
//
//  Created by veena on 1/12/17.
//  Copyright © 2017 appoets. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface Constants:UIViewController{
    
}

+(void)setupRemoteConfig;
+(void)fetchRemoteConfig;

@end

#pragma mark - Service URL
#define SERVICE_URL @"https://orderaround.deliveryventure.com/" //New Live URL

//#define SERVICE_URL @"http://foodie.venturedemos.com/"
//#define SERVICE_URL @"http://foodie.appoets.co/"

#define WEB_SOCKET @""

#define Address_URL @"https://maps.googleapis.com/maps/api/geocode/json?"
#define AutoComplete_URL @"https://maps.googleapis.com/maps/api/place/autocomplete/json?"
#define PUBLISH_KEY @"pub-c-f5358316-3562-43d0-abfc-977d1f52de21"
#define SUBSCRIBE_KEY @"sub-c-5032e7b2-a28e-11e7-ab66-06972843ba7e"
#define CHATCHANNEL @"appoets_FoodieCheckChannel"
#define GOOGLE_API_KEY @"AIzaSyCmF29AfgOnRNaEApRsdy1Lm0sMVY4A96k"
#define GMSMAP_KEY @"AIzaSyBKwV2w7uWSf3bpgZeRNbMTBKdRbqnmQew"
#define GMSPLACES_KEY @"AIzaSyBe-77R1y2Z4QnW5EJqVt-E3MwdVFrJIw4"
#define Google_Client_ID @"710279630663-4lgj6e2c98imgiv4t2d6207l3296987e.apps.googleusercontent.com"

#define Stripe_KEY @"pk_test_Sgdyb2qySWsq4MaIZZ6e1TIV"

#define ClientID @"2"

//#define Client_SECRET @"WME1RiBX1k8v44SeOwtpBLyv5jeljeNzuZh56izP" OLD
//#define Client_SECRET @"3y4QW00uAC0uKebQtLvkci6LWTRQmW9RDp7NBzrg" OLD
//#define Client_SECRET @c"vbvEVJuDI56S7fkI0bE2f2rAai7SLZ3QCQNxUpls" // LIVE
#define Client_SECRET @"Xbe0mfn3DZslxO2oReCxvDZEhqHzaBbfHKEywClW" // DEV


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_ZOOMED (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)



//convert latlng to address;
//https://maps.googleapis.com/maps/api/geocode/json?latlng=18.345345,80.4235234&key=AIzaSyD14IIsfUksGaKdKCMfQERAYIkPE8VLOAM

#pragma mark - userdefaults
#pragma mark -

extern NSString *const UD_TOKEN_TYPE;
extern NSString *const UD_ACCESS_TOKEN;
extern NSString *const UD_REFERSH_TOKEN;
extern NSString *const UD_PROFILE_IMG;
extern NSString *const UD_PROFILE_NAME;
extern NSString *const UD_REQUESTID;
extern NSString * CURRENCY;


#pragma mark - Parameters
#pragma mark - --
extern NSString *const PICTURE;



#pragma mark - Parameters
#pragma mark - --   Seque

extern NSString *const LOGIN;
extern NSString *const REGISTER;



#pragma mark - methods
#pragma mark -

extern NSString *const MD_LOGIN;
extern NSString *const MD_VERFYOTP;
extern NSString *const MD_GETVEHICLELIST;
extern NSString *const MD_STARTSHIFT;
extern NSString *const MD_GETSHIFT;
extern NSString *const MD_SHIFTBREAKSTART;
extern NSString *const MD_SHIFTBREAKEND;
extern NSString *const MD_SHIFTEND;
extern NSString *const MD_GETPROFILE;
extern NSString *const MD_UPDATEPROFILE;
extern NSString *const MD_LOCATIONUPDATE;
extern NSString *const MD_GETORDER;
extern NSString *const MD_SENDRATING;
extern NSString *const MD_GETORDERHISTORYLIST;
extern NSString *const MD_GETNOTICEBOARD;
extern NSString *const MD_UPDATESTATUS;
extern NSString *const MD_UPDATELOCATION;
extern NSString *const MD_CHANGEPASSWORD;
extern NSString *const MD_FORGOTPASSWORD;
extern NSString *const MD_RESETPASSWORD;
extern NSString *const MD_COSTCONTROL;
extern NSString *const MD_GETCOUNTRY;
extern NSString *const MD_ADD_TRIP;
extern NSString *const MD_ADD_FAVORITES;
extern NSString *const MD_GET_FAVORITES;
extern NSString *const MD_GET_ROAMING_COST_CONTROL;
extern NSString *const MD_SAVE_ROAMING_COST_CONTROL;
extern NSString *const MD_GET_DAILY_ROAMING_COST_CONTROL;
extern NSString *const MD_SAVE_DAILY_ROAMING_COST_CONTROL;
extern NSString *const MD_UPDATE_ROAMING_COST_CONTROL;
extern NSString *const MD_GET_EXPENSE;
extern NSString *const MD_GET_BUDGET;
extern NSString *const MD_EDIT_EXPENSE;
extern NSString *const MD_LOGOUT;
extern NSString *const MD_GET_PLAN;
extern NSString *const MD_EDIT_PLAN;
extern NSString *const MD_ROAMING_ON_OFF_UPDATE;
extern NSString *const MD_GET_ADVISORY_LIST;
extern NSString *const MD_GET_ADVISORY_RECOMMENDED_LIST;
extern NSString *const MD_GET_PLACE_DETAIL;
extern NSString *const MD_GET_CITY_LIST;
extern NSString *const MD_ADD_BOOKMARK;
extern NSString *const MD_GET_RECOMMENDED_CITY_LIST;
extern NSString *const MD_GET_COUNTRYDETAIL;
extern NSString *const MD_EDIT_BUDGET;
extern NSString *const MD_SEND_FEEDBACK;
extern NSString *const MD_TRANPORTER_REQUEST_ORDER;


