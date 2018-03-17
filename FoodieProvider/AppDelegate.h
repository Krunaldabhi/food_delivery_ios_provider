//
//  AppDelegate.h
//  FoodieProvider
//
//  Created by apple on 9/6/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PubNub/PubNub.h>
#import <CoreData/CoreData.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "LoadingViewClass.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "Constants.h"
#import <CoreLocation/CoreLocation.h>

@import Firebase;


@interface AppDelegate : UIResponder <UIApplicationDelegate, PNObjectEventListener, CLLocationManagerDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (copy, nonatomic) NSString * latitude;
@property (copy, nonatomic) NSString * longitude;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) PubNub *client;
@property (nonatomic, strong) NSMutableArray * messagesArr;
@property (nonatomic, copy) NSString * checkStatusStr;

@property (nonatomic, strong) NSString * deviceToken;
@property (nonatomic, strong) NSString * deviceIdStr;
@property (nonatomic, strong) NSString * deviceType;

@property (nonatomic, strong) NSString * notificationString;





- (void)saveContext;

-(void)onStartLoader;
-(void)onEndLoader;

- (PubNub *)enterChannel:(NSString *)channel;

- (void)leaveChannel:(NSString *)channel;

- (void)getMessagesFromHistory;


@end

