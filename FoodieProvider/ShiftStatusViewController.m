//
//  ShiftStatusViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/15/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "ShiftStatusViewController.h"
#import "LiveTaskViewController.h"
#import "ShiftStatusTableViewCell.h"
#import "LiveTaskViewController.h"
#import "SignInViewController.h"


@interface ShiftStatusViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSString * getshiftStatus;
    int count;
    
    NSMutableArray * shiftStatusArr;
    NSArray * numberOfOrdersArr;
    NSArray * timeArr;
    
    NSString * startStr, *endStr;
    NSString * currentTimeStr;

    NSMutableArray * shiftObjArr ,*shiftArr;
    NSString * breakonOroffStr;
    
    UIView * vehicleViewContainer;
    UIPickerView * vehiclePickerView;
    UIView * backgroundView;
    NSString * vehicleStr;

    NSInteger totalCount;
}

@property (nonatomic, strong) ShiftStatusObj * shiftsObjects;
@property (nonatomic, strong) VehicleObj * vehicleObjects;
@property (nonatomic, strong) ProfileObj * profileObjects;



@end

@implementation ShiftStatusViewController
@synthesize appDelegate;


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    startStr = @"Start";
    endStr = @"End";
    
    [self getProfileService];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.ownedAmountLbl.text = [NSString stringWithFormat:@"%@%@",CURRENCY,self.shiftsObjects.total_amount_pay.stringValue];
    self.amountLbl.text = [NSString stringWithFormat:@"%@%@",CURRENCY,self.shiftsObjects.total_amount_pay.stringValue];
    
    appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.deviceToken == nil) {
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        appDelegate.deviceToken = [defaults valueForKey:@"device_token"];

    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getProfileService)
                                                 name:@"getProfileService"
                                               object:nil];
    
    vehicleViewContainer                 = [[UIView alloc] init];
    vehiclePickerView                    = [[UIPickerView alloc] init];
    vehicleViewContainer.backgroundColor = [UIColor whiteColor];
    
    [vehiclePickerView setDataSource:self];
    [vehiclePickerView setDelegate:self];
    
}

-(void)userInterface{
    

    breakonOroffStr = @"off";

    getshiftStatus = [[NSUserDefaults standardUserDefaults]objectForKey:@"ShiftStatus"];
    
    if ([getshiftStatus isEqualToString:startStr]) {

        self.startBtn.hidden = NO;
        [self.startBtn setTitle:NSLocalizedString(@"SHIFTENDBUTTONTEXT", nil) forState:UIControlStateNormal];
        count = 1;
        
        self.vehiclenoEnterView.hidden = YES;
        self.bgView.hidden = YES;
        self.sideIconImg.hidden = NO;
        self.sideBtn.hidden = NO;
        self.shiftstatusSwitch.hidden = NO;
        self.purchaseImg.hidden = YES;
        self.tapLbl.hidden = YES;
        self.amountToBePaidView.hidden = YES;
        self.youOwnedView.hidden = NO;
        self.shiftTableView.hidden = NO;
        self.amountendShiftBtn.hidden = NO;

        self.ownedAmountLbl.text = [NSString stringWithFormat:@"%@%@",CURRENCY,self.shiftsObjects.total_amount_pay.stringValue];
        self.amountLbl.text = [NSString stringWithFormat:@"%@%@",CURRENCY,self.shiftsObjects.total_amount_pay.stringValue];
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL checkStatus = [userDefaults boolForKey:@"switchstatus"];
        
        if (checkStatus) {
            
            self.shiftstatusSwitch.on = YES;

        }else{
            
            self.shiftstatusSwitch.on = NO;

        }
        
    }else{
        
        [self.startBtn setTitle:NSLocalizedString(@"SHIFTSTARTBUTTONTEXT", nil) forState:UIControlStateNormal];
        count = 2;
        
        self.vehiclenoEnterView.hidden = YES;
        self.bgView.hidden = YES;
        self.sideIconImg.hidden = YES;
        self.sideBtn.hidden = YES;
        self.shiftstatusSwitch.hidden = YES;
        self.purchaseImg.hidden = NO;
        self.tapLbl.hidden = NO;
        self.amountToBePaidView.hidden = YES;
        self.shiftTableView.hidden = YES;
        self.youOwnedView.hidden = YES;
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL checkStatus = [userDefaults boolForKey:@"switchstatus"];
        
        if (checkStatus) {
            
            self.shiftstatusSwitch.on = YES;
            
        }else{
            
            self.shiftstatusSwitch.on = NO;
            
        }
        
        
    }
    
    self.shiftstatusLbl.text = NSLocalizedString(@"TOPLABEL", nil);
    self.tapLbl.text = NSLocalizedString(@"TAPSHIFTLABEL", nil);
    [self.amountendShiftBtn setTitle:NSLocalizedString(@"SHIFTENDBUTTONTEXT", nil) forState:UIControlStateNormal];
    self.pleaseHandoverLbl.text = NSLocalizedString(@"PLEASESETTLEAMOUNTLABEL", nil);
    
    [Theme regularFontlabel:self.shiftstatusLbl];
    [Theme regularFontlabel:self.tapLbl];
    [Theme baseButton:self.startBtn];
    [Theme baseButton:self.amountendShiftBtn];
    [Theme regularFontlabel:self.amountToBePaidLbl];
    [Theme regularFontlabel:self.pleaseHandoverLbl];
    
    self.amountToBePaidLbl.font = [UIFont fontWithName:FONT_REGULAR size:22.0];
    self.amountLbl.font = [UIFont fontWithName:FONT_REGULAR size:22.0];
    self.amountLbl.textColor = BASECOLOR;
    
    /* In POP VIEW (Enter vehicle View) */
    
    self.vehiclenoEnterView.clipsToBounds = YES;
    self.vehiclenoEnterView.layer.cornerRadius = 5;
    
    self.vehiclenoBtn.layer.cornerRadius = 5;
    self.vehiclenoBtn.layer.borderWidth = 1;
    self.vehiclenoBtn.layer.borderColor = DESCCOLOR.CGColor;
    [self.vehiclenoBtn setTitleColor:BASETEXT forState:UIControlStateNormal];
    
    self.vehicleTxt.textColor = BASETEXT;
    self.vehicleTxt.text = NSLocalizedString(@"SELECTVEHICLELABEL", nil);
    self.youOwnedLbl.text = NSLocalizedString(@"YOUOWEDLABEL", nil);
    
    [Theme circleviewDesignwithShadow:self.orView];
    
    self.orLbl.text = NSLocalizedString(@"ORLBL", nil);
    
    self.enterLbl.text =NSLocalizedString(@"ENTERLBL", nil);
    [Theme regularFontlabel:self.enterLbl];
    [Theme cornerRadius:self.amountToBePaidView forLabel:nil fortextfield:nil forButton:nil];
    [Theme textfieldInfocus:self.enterTxtField];
    
    [Theme baseButton:self.continueBtn];
    [self.continueBtn setTitle:NSLocalizedString(@"CONTINUEBTN", nil) forState:UIControlStateNormal];
    
    
}

- (IBAction)amountshiftEndAction:(id)sender {
    
    [self endShiftService];
    
}

- (IBAction)shiftAction:(UISwitch *)sender {
    
    if (sender.isOn) {
        
        [self breakService:@"on"];
        
    }else{
        
        [self breakService:@"off"];
    }
    
}

- (IBAction)starAction:(id)sender {
    
    if (count == 1) {
        
        if (!_shiftstatusSwitch.on) {
            
            [self populatetheVehicleView:self.amountToBePaidView];

        }else{
            
            [Utilities showAlert:@"You cannot end the shift, If the break is ON"];
        }
        
        
    }else{
        self.vehiclenoEnterView.hidden = NO;
        
        [self populatetheVehicleView:self.vehiclenoEnterView];
        
    }
    
}

-(void)populatetheVehicleView:(UIView *)view{
    
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.view bringSubviewToFront:view];
                         view.hidden = NO;
                         [AnimationView alertViewAnimation:view bgView:_bgView];
                         
                         self.bgView.hidden = NO;
                         
                     }
                     completion:nil];
    
    //    [self callPopView];
    
    
}

- (IBAction)sideAction:(id)sender {
    
    LiveTaskViewController * liveTaskView = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveTaskViewController"];
    [self.navigationController pushViewController:liveTaskView animated:YES];
    
}

- (IBAction)listVehicleAction:(id)sender {
    
    [self.view endEditing:YES];
    
    if (self.vehicleObjects.vehicleArr.count == 0) {

        [Utilities showAlert:NSLocalizedString(@"NOVEHICLEFOUND", nil)];
    }
    else
    {
    
        [self showVehicleAction];
    }

    
}

-(void)showVehicleAction{
    
    vehicleViewContainer.frame          = CGRectMake(0, (self.view.bounds.size.height)-180, self.view.bounds.size.width, 180);
    vehicleViewContainer.layer.cornerRadius   = 10;
    
    vehiclePickerView.frame                   = CGRectMake(0, 0, self.view.frame.size.width, 160);
    vehiclePickerView.hidden                  = NO;
    vehiclePickerView.showsSelectionIndicator = YES;
    vehiclePickerView.tintColor = BASECOLOR;
    
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundView.alpha = 0.4f;
    backgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backgroundView];
    
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [setBtn addTarget:self
               action:@selector(setVehicle)
     forControlEvents:UIControlEventTouchUpInside];
    setBtn.frame = CGRectMake(0, 140, 140, 40);
    [setBtn setTitle:@"Select" forState:UIControlStateNormal];
    [setBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
    setBtn.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14];
    
    UIButton *cancelPickerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelPickerBtn addTarget:self
                        action:@selector(cancelVehicle)
              forControlEvents:UIControlEventTouchUpInside];
    cancelPickerBtn.frame = CGRectMake(vehiclePickerView.frame.size.width-140, 140, 140, 40);
    [cancelPickerBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelPickerBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
    cancelPickerBtn.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14];
    
    
    [vehicleViewContainer addSubview:vehiclePickerView];
    [vehicleViewContainer addSubview:cancelPickerBtn];
    [vehicleViewContainer addSubview:setBtn];
    
    [self.view addSubview:vehicleViewContainer];
}

-(void)setVehicle
{
    vehicleStr = [NSString stringWithFormat:@"%@",[self.vehicleObjects.vehicleArr objectAtIndex:[vehiclePickerView selectedRowInComponent:0]]];
    
    self.vehicleTxt.text = vehicleStr;
    self.enterTxtField.text = vehicleStr;
//    [self.vehiclenoBtn setTitle:vehicleStr forState:UIControlStateNormal];
    [self cancelVehicle];
}

-(void)cancelVehicle
{
    [vehicleViewContainer removeFromSuperview];
    [backgroundView removeFromSuperview];
}


- (IBAction)continueAction:(id)sender {
    
    if (self.enterTxtField.text.length == 0) {
        
        [self doneWithNumberPad];
        [self.vehiclenoEnterView makeToast:NSLocalizedString(@"PLEASEENTERLBL", nil)];
        
    }else{
        
        [self hideBGView];
        [self shiftService];
        
    }
    
}

- (IBAction)bgAction:(id)sender {
    
    self.enterTxtField.text = @"";
    [self doneWithNumberPad];
    [self hideBGView];
    
}

-(void)hideBGView{
    
    float duration = 0.3/self.vehiclenoEnterView.frame.size.width*fabs(self.vehiclenoEnterView.center.x)+ 0.3/2;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.vehiclenoEnterView.hidden = YES;
                         self.amountToBePaidView.hidden = YES;
                         
                         self.bgView.hidden = YES;
                         [self doneWithNumberPad];
                         [self.view endEditing:YES];
                     }
                     completion:nil];
}


/*************************** WEB Services Part ************************/

-(void)getVehicleList{
    
    if ([Reachability reachabilityForInternetConnection]) {
    
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        afn.loaderRequestStr = @"Hide";
        
        [afn getDataFromPath:MD_GETVEHICLELIST withParamData:nil withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            if(response)
            {
                NSLog(@"Vehicle response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.vehicleObjects = [[VehicleObj alloc]initWithresposeArray:response];

                    NSLog(@"Vehicle List ----> %@",self.vehicleObjects.vehicle_no);
                    
                    if (self.vehicleObjects.vehicleArr.count != 0) {
                        
                        self.vehicleTxt.text = NSLocalizedString(@"SELECTVEHICLELABEL", nil);
        
                    }
                    else{
                        
                        self.vehicleTxt.text = NSLocalizedString(@"NOVEHICLELABEL", nil);

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

-(void)shiftService{
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        NSDictionary * params=@{@"vehicle_no":self.enterTxtField.text};
        
        [appDelegate onStartLoader];
        
        AFNHelper *afn = [[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:MD_STARTSHIFT withParamData:params withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            [appDelegate onEndLoader];

            if(response)
            {
                NSLog(@"Shift Start response...%@", response);

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    self.shiftsObjects = [[ShiftStatusObj alloc]iniWithDictionary:response[0]];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:startStr forKey:@"ShiftStatus"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    LiveTaskViewController * verifyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveTaskViewController"];
                    [self.navigationController pushViewController:verifyVC animated:YES];
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


-(void)getShiftServices{
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        //[appDelegate onStartLoader];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        [afn getDataFromPath:MD_GETSHIFT withParamData:nil withBlock:^(NSArray * response, NSDictionary *Error,NSString *strCode) {
            
            //[appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"Shift onProcess response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                
                    self.whiteView.hidden = YES;

                    if (response.count != 0) {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:startStr forKey:@"ShiftStatus"];

                        self.shiftsObjects = [[ShiftStatusObj alloc]iniWithDictionary:response[0]];
                        
                       
                            [self.shiftTableView reloadData];
                        
                        
                    }else{
                        [self getVehicleList];
                        [[NSUserDefaults standardUserDefaults] setObject:endStr forKey:@"ShiftStatus"];

                    }
                    
                    
                    [self userInterface];
                    
//                    if (self.shiftsObjects.) {
//                        <#statements#>
//                    }
                    
                    if (self.shiftsObjects.shiftEndTime != nil) {
                        
                        self.amountendShiftBtn.hidden = YES;
                        self.taptohide.enabled = YES;
                        self.startBtn.hidden = YES;
                        self.shiftstatusSwitch.hidden = YES;
                        
                        [self populatetheVehicleView:self.amountToBePaidView];
                        
                    }else{
                        
                        
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

-(void)breakService:(NSString *)checkonORoffString{
    
    NSString * methodUrlRequest;
    
    ShiftBreaks * lastBreak = self.shiftsObjects.shiftBreaks.lastObject;
    NSInteger idStr = lastBreak.shiftBreakID;
    NSString * headerMethod;
    
    if ([checkonORoffString isEqualToString:@"on"]) {
        
        headerMethod = POST_METHOD;
        methodUrlRequest = MD_SHIFTBREAKSTART;
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"switchstatus"];
        [userDefaults synchronize];
        
        
    }else{
        headerMethod = DELETE_METHOD;
        methodUrlRequest = [NSString stringWithFormat:@"%@/%ld",MD_SHIFTBREAKSTART,(long)idStr];
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:NO forKey:@"switchstatus"];
        [userDefaults synchronize];
    }
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        [appDelegate onStartLoader];

        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:headerMethod];
        [afn getDataFromPath:methodUrlRequest withParamData:nil withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            [appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"Shift onProcess response...%@", response);

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.shiftsObjects = [[ShiftStatusObj alloc]iniWithDictionary:response[0]];
                    
                    totalCount = self.shiftsObjects.total_order.integerValue - totalCount;

                    [self.shiftTableView reloadData];
                    
                });
                
            }
            
            else
            {
                NSString *errorStr = [NSString stringWithFormat:@"%@",Error[@"phone"]];
                NSString *errorString = [NSString stringWithFormat:@"%@",Error[@"error"]];
                
                errorStr = [Utilities removeNullFromString:errorStr];
                errorString = [Utilities removeNullFromString:errorString];
                
                if (![errorStr isEqualToString:@""]) {
                    [Utilities showAlert:errorStr];
                } else if (![errorString isEqualToString:@""]) {
                    [Utilities showAlert:errorString];
                }
                else{
                    [Utilities showAlert:@"Error"];
                }
                
            }
        }];
    }else{
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
    
}

-(void)endShiftService{
    
//    NSDictionary * params = @{@"end_time":currentTimeStr};
    NSString * methodUrlRequest = [NSString stringWithFormat:@"%@/%ld",MD_SHIFTEND,[self.shiftsObjects.providerShiftID integerValue]];
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:DELETE_METHOD];
        [afn getDataFromPath:methodUrlRequest withParamData:nil withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            if(response)
            {
                NSLog(@"Shift END response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[NSUserDefaults standardUserDefaults] setObject:endStr forKey:@"ShiftStatus"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [self backtoMainScreen];
                    
                    [self.shiftTableView reloadData];
                    
                    count = 3;
                    
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

-(void)backtoMainScreen{
    
        self.amountendShiftBtn.hidden = YES;
        self.startBtn.hidden = YES;
        [self populatetheVehicleView:self.amountToBePaidView];

    
//        SignInViewController * signinVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
//        [self.navigationController pushViewController:signinVC animated:YES];

}


-(void)getProfileService{
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        if (appDelegate.deviceToken == nil) {
            
            appDelegate.deviceToken = @"No Device";
            
        }
        NSDictionary * params=@{@"device_id":appDelegate.deviceIdStr,@"device_token":appDelegate.deviceToken,@"device_type":appDelegate.deviceType};

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
                    [userDefaults setObject:self.profileObjects.currencyStr forKey:@"currency"];
                    [userDefaults setObject:self.profileObjects.avatar forKey:@"avatar"];
                    [userDefaults setInteger:self.profileObjects.idStr forKey:@"id"];
                    [userDefaults setObject:self.profileObjects.device_token forKey:@"device_token"];
                    
                    if ([self.profileObjects.status isEqualToString:@"unsettle"]) {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:endStr forKey:@"ShiftStatus"];

                    }
                    
                    CURRENCY = self.profileObjects.currencyStr;
                    
                    [userDefaults synchronize];
                    
                    [self getShiftServices];

                    
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


/************************************ WEB Services Part Ends *********************/


#pragma TableView Delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.shiftsObjects.shiftEndTime != nil) {
        
        return self.shiftsObjects.shiftBreaks.count + 2;
        
    }
    return self.shiftsObjects.shiftBreaks.count + 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShiftStatusTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shiftCell"];
    
    if (indexPath.row == 0) {
        
        cell.verticalLineImg.autoresizesSubviews = NO;
        cell.verticalLineImg.hidden = YES;
        cell.numberOfOrdersLbl.hidden = YES;
        cell.startorEndLbl.text = @"START";
        cell.statusImg.image = [UIImage imageNamed:@"play"];
        cell.timingLbl.text = self.shiftsObjects.shiftStarttime;
        
    }else{
        
        if (self.shiftsObjects.shiftEndTime != nil) {
            

            if (indexPath.row == self.shiftsObjects.shiftBreaks.count + 1) {

                
                cell.verticalLineImg.autoresizesSubviews = NO;
                cell.verticalLineImg.hidden = NO;
                cell.numberOfOrdersLbl.hidden = NO;
//                cell.startorEndLbl.text = @"END";
                cell.statusImg.image = [UIImage imageNamed:@"logout"];
                cell.startorEndLbl.text = [NSString stringWithFormat:@"END SHIFT"];
                cell.timingLbl.text = self.shiftsObjects.shiftEndTime;
            
                
            } else {
                
                
                [self createBreakCell:cell atIndex:indexPath];
            }
            
        } else {
            
            [self createBreakCell:cell atIndex:indexPath];
        }
    }
    
    return cell;
}

- (void)createBreakCell:(ShiftStatusTableViewCell*)cell atIndex:(NSIndexPath*)indexPath {
    
    ShiftBreaks * breaks = self.shiftsObjects.shiftBreaks[indexPath.row - 1];
    cell.verticalLineImg.hidden = NO;
    cell.numberOfOrdersLbl.hidden = NO;
    cell.startorEndLbl.text = [NSString stringWithFormat:@"BREAK %ld",indexPath.row];
    cell.numberOfOrdersLbl.text = [NSString stringWithFormat:@"%@ ORDERS",breaks.order_count.stringValue];

    if (![breaks.shiftBreakendTimeStr isEqualToString:@""])
    {
        cell.timingLbl.text =[NSString stringWithFormat:@"%@ - %@",breaks.shiftBreakstarTimeStr,breaks.shiftBreakendTimeStr];
        
        
    }else{
        
        cell.timingLbl.text = breaks.shiftBreakstarTimeStr;
        _shiftstatusSwitch.on = YES;

    }
    
//    (indexPath.row == self.shiftsObjects.shiftBreaks.count + 1)

        if ((indexPath.row != self.shiftsObjects.shiftBreaks.count + 1))
        {
            cell.statusImg.image = [UIImage imageNamed:@"pause"];

        }
        
    
//    if (self.shiftsObjects.shiftEndTime != nil)
//    {
//        cell.statusImg.image = [UIImage imageNamed:@"logout"];
//        cell.startorEndLbl.text = [NSString stringWithFormat:@"END SHIFT"];
//        cell.timingLbl.text = breaks.shiftBreakendTimeStr;
//
//    }
//    else
//    {
//        cell.statusImg.image = [UIImage imageNamed:@"pause"];
//    }
}
#pragma Picker Delegate and DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.vehicleObjects.vehicleArr count];

}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == vehiclePickerView)
    {
        return [self.vehicleObjects.vehicleArr objectAtIndex:row];
    }
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* labelView = (UILabel*)view;
    if (!labelView)
    {
        labelView = [[UILabel alloc] init];
        [Theme regularFontlabel:labelView];
        [labelView setTextAlignment:NSTextAlignmentCenter];
        labelView.numberOfLines=1;
    }

    labelView.text = [self.vehicleObjects.vehicleArr objectAtIndex:row];
    [labelView setText:labelView.text.uppercaseString];
    return labelView;
}


/* TextField Delegate */

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    int x = self.vehiclenoEnterView.frame.origin.x;
    
    if (self.view.bounds.size.height < 667) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.vehiclenoEnterView.frame = CGRectMake(x, -80, self.vehiclenoEnterView.frame.size.width, self.vehiclenoEnterView.frame.size.height);
            [self addToolBar:self.enterTxtField];
            
        }];
        
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.vehiclenoEnterView.frame = CGRectMake(x, -60, self.vehiclenoEnterView.frame.size.width, self.vehiclenoEnterView.frame.size.height);
            [self addToolBar:self.enterTxtField];
            
        }];
        
    }
    
}

-(void)addToolBar:(UITextField *)textField{
    
    UIToolbar * numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.vehiclenoEnterView.frame.size.width, 50)];
    numberToolbar.tintColor = BASECOLOR;
    numberToolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:
                                                     UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    textField.inputAccessoryView = numberToolbar;
}

-(void)doneWithNumberPad{
    
    int x = self.vehiclenoEnterView.frame.origin.x;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.vehiclenoEnterView.frame = CGRectMake(x, 80, self.vehiclenoEnterView.frame.size.width, self.vehiclenoEnterView.frame.size.height);
        [self.enterTxtField resignFirstResponder];
    }];
    
}

- (void)getCurrentTime{
    
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    
    currentTimeStr = [formatter stringFromDate:destinationDate];
    
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
