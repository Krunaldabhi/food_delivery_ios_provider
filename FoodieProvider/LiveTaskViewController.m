//
//  LiveTaskViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/18/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "LiveTaskViewController.h"
#import "LiveTaskTableViewCell.h"
#import "LiveTaskDetailViewController.h"
#import "ShiftStatusViewController.h"
#import "ProfileViewController.h"
#import "NoticeBoardViewController.h"
#import "OrderHistoryViewController.h"
#import "OrderDetailViewController.h"
#import "Theme.h"
#import "UIView+Toast.h"
#import "Utilities.h"
#import "LiveTaskObj.h"
#import "SignInViewController.h"


@interface LiveTaskViewController ()<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>{
    
    
    NSMutableArray * completedfoodArr;
    NSMutableArray * getLivetaskArr;
    
    NSString * currentLat;
    NSString * currentLong;

    NSArray * orderimgArr;
    NSTimer * timerTOCallServer;
    NSTimer * timerTOupdateLocation;
    NSString *statusStr, *orderIdStr;
    LiveTaskTableViewCell *liveTaskCell;

}

@end

@implementation LiveTaskViewController
@synthesize updateLocationObj;

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self checkOrderRequest];
    
    [self leftMenuInitiation];

}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.noTaskLbl.hidden = NO;
    self.notaskImg.hidden = NO;
    self.loaderView.hidden = NO;
    self.loader.tintColor = BASECOLOR;
    
    self.topLbl.text = NSLocalizedString(@"LIVETASKLBL", nil);
    
    [Theme regularFontlabel:self.topLbl];
    
    self.topLbl.textColor = BASECOLOR;
    
    [Theme regularFontlabel:self.noTaskLbl];
    
    [self timerSequences];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkOrderRequest)
                                                 name:@"receiveMessage"
                                               object:nil];
    
    
}

-(void)timerSequences{
    
  timerTOCallServer =  [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(checkOrderRequest) userInfo:nil repeats:YES];
//  timerTOupdateLocation = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(updateLocation) userInfo:nil repeats:YES];
    
}

-(void)getCurrentLocation{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    currentLocation = [locations lastObject];
    
    if (currentLocation != nil){
        
        currentLat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        currentLong = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        
    }
    
}


-(void)updateLocation{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        updateLocationObj = [[LocationUpdateObj alloc]initWithLocationUpdate:currentLat getLongitute:currentLong];

    });
}

-(void)getProfileService{
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        NSDictionary * params=@{@"device_id":self.appDelegate.deviceIdStr,@"device_token":self.appDelegate.deviceToken,@"device_type":self.appDelegate.deviceType};
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        afn.loaderRequestStr = @"Hide";
        
        [afn getDataFromPath:MD_GETPROFILE withParamData:params withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            if(response)
            {
                NSLog(@"PROFILE response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.profileObjects = [[ProfileObj alloc]iniWithDictionary:response];
                    
                    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                    
                    [userDefaults setObject:self.profileObjects.name forKey:@"name"];
                    [userDefaults setObject:self.profileObjects.avatar forKey:@"avatar"];
                    [userDefaults setInteger:self.profileObjects.idStr forKey:@"id"];
                    [userDefaults setObject:self.profileObjects.device_token forKey:@"device_token"];
                    
                    CURRENCY = self.profileObjects.currencyStr;
                    
                    [userDefaults synchronize];
                    
                });
            }
            
            else
            {
                
                NSString * errorStr = [NSString stringWithFormat:@"%@",Error[@"error"]];
                
                [Utilities showAlert:errorStr];
                
            }
        }];
    }else{
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
    
}

-(void)checkOrderRequest{
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        afn.loaderRequestStr = @"Hide";
        [afn getDataFromPath:MD_GETORDER withParamData:nil withBlock:^(NSArray * response, NSDictionary *Error,NSString *strCode) {
            
            if(response)
            {
                NSLog(@"Live onProcess response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{

                    [self getCompletedRequest];
                    
                    if (response.count == 0) {
                        
                        getLivetaskArr = [NSMutableArray arrayWithArray:response];

                    }
                    else
                    {
                        statusStr = [[response valueForKey:@"status"]objectAtIndex:0];
                        orderIdStr = [NSString stringWithFormat:@"%@", [[response valueForKey:@"id"]objectAtIndex:0]];
                        getLivetaskArr = [[NSMutableArray alloc]init];
                        
                        self.whiteView.hidden = YES;
                        self.noTaskLbl.hidden = YES;
                        self.notaskImg.hidden = YES;
                        self.listTableView.hidden = NO;
                        
                        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                        CURRENCY = [userDefaults objectForKey:@"currency"];
                        
                        self.liveTaskObj = [[LiveTaskObj alloc]initWithDictionary:response[0]];
                        
                        [getLivetaskArr addObject:self.liveTaskObj];
                        
                        [self.listTableView reloadData];
                        
                        [timerTOCallServer invalidate];
                        
                        if ([statusStr isEqualToString:@"SEARCHING"]) {
                            secondsLeft = [[[response valueForKey:@"response_time"] objectAtIndex:0]intValue];
                            [self countdownTimer];
                        }
                    }
                    
                });
            }
            
            else
            {

//
            }
        }];
    }else{
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
}

- (void)updateCounter:(NSTimer *)theTimer
{
    if(secondsLeft > 0 ) {
        secondsLeft -- ;
        [self.listTableView reloadData];
    } else {
        secondsLeft = 0;
        [_timer invalidate];
        getLivetaskArr = [[NSMutableArray alloc]init];
        [self.listTableView reloadData];
    }
}

- (void)countdownTimer
{
    if([_timer isValid]) {
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}


-(void)getCompletedRequest{
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        afn.loaderRequestStr = @"Hide";
        [self.loader startAnimating];
        [afn getDataFromPath:MD_GETORDERHISTORYLIST withParamData:nil withBlock:^(NSArray * response, NSDictionary *Error,NSString *strCode) {
            
            if(response)
            {
                NSLog(@"Completed Task onProcess response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    completedfoodArr = [[NSMutableArray alloc]init];
                    
                    if (response.count == 0) {
                        
                        self.loaderView.hidden = YES;

                    }
                    else
                    {
                        self.loaderView.hidden = YES;
                        self.whiteView.hidden = YES;
                        self.noTaskLbl.hidden = YES;
                        self.notaskImg.hidden = YES;
                        self.listTableView.hidden = NO;
                        
                        for (int i = 0; i < [response count]; i++)
                        {
                            self.liveTaskObj = [[LiveTaskObj alloc]initWithDictionary:response[i]];
                            [completedfoodArr addObject:self.liveTaskObj];
                        }
                        
                        
                        [self.listTableView reloadData];
                        
                    }
                    
                });
            }
            
            else
            {
                
                NSString * errorStr = [NSString stringWithFormat:@"%@",Error[@"error"]];
                
                [Utilities showAlert:errorStr];
                
            }
        }];
    }else{
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
    
}

#pragma Tableview Delegate and Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    if (completedfoodArr.count == 0) {
        
        return 1;

    }else{
        
        return 2;

        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }
    else{
        
        return [completedfoodArr count];
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width - 15, 50)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, view.frame.size.width - 15, 20)];
        NSString *Headerstring;
        if ([self.liveTaskObj.transporterObj.status isEqualToString:@"unsettled"]) {
            
            Headerstring = @"";

            
        } else if([self.liveTaskObj.transporterObj.status isEqualToString:@"offline"]){
            
            Headerstring = @"";

        }else{
           
            Headerstring = NSLocalizedString(@"NEWTASKLABEL", nil);

        }


        [Theme subHeader:label];
        
        [label setText:Headerstring];
        [view addSubview:label];
        
        [view setBackgroundColor:[UIColor whiteColor]];
        
        return view;

        
    }
    else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake((tableView.frame.size.width - 15)/2, 20, tableView.frame.size.width - 20, 50)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, view.frame.size.width - 15 , 20)];
        
        
        NSString *string = NSLocalizedString(@"COMPLETEDTASKLABEL", nil);
        [Theme subHeader:label];
        
        [label setText:string];
        [view addSubview:label];
        
        
        
        [view setBackgroundColor:[UIColor whiteColor]];
        return view;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 30;
        
    }else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, tableView.frame.size.width, 20)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        return view;
        
    }else{
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, tableView.frame.size.width, 10)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        return view;
        
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"NEWTASKLABEL", nil);
            break;
            
        case 1:
            sectionName = NSLocalizedString(@"COMPLETEDTASKLABEL", nil);
            break;

        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveTaskTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
        if (indexPath.section == 0) {
            
            if (getLivetaskArr.count == 0) {
                
                cell.waitingView.hidden = NO;
                cell.listcontentView.hidden = YES;

                if ([self.liveTaskObj.transporterObj.status isEqualToString:@"unsettled"]) {
                    
                    cell.waitingImg.image = [UIImage imageNamed:@"handOverCash"];
                    cell.waitingtaskLbl.text = NSLocalizedString(@"PLEASESETTLEAMOUNTLABEL", nil);
                    cell.waitingtaskLbl.font = [UIFont fontWithName:FONT_REGULAR size:12.0];

                }
                else if([self.liveTaskObj.transporterObj.status isEqualToString:@"offline"])
                {
                    
                    tableView.tableHeaderView.tintColor = [UIColor clearColor];
                    cell.waitingImg.image = [UIImage imageNamed:@"purchase"];
                    cell.waitingtaskLbl.text = NSLocalizedString(@"TAPSHIFTLABEL", nil);
                    cell.waitingtaskLbl.font = [UIFont fontWithName:FONT_REGULAR size:14.0];
                    
                }else{
                    cell.waitingImg.image = [UIImage imageNamed:@"hour-glass"];
                    cell.waitingtaskLbl.text = NSLocalizedString(@"WAITINGFORTASKLBL", nil);
                    cell.waitingtaskLbl.font = [UIFont fontWithName:FONT_REGULAR size:16.0];
                    
                }
            }
            else{
                
                cell.waitingView.hidden = YES;
                cell.listcontentView.hidden = NO;

                self.liveTaskObj = (LiveTaskObj *)[getLivetaskArr objectAtIndex:indexPath.row];
                
                cell.celltopView.backgroundColor = LIVETASKCOLOR;
                [Theme regularFontlabel:cell.topOrderLabel];
                cell.orderImg.clipsToBounds = YES;
                cell.orderImg.layer.cornerRadius = 4.0f;
                cell.topOrderLabel.text = NSLocalizedString(@"NEWORDERREQUESTLABEL", nil);
                cell.topOrderLabel.textColor = [UIColor whiteColor];
                [Theme regularFontlabel:cell.fewSecondAgo];
                cell.orderImg.layer.cornerRadius = 4;
                
                [Theme regularFontlabel:cell.restaurentName];
                cell.restaurentName.textColor = [UIColor blackColor];
                
                [Theme smallLabel:cell.orderLbl];
                cell.orderLbl.textColor = DESCCOLOR;
                if ([statusStr isEqualToString:@"SEARCHING"]) {
                    cell.fewSecondAgo.hidden = NO;
                    NSString *str = [NSString stringWithFormat:@"%d secs left",secondsLeft];
                    cell.fewSecondAgo.text =str;
                    cell.fewSecondAgo.textColor = [UIColor whiteColor];
                    cell.acceptBtn.hidden = NO;
                    cell.rejectBtn.hidden = NO;
                    cell.acceptBtn.tag = indexPath.row;
                    cell.rejectBtn.tag = indexPath.row;

                    [cell.acceptBtn addTarget:self action:@selector(acceptBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.rejectBtn addTarget:self action:@selector(rejectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                }else{
                    cell.fewSecondAgo.hidden = YES;
                    cell.acceptBtn.hidden = YES;
                    cell.rejectBtn.hidden = YES;
                }
                
                cell.restaurentName.text = self.liveTaskObj.shopObj.name;
                cell.orderLbl.text = self.liveTaskObj.shopObj.address;
                [cell.orderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.liveTaskObj.shopObj.avatar]] placeholderImage:[UIImage imageNamed:@"user"]];
                
                cell.celltopView.backgroundColor = BASECOLOR;
            }
        }else{
            
            self.liveTaskObj = (LiveTaskObj *)[completedfoodArr objectAtIndex:indexPath.row];
            cell.waitingView.hidden = YES;
            cell.acceptBtn.hidden = YES;
            cell.rejectBtn.hidden = YES;
            cell.listcontentView.hidden = NO;

            cell.topOrderLabel.textColor = [UIColor whiteColor];
            cell.fewSecondAgo.textColor = [UIColor whiteColor];
            
            cell.restaurentName.text = self.liveTaskObj.shopObj.name;
            cell.orderLbl.text = self.liveTaskObj.shopObj.address;
            [cell.orderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.liveTaskObj.shopObj.avatar]] placeholderImage:[UIImage imageNamed:@"user"]];
            cell.orderImg.clipsToBounds = YES;
            cell.orderImg.layer.cornerRadius = 4.0f;
            
            [Theme regularSemiBoldFontlabel:cell.topOrderLabel];
            
            if ([self.liveTaskObj.status isEqualToString:@"CANCELLED"]) {
                
                cell.celltopView.backgroundColor = [UIColor redColor];
                cell.topOrderLabel.text = [NSString stringWithFormat:@"Cancelled #%@",self.liveTaskObj.orderIdStr.stringValue];
                cell.topOrderLabel.textColor = WHITE;
            }else{
                
                cell.celltopView.backgroundColor = COMPLETEDTASK;
                cell.topOrderLabel.text = [NSString stringWithFormat:@"Delivered #%@",self.liveTaskObj.orderIdStr.stringValue];
                cell.topOrderLabel.textColor = COMPLETEDTASKCOLOR;
            }
            
            [Theme regularFontlabel:cell.fewSecondAgo];
            cell.fewSecondAgo.textColor = [UIColor whiteColor];
            cell.fewSecondAgo.text = @"";
           
            cell.orderImg.layer.cornerRadius = 4;
            
            [Theme regularFontlabel:cell.restaurentName];
            cell.restaurentName.textColor = [UIColor blackColor];
            
            [Theme smallLabel:cell.orderLbl];
            cell.orderLbl.textColor = DESCCOLOR;
        }
    
    cell.listcontentView.layer.cornerRadius = 4.0f;
    cell.listcontentView.clipsToBounds = YES;
    
    cell.listcontentView.layer.shadowOffset = CGSizeMake(0, 0);
    cell.listcontentView.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.listcontentView.layer.shadowRadius = 2;
    cell.listcontentView.layer.shadowOpacity =0.2;
    cell.listcontentView.layer.masksToBounds = NO;
    
    return cell;
}

- (void)cellDataInsert:(LiveTaskTableViewCell *)getCell liveObject:(LiveTaskObj *)getObj{

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (getLivetaskArr.count != 0) {
            if ([statusStr isEqualToString:@"SEARCHING"]) {
                
//                UIAlertController *actionSheet =
//
//                [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//
//                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//
//                    // Cancel button tappped.
//                    [self dismissViewControllerAnimated:YES completion:^{
//
//                    }];
//                }]];
//
//                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    [self acceptRejectTask :@"ACCEPT"];
//                }]];
//
//                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Reject" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    [self acceptRejectTask :@"REJECT"];
//                }]];
//                // Present action sheet.
//                [self presentViewController:actionSheet animated:YES completion:nil];
                
            }
            else{
                LiveTaskDetailViewController * liveTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveTaskDetailViewController"];
                [self.navigationController pushViewController:liveTaskVC animated:YES];
                
                [timerTOCallServer invalidate];
            }
            
        }
        
    }else{
        
        LiveTaskObj * liveTaskObj = (LiveTaskObj *)[completedfoodArr objectAtIndex:indexPath.row];
        
        OrderDetailViewController * orderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderDetailViewController"];
        orderVC.liveTaskObj = liveTaskObj;
        [self.navigationController pushViewController:orderVC animated:YES];
    }
    
}

- (IBAction)menuAction:(id)sender {
    
    [leftMenuViewClass setHidden:NO];
    

    [self LeftMenuView];
    
}

- (void)acceptBtnAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    CGRect btnFrame = [button convertRect:button.bounds toView:_listTableView];
    NSIndexPath *indexPath = [_listTableView indexPathForRowAtPoint:btnFrame.origin];
    NSLog(@"Selected Section: %lu", (unsigned long)indexPath.section);
    NSLog(@"Selected IndexPath: %lu", (unsigned long)indexPath.row);
    
    liveTaskCell = (LiveTaskTableViewCell *)[_listTableView cellForRowAtIndexPath:indexPath];
    
    [self acceptRejectTask:@"ACCEPT"];
}

- (void)rejectBtnAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    CGRect btnFrame = [button convertRect:button.bounds toView:_listTableView];
    NSIndexPath *indexPath = [_listTableView indexPathForRowAtPoint:btnFrame.origin];
    NSLog(@"Selected Section: %lu", (unsigned long)indexPath.section);
    NSLog(@"Selected IndexPath: %lu", (unsigned long)indexPath.row);
    
    liveTaskCell = (LiveTaskTableViewCell *)[_listTableView cellForRowAtIndexPath:indexPath];
    
    [self acceptRejectTask:@"REJECT"];
}

/***** MENU GESTURE ******/


-(void)leftMenuInitiation{

    UITapGestureRecognizer *tapGesture_condition=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewOuterTap)];
    tapGesture_condition.cancelsTouchesInView=NO;
    tapGesture_condition.delegate=self;
    [self.view addGestureRecognizer:tapGesture_condition];
    
    leftMenuViewClass = [[[NSBundle mainBundle] loadNibNamed:@"LeftMenuView" owner:self options:nil] objectAtIndex:0];
    [leftMenuViewClass setFrame:CGRectMake(-(self.view.frame.size.width - 100), 0, self.view.frame.size.width - 100, self.view.frame.size.height)];
    
    leftMenuViewClass.LeftMenuViewDelegate =self;
    leftMenuViewClass.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:leftMenuViewClass];
    
    waitingBGView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width  ,self.view.frame.size.height)];
    
    [waitingBGView setBackgroundColor:[UIColor blackColor]];
    [waitingBGView setAlpha:0.6];
    [self.view addSubview:waitingBGView];
    
    waitingBGView.hidden = YES;

    [leftMenuViewClass setHidden:YES];
    
}


-(void)LeftMenuView
{
    [UIView animateWithDuration:0.5 animations:^{
        
        leftMenuViewClass.frame = CGRectMake(0, 0, self.view.frame.size.width - 100,  self.view.frame.size.height);

    }];
    
    waitingBGView.hidden = NO;
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"Your Name is --- > %@",[userDefaults objectForKey:@"name"]);
    
    NSString * nameStr = [userDefaults objectForKey:@"name"];
    NSString * imgString = [userDefaults objectForKey:@"avatar"];
    
    [leftMenuViewClass.imgUser sd_setImageWithURL:[NSURL URLWithString:imgString] placeholderImage:[UIImage imageNamed:@"user"]];
    
    leftMenuViewClass.nameLbl.text = nameStr;
    leftMenuViewClass.idLbl.text = @"";

    [Theme regularFontlabel:leftMenuViewClass.nameLbl];
    [Theme regularFontlabel:leftMenuViewClass.idLbl];
    
    leftMenuViewClass.nameLbl.textColor = WHITE;
    leftMenuViewClass.idLbl.textColor = WHITE;
    
    [self.view bringSubviewToFront:leftMenuViewClass];
}

- (void)ViewOuterTap
{
    [UIView animateWithDuration:0.5 animations:^{
        
        
        leftMenuViewClass.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width - 100,  self.view.frame.size.height);
        waitingBGView.hidden = YES;

    }];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer* )gestureRecognizer shouldReceiveTouch:(UITouch* )touch
{
    if ([touch.view isDescendantOfView:leftMenuViewClass])
    {
        return NO;
    }
    return YES;
}

-(void)profileView
{
    [self ViewOuterTap];
    
    ProfileViewController * profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self presentViewController:profileVC animated:YES completion:nil];
    
}


-(void)shiftStatus
{
    [self ViewOuterTap];
    
    ShiftStatusViewController * shiftVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShiftStatusViewController"];
    [self.navigationController pushViewController:shiftVC animated:YES];
    
}

-(void)noticeBoard
{
    [self ViewOuterTap];
    
    NoticeBoardViewController * noticeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NoticeBoardViewController"];
    [self presentViewController:noticeVC animated:YES completion:nil];
    
}

-(void)orderHistory
{
    [self ViewOuterTap];
    
    OrderHistoryViewController * orderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderHistoryViewController"];
    [self.navigationController pushViewController:orderVC animated:YES];
    
}

-(void)termsandCondition
{
    [self ViewOuterTap];
    TermsandConditionViewController * termsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsandConditionViewController"];
    [self presentViewController:termsVC animated:YES completion:nil];
    
}

-(void)logout
{
    [self ViewOuterTap];
    
    [self logoutView];
    
}

-(void)logoutView{
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    
    
    
    [alert showAlertWithTitle:nil
                 withSubtitle:@"Are you sure want to logout ?"
              withCustomImage:nil
          withDoneButtonTitle:@"Yes"
                   andButtons:nil];
    alert.colorScheme = BASECOLOR;
    alert.doneButtonTitleColor = [UIColor whiteColor];
    alert.animateAlertOutToBottom = YES;
    alert.hideSeparatorLineView = NO;
    alert.animateAlertInFromTop = YES;
    alert.firstButtonBackgroundColor= BASECOLOR;
    alert.firstButtonTitleColor= [UIColor whiteColor];
    alert.subtitleFont = [UIFont fontWithName:FONT_REGULAR size:14.0];
    
    alert.subTitleColor = BASECOLOR;
    alert.doneButtonCustomFont =  [UIFont fontWithName:FONT_REGULAR size:16.0];
    
    [alert doneActionBlock:^{
        
        [self logoutService];
        
    }];
    
    [alert addButton:@"No" withActionBlock:^{
        
        
        
    }];
}

-(void)logoutService{
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];

        [afn getDataFromPath:MD_LOGOUT withParamData:nil withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            if(response)
            {
                NSLog(@"Logout response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSUserDefaults * userAuthDefault = [NSUserDefaults standardUserDefaults];
                    [userAuthDefault setValue:@"logout" forKey:@"logout"];
                    [userAuthDefault setBool:NO forKey:@"isLoggedin"];
                    [userAuthDefault synchronize];
                    
                    SignInViewController * signinVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
                    [self.navigationController pushViewController:signinVC animated:YES];
                    
                });
            }
            
            else
            {
                
                NSString * errorStr = [NSString stringWithFormat:@"%@",Error[@"error"]];
                
                [Utilities showAlert:errorStr];
                
            }
        }];
    }else{
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)acceptRejectTask: (NSString *)request{
    if ([Reachability reachabilityForInternetConnection]) {
        
        NSDictionary * params=@{@"status":@"PROCESSING", @"request_status":request, @"order_id":orderIdStr};
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:MD_TRANPORTER_REQUEST_ORDER withParamData:params withBlock:^(NSArray * response, NSDictionary *Error,NSString *strCode) {
            if(response)
                
            {
                NSLog(@"TRANPORTER_REQUEST_ORDER response...%@", response);
                statusStr = @"";
                [self checkOrderRequest];
                if (![request isEqualToString:@"REJECT"]) {
                    LiveTaskDetailViewController * liveTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveTaskDetailViewController"];
                    [self.navigationController pushViewController:liveTaskVC animated:YES];
                    
                    [timerTOCallServer invalidate];
                } else {
                    
                }
                
            }
        }];
    }else{
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
}


@end
