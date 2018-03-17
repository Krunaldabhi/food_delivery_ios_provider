//
//  LiveTaskViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/18/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "LeftMenuView.h"
#import "LiveTaskObj.h"
#import "ItemsObj.h"
#import "TermsandConditionViewController.h"
#import "ProfileObj.h"

@interface LiveTaskViewController : UIViewController<LeftMenuViewprotocol,CLLocationManagerDelegate> {
    
    CLLocationManager * locationManager;
    CLLocation *currentLocation;
    LeftMenuView *leftMenuViewClass;
    UIView * waitingBGView;
    int secondsLeft;
}
@property(nonatomic, strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UILabel *topLbl;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIView *whiteView;

@property (weak, nonatomic) IBOutlet UIImageView *menuImg;

@property (weak, nonatomic) IBOutlet UIImageView *notaskImg;
@property (weak, nonatomic) IBOutlet UILabel *noTaskLbl;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (strong, nonatomic) AppDelegate * appDelegate;
@property (strong, nonatomic) LiveTaskObj * liveTaskObj;
@property (strong, nonatomic) LocationUpdateObj * updateLocationObj;
@property (nonatomic, strong) ProfileObj * profileObjects;

@property (weak, nonatomic) IBOutlet UIView *loaderView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loader;



- (IBAction)menuAction:(id)sender;


@end
