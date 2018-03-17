//
//  AppDelegate.m
//  FoodieProvider
//
//  Created by apple on 9/6/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "AppDelegate.h"
#import "ShiftStatusViewController.h"
#import "SignInViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>
{
    LoadingViewClass *loader;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

// Stores reference on PubNub client to make sure what it won't be released.
@property (nonatomic, strong) PubNub *pubnub;
@property (nonatomic, strong) NSString *currentChannel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*** FireBase and Fabric Configuration ***/
    
    [FIRApp configure];
    [Fabric with:@[[Crashlytics class]]];
    
    /*** Remote Configuration ***/
    
    [Constants setupRemoteConfig];
    [Constants fetchRemoteConfig];

    /*** Analytics Configuration ***/
    
    GAI *gai = [GAI sharedInstance];
    [gai trackerWithTrackingId:@"UA-106922258-1"];
    gai.trackUncaughtExceptions = YES;
    gai.logger.logLevel = kGAILogLevelVerbose;
    
    /*** PUBNUB Configuration ***/
    
    [self initializePubNub];
    self.messagesArr = [[NSMutableArray alloc]init];
    
    /**** Class Configurations ****/
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    self.checkStatusStr = [userDefaults objectForKey:@"ShiftStatus"];

    if ([self.checkStatusStr isEqualToString:@"Start"]) {

        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

        ShiftStatusViewController * shiftVC = [storyBoard instantiateViewControllerWithIdentifier:@"ShiftStatusViewController"];
        UINavigationController * navFirstView = [[UINavigationController alloc]initWithRootViewController:shiftVC];
        navFirstView.navigationBarHidden = YES;
        self.window.rootViewController = navFirstView;
        [self.window makeKeyAndVisible];
        
    }else{
        
        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        SignInViewController * signINVC = [storyBoard instantiateViewControllerWithIdentifier:@"SignInViewController"];
        UINavigationController * navFirstView = [[UINavigationController alloc]initWithRootViewController:signINVC];
        navFirstView.navigationBarHidden = YES;
        self.window.rootViewController = navFirstView;
        [self.window makeKeyAndVisible];
        
    }
    
    /***** USERNOTIFICATION (PUSH NOTIFICATION) ********/
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;

    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted == YES) {
                
                self.notificationString = @"1";
                
            }else{
                
                self.notificationString = @"0";
                
            }
        }];
#endif
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    UIDevice *device = [UIDevice currentDevice];
    
    _deviceIdStr = [[device identifierForVendor]UUIDString];
    
    NSLog(@"DEVICE ID----> %@",_deviceIdStr);
    
    _deviceType = @"ios";
    
    /*** LOCATION IDENTIFIER***/

    [self getCurrentLocation:application];
    
    return YES;
}

-(void)getCurrentLocation:(UIApplication *)application{
    
    self.locationManager = [[CLLocationManager alloc] init];
    //set delegate
    self.locationManager.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    // This is the most important property to set for the manager. It ultimately determines how the manager will
    // attempt to acquire location and thus, the amount of power that will be consumed.
    
    if ([self.locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)]) {
        [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    }
    self.locationManager.desiredAccuracy = 45;
    self.locationManager.distanceFilter = 100;
    // Once configured, the location manager must be "started".
    [self.locationManager startUpdatingLocation];
    
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{

    _deviceToken = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    _deviceToken = [_deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"Device Token---%@", _deviceToken);
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_deviceToken forKey:@"device_token"];
    [defaults synchronize];
    
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    
    NSString * string = notification.request.content.body;
    
//    NSString * stringS = notification.request.content.shouldAlwaysAlertWhileAppIsForeground;
    
    if (string != nil) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMessage" object:self];
        
    }
    NSLog(@"User Info : %@",notification.request.content.userInfo);

    NSLog(@"User Info response : %@",notification.request);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);

}


//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMessage" object:self];
    
    NSString * string = response.notification.request.content.body;
    
    if (string != nil) {

        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getProfileService" object:nil];

        LiveTaskViewController * signINVC = [storyBoard instantiateViewControllerWithIdentifier:@"LiveTaskViewController"];
        UINavigationController * navFirstView = [[UINavigationController alloc]initWithRootViewController:signINVC];
        navFirstView.navigationBarHidden = YES;
        self.window.rootViewController = navFirstView;
        self.notificationString = @"1";
        [self.window makeKeyAndVisible];
    }
    
    NSLog(@"User Info : %@",response.notification.request.content.userInfo);
//    NSLog(@"User Info response : %@",notification.request);

    completionHandler();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    
    
    [self.locationManager stopUpdatingLocation];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    [self.locationManager startUpdatingLocation];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.locationManager stopUpdatingLocation];
    
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:10.0
                                                      target:self
                                                    selector:@selector(startTrackingBg)
                                                    userInfo:nil
                                                     repeats:YES];
    
    
}

-(void)startTrackingBg {
    
    [self.locationManager startUpdatingLocation];
    
    LocationUpdateObj * locationObj = [[LocationUpdateObj alloc]initWithLocationUpdate:self.latitude getLongitute:self.longitude];
    
    NSLog(@"Your background app Latitude and longitude is %@",locationObj);
    
    NSLog(@"App is running in background");
}

//starts automatically with locationManager


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    self.latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    NSLog(@"Location: %f, %f",newLocation.coordinate.longitude, newLocation.coordinate.latitude);
    

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    


}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [NSTimer scheduledTimerWithTimeInterval:10.0
                                     target:self
                                   selector:@selector(updateLocation)
                                   userInfo:nil
                                    repeats:YES];

}

-(void)updateLocation{
    
    LocationUpdateObj * locationObj = [[LocationUpdateObj alloc]initWithLocationUpdate:self.latitude getLongitute:self.longitude];
    NSLog(@"your loaction update%@",locationObj);
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


-(void)onStartLoader
{
    loader = [LoadingViewClass new];
    [loader startLoading];
    
}
-(void)onEndLoader
{
    [loader stopLoading];
}



/**** PUBNUB Initialization ****/

- (void)initializePubNub
{
    // Initialize and configure PubNub client instance
    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:PUBLISH_KEY subscribeKey:SUBSCRIBE_KEY];
    configuration.uuid = [[[NSUUID alloc]init] UUIDString];
    configuration.presenceHeartbeatValue = 5;
    self.pubnub = [PubNub clientWithConfiguration:configuration];
    [self.pubnub addListener:self];
}

- (PubNub *)enterChannel:(NSString *)channel
{
    [self.pubnub subscribeToChannels:@[channel] withPresence:YES];
    [self.pubnub subscribeToPresenceChannels:@[channel]];
    
    _currentChannel = channel;
    
    return self.pubnub;
}

//Leave Channel
- (void)leaveChannel:(NSString *)channel
{
    [self.pubnub unsubscribeFromChannels:@[channel] withPresence:YES];
    _currentChannel = channel;
}

- (void)getMessagesFromHistory
{
    
    [self.pubnub historyForChannel:CHATCHANNEL start:nil end:nil limit:50 reverse:NO withCompletion:^(PNHistoryResult * _Nullable result, PNErrorStatus * _Nullable status) {
        
        self.messagesArr = [NSMutableArray arrayWithArray:result.data.messages];
        
        if (self.messagesArr.count != 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadHistory" object:self.messagesArr];
        }else{
            
            
        }
        
    }];
}

// Handle new message from one of channels on which client has been subscribed.
- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    
    // Handle new message stored in message.data.message
    if (![message.data.channel isEqualToString:message.data.subscription]) {
        

        // Message has been received on channel group stored in message.data.subscription.
    }
    else {
        
        NSLog(@"Msg from otherside");
        
        
        NSDictionary * getMetadataDict = message.data.userMetadata;
        
        NSLog(@"%@",getMetadataDict);
        
        NSLog(@"Received message: %@ on channel %@ at %@", message.data.message,
              message.data.channel, message.data.timetoken);
        
        NSDictionary *messageData = message.data.message;
        
        NSString * metaDataStr =getMetadataDict[@"Metadata"];

        
        if ([metaDataStr isEqualToString:@"admin"]) {

            [[NSNotificationCenter defaultCenter] postNotificationName:@"addMessage" object:messageData];

            
        }else if([metaDataStr isEqualToString:@"user"]){
            

        }else{
            

        }

        // Message has been received on channel stored in message.data.channel.
    }
    
//    self.checkgetMessageStr = message.data.message;
    
}

// New presence event handling.
- (void)client:(PubNub *)client didReceivePresenceEvent:(PNPresenceEventResult *)event {
    
    if (![event.data.channel isEqualToString:event.data.subscription]) {
        
        // Presence event has been received on channel group stored in event.data.subscription.
    }
    else {
        
        // Presence event has been received on channel stored in event.data.channel.
    }
    
    if (![event.data.presenceEvent isEqualToString:@"state-change"]) {
        
        NSLog(@"%@ \"%@'ed\"\nat: %@ on %@ (Occupancy: %@)", event.data.presence.uuid,
              event.data.presenceEvent, event.data.presence.timetoken, event.data.channel,
              event.data.presence.occupancy);
    }
    else {
        
        NSLog(@"%@ changed state at: %@ on %@ to: %@", event.data.presence.uuid,
              event.data.presence.timetoken, event.data.channel, event.data.presence.state);
    }
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FoodieProvider"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}


#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
