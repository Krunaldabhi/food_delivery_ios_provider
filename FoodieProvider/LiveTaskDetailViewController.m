//
//  LiveTaskDetailViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/19/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "LiveTaskDetailViewController.h"
#import "LiveTaskDetailTableViewCell.h"
#import "OrderDetailViewController.h"
#import "LiveTaskViewController.h"
#import "OrderHistoryViewController.h"
#import "HelpViewController.h"
#import "ReportViewController.h"
#import "Theme.h"
#import "Utilities.h"
#import "UIView+Toast.h"
#import "config.h"

@interface LiveTaskDetailViewController ()< UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate , UITextViewDelegate >
{
    
    NSArray * itemsArr;
    NSArray * itemPriceArr;
    
    int count;
    int loopCount;
    
    BOOL checkBool;
    BOOL renderBool;
    UILabel * currencyLbl;
    
    NSString * checkTrackingString;
    NSArray * imagesArr;
    
    NSString * currentLat;
    NSString * currentLong;
    NSString * destinationLat;
    NSString * destinationLong;

    NSString * feedBackRatingStr;
    NSString * phoneNumberStr;
    
    UIImage * processImg;
    NSTimer * timerTOCallServer;
    NSString * checkString;
    NSDictionary * timerDic;
    
    
}

@end

@implementation LiveTaskDetailViewController
@synthesize liveTaskObj;

BOOL STARTED = NO;

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    [self acceptedOrderService:nil];
    checkString = @"Yes";
    loopCount = 1;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    checkBool = YES;
    count = 0;
    
    checkTrackingString = @"Order Received";
    
    self.trackingView.hidden = NO;
    self.cashondeliveryView.hidden = YES;
    self.feedbackView.hidden = YES;
    self.bgView.hidden = YES;
    self.disputeView.hidden = YES;
    
    feedBackRatingStr = @"1";
    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeDispute)
                                                 name:@"closeDispute"
                                               object:nil];
    
    [self getCurrentLocation];
    
    [self setArrays];
    
    self.balanceAmountLbl.text = [NSString stringWithFormat:@"%@0",CURRENCY];
}

-(void)userInterfaceDesigns{
    
    
    [Theme regularFontlabel:self.navLbl];
    [Theme regularFontlabel:self.timeLbl];
    [Theme regularFontlabel:self.timeLeftLbl];
    [Theme regularFontlabel:self.restaurentLbl];
    [Theme regularFontlabel:self.orderIdLbl];
    [Theme regularFontlabel:self.paymentMethodLbl];
    [Theme regularFontlabel:self.orderTimelbl];
    [Theme regularFontlabel:self.itemLbl];
    [Theme regularFontlabel:self.serviceTaxLbl];
    [Theme regularFontlabel:self.deliverychangesLbl];
    [Theme regularFontlabel:self.itemtotalPrice];
    [Theme regularFontlabel:self.serviceTaxPrice];
    [Theme regularFontlabel:self.deliveryLbl];
    [Theme regularFontlabel:self.discountLbl];
    [Theme regularFontlabel:self.discountAmountLbl];
    [Theme regularFontlabel:self.walletPrice];
    [Theme regularFontlabel:self.walletLbl];
    [Theme regularFontlabel:self.totalLbl];
    [Theme regularFontlabel:self.totalAmountLbl];
    [Theme regularFontlabel:self.amounttoPayLbl];
    [Theme regularFontlabel:self.entertheAmountLbl];
    [Theme regularFontlabel:self.balanceLbl];
    [Theme regularFontlabel:self.amountFrmCustomerLbl];
    [Theme regularFontlabel:self.balanceAmountLbl];
    [Theme regularFontlabel:self.feedLbl];
    [Theme regularFontlabel:self.howthedeliveryLbl];
    [Theme regularFontlabel:self.reasonLbl];
    [Theme smallLabel:self.locationLbl];
    [Theme smallLabel:self.metersAwayLbl];
    
    [self initiateSliderDesign];
    
    
    [Theme fontForTextfield:self.enterAmountTxtField];
    
    self.amountFrmCustomerLbl.textColor = BASECOLOR;
    
    self.balanceAmountLbl.textColor = BASECOLOR;
    self.paymentMethodLbl.textColor = BASECOLOR;
    self.orderIdLbl.textColor = BLACK;
    self.enterAmountTxtField.textColor = BASECOLOR;
    
    self.orderTimelbl.font = [UIFont fontWithName:FONT_SEMIBOLD size:14.0];
    self.orderTimelbl.font = [UIFont fontWithName:FONT_BOLD size:14.0];
    
    [self.orderImg setClipsToBounds:YES];
    [self.orderImg.layer setCornerRadius:4.0f];
    
    [Theme baseButton:self.acceptBtn];
    [Theme baseButton:self.paidBtn];
    [Theme baseButton:self.submitBtn];
    
    self.timeLeftLbl.hidden = YES;
    self.timeLbl.hidden = YES;

    
    [self.submitBtn setTitle:NSLocalizedString(@"SUBMITBTN", nil) forState:UIControlStateNormal];
    
    [Theme cornerRadius:nil forLabel:nil fortextfield:nil forButton:self.submitBtn];
    
    self.commentTextView.layer.borderColor = BLACK.CGColor;
    self.commentTextView.layer.borderWidth = 1.0f;
    
    [self.enterAmountTxtField addTarget:self
                                 action:@selector(textFieldDidChange:)
                       forControlEvents:UIControlEventEditingChanged];
    
    [self setBordersForViews];
    [self setTextforLabels];
    
    currencyLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 10, 30)];
    currencyLbl.textColor = BASECOLOR;
    
    self.enterAmountTxtField.leftView = currencyLbl;
    self.enterAmountTxtField.leftViewMode = UITextFieldViewModeAlways;
    
    self.metersAwayLbl.hidden = YES;
    self.timeLeftLbl.hidden = YES;
    [self.acceptBtn setTitle:NSLocalizedString(@"STARTEDBUTTON",nil) forState:UIControlStateNormal];
    
    self.currencystrLbl.text = CURRENCY;
    
    [self assignColors];
//    [self timerSequences];

}

-(void)timerSequences{
    
    timerDic = @{@"TimerStarted":@"Yes"};
    
    timerTOCallServer =  [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(acceptedOrderService:) userInfo:timerDic repeats:YES];
    checkString = @"No";

    //  timerTOupdateLocation = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(updateLocation) userInfo:nil repeats:YES];
    
}

-(void)setBordersForViews{
    
    
    [Theme circleviewDesignwithShadow:self.reachedrestaurentView];
    [Theme circleviewDesignwithShadow:self.pickedupView];
    [Theme circleviewDesignwithShadow:self.onthewayView];
    [Theme circleviewDesignwithShadow:self.reachedCustomerPlaceView];
    [Theme circleviewDesignwithShadow:self.cashwalletView];
    
    [Theme circleView:self.terribleImg];
    [Theme circleView:self.sadImg];
    [Theme circleView:self.sideMouthImg];
    [Theme circleView:self.happyImg];
    [Theme circleView:self.superbImg];
    
    [Theme foursideBorders:self.enterAmountTxtField getBottom:self.enterAmountTxtField getLeftBorder:self.enterAmountTxtField                             getRightBorder:self.enterAmountTxtField getWidth:0.5 getColor:DARKGRAYFORLINE];
    [Theme foursideBorders:self.orderIdView getBottom:self.orderIdView getLeftBorder:nil getRightBorder:nil getWidth:0.5 getColor:DARKGRAYFORLINE];
    [Theme foursideBorders:self.totalView getBottom:self.totalView getLeftBorder:nil getRightBorder:nil getWidth:0.5 getColor:DARKGRAYFORLINE];
    
    [Theme cornerRadius:self.cashondeliveryView forLabel:nil fortextfield:nil forButton:nil];
    [Theme cornerRadius:self.feedbackView forLabel:nil fortextfield:nil forButton:nil];
    
}

-(void)setTextforLabels{
    
    self.navLbl.text = NSLocalizedString(@"NAVMENULABEL", nil);
    self.timeLbl.text = NSLocalizedString(@"LIVETASKTIME", nil);
    self.timeLeftLbl.text = @"100secs";
    
    phoneNumberStr = liveTaskObj.shopObj.phone;
    self.restaurentLbl.text = liveTaskObj.shopObj.name;
    [self.restaurentLbl setText:self.restaurentLbl.text.uppercaseString];
    self.locationLbl.text = liveTaskObj.shopObj.address;
    self.orderIdLbl.text = [NSString stringWithFormat:@"#%@",liveTaskObj.orderIdStr.stringValue];
//    self.orderTimelbl.text = [NSString stringWithFormat:@"%@%@min",NSLocalizedString(@"ESTIMATIONLABEL", nil), liveTaskObj.shopObj.estimated_delivery_time.stringValue];
    self.orderTimelbl.text = [NSString stringWithFormat:@"%@",liveTaskObj.created_at];
    
    destinationLat = liveTaskObj.shopObj.latitude;
    destinationLong = liveTaskObj.shopObj.longitude;
    
    if ([liveTaskObj.invoiceObj.payment_mode isEqualToString:@"stripe"] || [liveTaskObj.invoiceObj.payment_mode isEqualToString:@"braintree"]) {
        
        self.paymentMethodLbl.text = @"Card";

    }else if ([liveTaskObj.invoiceObj.payment_mode isEqualToString:@"wallet"]) {
        
        self.paymentMethodLbl.text = @"Wallet";
        
    }else{
        
        self.paymentMethodLbl.text = @"Cash";

    }
    [self.paymentMethodLbl setText:self.paymentMethodLbl.text.uppercaseString];
    
    self.itemLbl.text = NSLocalizedString(@"ITEMTOTALLABEL", nil);
    self.serviceTaxLbl.text = NSLocalizedString(@"SERVICETAX", nil);
    self.deliveryLbl.text = NSLocalizedString(@"DELIVERYCHANGESLABEL", nil);
    self.discountLbl.text = NSLocalizedString(@"DISCOUNTLABEL", nil);
    self.totalLbl.text = NSLocalizedString(@"TOTALLABEL", nil);
    self.orderIdLbl.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"PAYMENTLABELTYPE", nil)];
    self.walletLbl.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"WALLETDEDUCTIONLABEL", nil)];
    self.walletPrice.text = @"0";

    
    [self.orderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.liveTaskObj.shopObj.avatar]] placeholderImage:[UIImage imageNamed:@"user"]];

}

-(void)assignColors{
    
    self.timeLbl.textColor = WHITE;
    self.timeLeftLbl.textColor = WHITE;
    self.locationLbl.textColor = DESCDARKCOLOR;
    self.metersAwayLbl.textColor = BASECOLOR;
    self.orderIdLbl.textColor = BLACK;
    self.orderTimelbl.textColor = DESCDARKCOLOR;
    
    self.pickedupImg.image = [self.pickedupImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.customerplaceImg.image = [self.customerplaceImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.onthewayImg.image = [self.onthewayImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.walletImg.image = [self.walletImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.pickedupImg setTintColor:BLACK];
    [self.customerplaceImg setTintColor:BLACK];
    [self.onthewayImg setTintColor:BLACK];
    [self.walletImg setTintColor:BLACK];
    
}

-(void)initiateSliderDesign
{
    
    processImg = [UIImage imageNamed:@"process_1"];
    
    [Theme regularFontlabel:self.processStateLbl];
    
    self.processStateLbl.textColor = BASECOLOR;
    self.processStateLbl.font = [UIFont fontWithName:FONT_BOLD size:14.0];

    self.processStateLbl.text =[NSString stringWithFormat:@"%@", NSLocalizedString(@"STARTEDBUTTON",nil)];
    
    processImg = [UIImage imageNamed:@"process_1"];
    [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
    [self.processSlider setMinimumTrackTintColor:[UIColor clearColor]];
    [self.processSlider setMaximumTrackTintColor:[UIColor clearColor]];
}

- (IBAction)fadetheTextAction:(id)sender {
    
    self.processStateLbl.alpha = 1.0 - (self.processSlider.value + 0.2);
    
    if ([checkTrackingString isEqualToString:@"ASSIGNED"]){

    if (self.processSlider.value >= 0.5) {
        
        processImg = [UIImage imageNamed:@"next_process_1"];
        [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
        
    }else{
        
        processImg = [UIImage imageNamed:@"process_1"];
        [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
        
    }
        
    }
    else if  ([checkTrackingString isEqualToString:@"PROCESSING"]){
        

        if (self.processSlider.value >= 0.5) {
            
            processImg = [UIImage imageNamed:@"next_process_2"];
            [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
            
        }else{
            
            processImg = [UIImage imageNamed:@"process_2"];
            [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
            
        }
        
        
    }
    else if ([checkTrackingString isEqualToString:@"REACHED"]){
        

        if (self.processSlider.value >= 0.5) {
            
            processImg = [UIImage imageNamed:@"next_process_3"];
            [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
            
        }else{
            
            processImg = [UIImage imageNamed:@"process_3"];
            [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
            
        }
        
    }
    else if ([checkTrackingString isEqualToString:@"PICKEDUP"]){
        
  
        if (self.processSlider.value >= 0.5) {
            
            processImg = [UIImage imageNamed:@"next_process_4"];
            [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
            
        }else{
            
            processImg = [UIImage imageNamed:@"process_4"];
            [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
            
        }
        
    }
    else if ([checkTrackingString isEqualToString:@"ARRIVED"]){
        
        
        if (self.processSlider.value >= 0.5) {
            
            processImg = [UIImage imageNamed:@"next_process_5"];
            [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
            
        }else{
            
            processImg = [UIImage imageNamed:@"process_5"];
            [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
            
        }
        
    }

}

-(void)processStaus:(NSString *)statusStr{
    
    if ([statusStr isEqualToString:@"ASSIGNED"]){
        
        processImg = [UIImage imageNamed:@"process_1"];
        [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
        self.processStateLbl.text =[NSString stringWithFormat:@"%@", NSLocalizedString(@"STARTEDBUTTON",nil)];
        
        checkTrackingString = statusStr;
        
        self.reachedrestaurentView.backgroundColor = UPCOMINGCOLOR;
        [self.reachedrestrntImg setTintColor:WHITE];
        
    }
    else if ([statusStr isEqualToString:@"PROCESSING"]){
        
        processImg = [UIImage imageNamed:@"process_2"];
        
        [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
        self.processStateLbl.text =[NSString stringWithFormat:@"%@", NSLocalizedString(@"REACHEDRESTAURENTBUTTON",nil)];
        checkTrackingString = statusStr;

        self.reachedrestaurentView.backgroundColor = BASECOLOR;
        [self.reachedrestrntImg setTintColor:WHITE];
        
        self.pickedupView.backgroundColor = UPCOMINGCOLOR;
        [self.pickedupImg setTintColor:WHITE];
        
    }
    else if  ([statusStr isEqualToString:@"REACHED"]){
    
        processImg = [UIImage imageNamed:@"process_3"];
        [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
        self.processStateLbl.text =[NSString stringWithFormat:@"%@", NSLocalizedString(@"ORDERPICKEDUPBTN",nil)];
        
        checkTrackingString = statusStr;

        self.pickedupView.backgroundColor = BASECOLOR;
        self.onthewayView.backgroundColor = UPCOMINGCOLOR;
        [self.onthewayImg setTintColor:WHITE];
        
        
    }
    else if ([statusStr isEqualToString:@"PICKEDUP"]){
        
        processImg = [UIImage imageNamed:@"process_4"];
        [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
        self.processStateLbl.text =[NSString stringWithFormat:@"%@", NSLocalizedString(@"ORDERDELIVEREDBTN",nil)];
        
        checkTrackingString = statusStr;

        self.onthewayView.backgroundColor = BASECOLOR;
        self.reachedCustomerPlaceView.backgroundColor = UPCOMINGCOLOR;
        [self.customerplaceImg setTintColor:WHITE];
        
        [self.orderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.liveTaskObj.userDetailsObj.avatar]] placeholderImage:[UIImage imageNamed:@"user"]];
        
        self.restaurentLbl.text = liveTaskObj.userDetailsObj.name;
        self.locationLbl.text = liveTaskObj.addressObj.map_address;
        destinationLat = liveTaskObj.addressObj.latitude;
        destinationLong = liveTaskObj.addressObj.longitude;
        phoneNumberStr = liveTaskObj.userDetailsObj.phone;
        
    }
    else if ([statusStr isEqualToString:@"ARRIVED"]){
        
        self.ordertopView.hidden = YES;
        self.trackingView.hidden = NO;
        self.reachedCustomerPlaceView.backgroundColor = BASECOLOR;
        self.cashwalletView.backgroundColor = UPCOMINGCOLOR;
        [self.walletImg setTintColor:WHITE];
        
        count = 1;
        
        if (liveTaskObj.invoiceObj.paid.integerValue == 1) {
            
            [self orderProcessing:@"COMPLETED"];
            

        }else{
        
            if (loopCount == 1) {
                
                [self amountViewappears];
                
            }else{
                
                
            }
            
        }
        
    }
    else if ([statusStr isEqualToString:@"COMPLETED"]){
        if (timerTOCallServer != nil) {
            
            [timerTOCallServer invalidate];
            timerTOCallServer = nil;
        }

        [self feedBackViewappears];

    }

}

- (IBAction)sliderValueChangedAction:(id)sender {
    
    if (self.processSlider.value == 1)
    {
        if ([checkTrackingString isEqualToString:@"ASSIGNED"]){
            
            [self orderProcessing:@"PROCESSING"];
            
        }
        else if  ([checkTrackingString isEqualToString:@"PROCESSING"]){
            
            [self orderProcessing:@"REACHED"];
            
        }
        else if ([checkTrackingString isEqualToString:@"REACHED"]){
            
            [self orderProcessing:@"PICKEDUP"];
            
        }
        else if ([checkTrackingString isEqualToString:@"PICKEDUP"]){
            
            [self orderProcessing:@"ARRIVED"];
            
        }
        else if ([checkTrackingString isEqualToString:@"COMPLETED"]){
            
            
        }
        
        self.processSlider.value = 0;
        self.processStateLbl.alpha = 1.0;
    }
    else
    {
        self.processSlider.value = 0;
    }
}

-(void)setArrays{
    
    itemsArr = [[NSArray alloc]initWithObjects:@"Spicy Prawn Tikka * 1",@"Spicy Fish Tikka * 1", nil];
    
    itemPriceArr = [[NSArray alloc]initWithObjects:@"$150",@"$150", nil];
    
//    imagesArr = [[NSArray alloc]initWithObjects:@"image_1",@"image_2",@"image_3",@"image_4",@"image_5", nil];
    
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

        NSLog(@"The latitude value is - %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        NSLog(@"The logitude value is - %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
    }

}


#pragma TextField and TextView Delegate

-(void)textFieldDidChange :(UITextField *)textField{
    
    if (textField.text.length == 0) {
        
        self.balanceAmountLbl.text =[NSString stringWithFormat:@"%@0",CURRENCY];
        NSLog(@"%@",self.balanceAmountLbl.text);

    }else if ([textField.text isEqualToString:@"0"]) {
        
        self.balanceAmountLbl.text =[NSString stringWithFormat:@"%@0",CURRENCY];
        NSLog(@"%@",self.balanceAmountLbl.text);
        
    }
    else{
        
        self.balanceAmountLbl.text =[NSString stringWithFormat:@"%@%@",CURRENCY,[self makeSubraction:self.enterAmountTxtField.text getSecond:self.amountFrmCustomerLbl.text]];
        NSLog(@"%@",self.balanceAmountLbl.text);
    }

    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    int x = self.cashondeliveryView.frame.origin.x;
    
    if (self.view.bounds.size.height < 667) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.cashondeliveryView.frame = CGRectMake(x, -30, self.cashondeliveryView.frame.size.width, self.cashondeliveryView.frame.size.height);
            [self addToolBar:self.enterAmountTxtField];
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.cashondeliveryView.frame = CGRectMake(x, -10, self.cashondeliveryView.frame.size.width, self.cashondeliveryView.frame.size.height);
            [self addToolBar:self.enterAmountTxtField];
            
        }];
        
    }
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    int x = self.feedbackView.frame.origin.x;
    
    if (self.view.bounds.size.height < 667) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.feedbackView.frame = CGRectMake(x, -30, self.feedbackView.frame.size.width, self.feedbackView.frame.size.height);
        }];
        
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.feedbackView.frame = CGRectMake(x, -20, self.feedbackView.frame.size.width, self.feedbackView.frame.size.height);
        }];
        
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    int x = self.feedbackView.frame.origin.x;
    
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        self.feedbackView.frame = CGRectMake(x, 90, self.feedbackView.frame.size.width, self.feedbackView.frame.size.height);
        
        return NO;
    }
    
    return YES;
}

-(void)addToolBar:(UITextField *)textField{
    
    UIToolbar * numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.cashondeliveryView.frame.size.width, 50)];
    numberToolbar.tintColor = BASECOLOR;
    numberToolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:
                                                     UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    textField.inputAccessoryView = numberToolbar;
}

-(void)doneWithNumberPad{
    
    int x = self.cashondeliveryView.frame.origin.x;
    
    if (self.enterAmountTxtField.text.length == 0) {
        
        self.balanceAmountLbl.text = [NSString stringWithFormat:@"%@0",CURRENCY];
        
    }
    else{
        
        self.balanceAmountLbl.text = [self makeSubraction:self.enterAmountTxtField.text getSecond:self.amountFrmCustomerLbl.text];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.cashondeliveryView.frame = CGRectMake(x, 90, self.cashondeliveryView.frame.size.width, self.cashondeliveryView.frame.size.height);
        [self.enterAmountTxtField resignFirstResponder];
    }];
}

#pragma Tableview Delegate and Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return liveTaskObj.itemsArray.count;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveTaskDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"liveCell"];
    
    ItemsObj * items = liveTaskObj.itemsArray[indexPath.row];
    
    NSString * str = [NSString stringWithFormat:@"%@", [items.cartObj.nameArr componentsJoinedByString:@", "]];
    NSNumber * addOnAmount;
    
    
    if ([str isEqualToString:@""]) {
        
        addOnAmount = 0;

    }else{
        
//        addOnAmount = items.cartObj.totalAddOnAmountArr[indexPath.row];
          addOnAmount = items.cartObj.overallwithAddedAmnt;


    }
    
    
    if (items.cartObj.nameArr.count == 0) {
        
        cell.addOnsLbl.hidden = NO;
        cell.addOnsLbl.text = @"";
        
    }else{
        
        cell.addOnsLbl.hidden = NO;
        cell.addOnsLbl.text = str;
        
    }
    
    if (items.cartObj.nameArr == 0) {
        
        cell.addOnsLbl.hidden = NO;
        cell.addOnsLbl.text = @"";

    }else{
        
        cell.addOnsLbl.hidden = NO;
        cell.addOnsLbl.text = str;

    }
    
    NSInteger itemPrice = addOnAmount.integerValue + items.productObj.priceObj.price.integerValue;
    NSInteger overallItemPrice = itemPrice * items.quantity.integerValue;
    NSLog(@"%ld",(long)overallItemPrice);
    
    NSLog(@"Your add on name is :---> %@",str);

    cell.addOnsLbl.text = str;
    cell.itemName.text = [NSString stringWithFormat:@"%@", items.productObj.name];
    
    cell.itemQuantity.text = [items.quantity stringValue];
//    cell.itemPrice.text = [NSString stringWithFormat:@"%@%@",
//                           CURRENCY,items.productObj.priceObj.price.stringValue];
    
    cell.itemPrice.text = [NSString stringWithFormat:@"%@%ld",CURRENCY,(long)overallItemPrice];
    
    /***** Update Footer field Text  *******/
    
   
    self.itemtotalPrice.text = [NSString stringWithFormat:@"%@%@",
                                CURRENCY,liveTaskObj.invoiceObj.gross.stringValue];
    
//    int rounded = [self roundToNearest:liveTaskObj.invoiceObj.tax.intValue];
//    float theFloat = ;
//    int rounded = roundf(theFloat); NSLog(@"%d",rounded);
//    int roundedUp = ceil(theFloat); NSLog(@"%d",roundedUp);
//    int roundedDown = floor(theFloat); NSLog(@"%d",roundedDown);
    
    
    self.serviceTaxPrice.text = [NSString stringWithFormat:@"%@%@",CURRENCY,liveTaskObj.invoiceObj.tax.stringValue];
    self.deliverychangesLbl.text =[NSString stringWithFormat:@"%@%@",CURRENCY,liveTaskObj.invoiceObj.delivery_charge.stringValue];
    self.discountAmountLbl.text =[NSString stringWithFormat:@"%@%@",CURRENCY,liveTaskObj.invoiceObj.discount.stringValue];
    self.walletPrice.text =[NSString stringWithFormat:@"%@%@",CURRENCY,liveTaskObj.invoiceObj.wallet_amount.stringValue];
    
    NSDictionary * disputeDic = @{@"OrderId":liveTaskObj.orderIdStr.stringValue,@"Dispute_No":liveTaskObj.disputeObj.phone};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getdata" object:nil userInfo:disputeDic];

    
    /****** Amount View ******/
    
    self.amountFrmCustomerLbl.text = [NSString stringWithFormat:@"%@%@", CURRENCY,liveTaskObj.invoiceObj.payable.stringValue];
    self.totalAmountLbl.text = [NSString stringWithFormat:@"%@%@",
                                CURRENCY,liveTaskObj.invoiceObj.payable.stringValue];
    currencyLbl.text = CURRENCY;
//    self.balanceAmountLbl.text = [NSString stringWithFormat:@"%@0",CURRENCY];


    return cell;
    
}

- (NSInteger)roundToNearest:(NSInteger)inputNum
{
    if (inputNum < 100){
        return roundf(inputNum / 5.0f) * 5;
    }
    else {
        return roundf(inputNum / 10.0f) * 10;
    }
}


- (IBAction)menuAction:(id)sender {
    
    UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:nil
                                                                          message:nil
                                                                   preferredStyle:UIAlertControllerStyleActionSheet];
    /*
    UIAlertAction * report = [UIAlertAction actionWithTitle:NSLocalizedString(@"REPORTNAVLABEL", nil)
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                              {
                                  ReportViewController * reportVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportViewController"];
                                  reportVC.titleStr = @"REPORT";
                                  [self.navigationController pushViewController:reportVC animated:YES];
                                  
                              }];
    */
    
    
    UIAlertAction *dispute = [UIAlertAction actionWithTitle:NSLocalizedString(@"DISPUTENAVLABEL", nil)
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                              {
//                                  ReportViewController * reportVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportViewController"];
//                                  reportVC.titleStr = @"DISPUTE";
//                                  [self.navigationController pushViewController:reportVC animated:YES];
                                  
                                  [self showDispute];
                                  
                              }];
    /*
    UIAlertAction * help = [UIAlertAction actionWithTitle:NSLocalizedString(@"HELPNAVLABEL", nil)
                                                    style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                            {
                                ReportViewController * reportVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportViewController"];
                                reportVC.titleStr = @"HELP";
                                [self.navigationController pushViewController:reportVC animated:YES];
                                
                            }];
    */
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel handler:^(UIAlertAction * action)
                             {
                                 [self dismissViewControllerAnimated:YES completion:NULL];
                             }];
    
//    [actionSheet addAction:report];
    [actionSheet addAction:dispute];
//    [actionSheet addAction:help];
    [actionSheet addAction:cancel];
    
    
    [actionSheet.view setTintColor:BASECOLOR];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(void)showDispute{
    
    [AnimationView alertViewAnimation:self.disputeView bgView:self.bgView];
    
}

-(void)closeDispute{
    
    [AnimationView closePopUp:self.disputeView bgView:self.bgView];
    
}

- (IBAction)acceptAction:(id)sender {
    
    if ([checkTrackingString isEqualToString:@"Order Received"]){
        
        self.ordertopView.hidden = YES;
        self.trackingView.hidden = NO;
        
        [self.acceptBtn setTitle:NSLocalizedString(@"REACHEDRESTAURENTBUTTON", nil) forState:UIControlStateNormal];
        checkTrackingString = NSLocalizedString(@"REACHEDRESTAURENTBUTTON", nil);
        
        [self orderProcessing:@"PROCESSING"];
        
        self.metersAwayLbl.hidden = YES;
        
    }
    else if ([checkTrackingString isEqualToString:@"REACHED RESTAURENT"]){
        
        self.ordertopView.hidden = YES;
        self.trackingView.hidden = NO;
        
        [self orderProcessing:@"REACHED"];

        
        [self.acceptBtn setTitle:NSLocalizedString(@"ORDERPICKEDUPBTN", nil) forState:UIControlStateNormal];
        checkTrackingString = NSLocalizedString(@"ORDERPICKEDUPBTN", nil);
        
        self.pickedupView.backgroundColor = BASECOLOR;
        self.onthewayView.backgroundColor = UPCOMINGCOLOR;
        [self.onthewayImg setTintColor:WHITE];
        
        
    }
    else if ([checkTrackingString isEqualToString:@"ORDER PICKED UP"]){
        
        self.ordertopView.hidden = YES;
        self.trackingView.hidden = NO;
        
        [self orderProcessing:@"PICKEDUP"];

        
        [self.acceptBtn setTitle:NSLocalizedString(@"ORDERDELIVEREDBTN", nil) forState:UIControlStateNormal];
        checkTrackingString = NSLocalizedString(@"ORDERDELIVEREDBTN", nil);
        
        self.onthewayView.backgroundColor = BASECOLOR;
        self.reachedCustomerPlaceView.backgroundColor = UPCOMINGCOLOR;
        [self.customerplaceImg setTintColor:WHITE];
        
        [self.orderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.liveTaskObj.userDetailsObj.avatar]] placeholderImage:[UIImage imageNamed:@"user"]];
        
        self.restaurentLbl.text = liveTaskObj.userDetailsObj.name;
        self.locationLbl.text = liveTaskObj.addressObj.map_address;
        destinationLat = liveTaskObj.addressObj.latitude;
        destinationLong = liveTaskObj.addressObj.longitude;
        phoneNumberStr = liveTaskObj.userDetailsObj.phone;

        
        
    }
    else if ([checkTrackingString isEqualToString:@"ORDER DELIVERED"]){
        
        self.ordertopView.hidden = YES;
        self.trackingView.hidden = NO;
        
        [self orderProcessing:@"ARRIVED"];
        
        self.reachedCustomerPlaceView.backgroundColor = BASECOLOR;
        self.cashwalletView.backgroundColor = UPCOMINGCOLOR;
        [self.walletImg setTintColor:WHITE];
        
        count = 1;
        
        [self amountViewappears];
        
    }
    else if ([checkTrackingString isEqualToString:@"COMPLETED"]){
        
        [self nextScreenVC];
        
    }
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInView:self.view];
    CGRect fingerRect = CGRectMake(location.x-5, location.y-5, 10, 10);
    
    for(UIView *view in self.view.subviews){
        CGRect subviewFrame = view.frame;
        
        if(CGRectIntersectsRect(fingerRect, subviewFrame)){
            //we found the finally touched view
            [self doneWithNumberPad];
        }
        
    }
    
}

-(void)amountViewappears{
    
    [self callPopView:self.cashondeliveryView];
    loopCount = 2;
    
}

-(IBAction)paidAction:(id)sender{
    
    NSString * getStr = self.amountFrmCustomerLbl.text;
    NSString * removeStr = [getStr stringByReplacingOccurrencesOfString:CURRENCY withString:@""];
    
    if (self.enterAmountTxtField.text.length == 0) {
        
        [self.cashondeliveryView makeToast:NSLocalizedString(@"PAYMENTALERT", nil)];
    }
    else if ([self.enterAmountTxtField.text intValue] < [removeStr intValue]){
        
        [self.cashondeliveryView makeToast:NSLocalizedString(@"CORRECTAMOUNT", nil)];
        
    }else{

        
        [self closePopUp:self.cashondeliveryView];
        
        [self orderProcessing:@"COMPLETED"];
        
        self.ordertopView.hidden = YES;
        self.trackingView.hidden = NO;
        
        count = 2;
        
        processImg = [UIImage imageNamed:@"process_5"];
        [self.processSlider setThumbImage: processImg forState:UIControlStateNormal];
        self.processStateLbl.text =[NSString stringWithFormat:@"%@", NSLocalizedString(@"COMPLETEDLABEL",nil)];
        
        checkTrackingString = NSLocalizedString(@"COMPLETEDLABEL", nil);
        self.reachedCustomerPlaceView.backgroundColor = BASECOLOR;
        self.cashwalletView.backgroundColor = BASECOLOR;
        
    }
}

-(void)feedBackViewappears{
    
    [self callPopView:self.feedbackView];
    
    
}


- (IBAction)tapAction:(id)sender {
    
    if (count == 1) {
        
        [self doneWithNumberPad];
//        [self closePopUp:self.cashondeliveryView];
    }else{
        
        [self doneWithNumberPad];
//        [self closePopUp:self.feedbackView];
    }
    
}

- (IBAction)hideKeyboardAction:(id)sender {
    
    if (count == 1) {
        
        [self doneWithNumberPad];
        [self closePopUp:self.cashondeliveryView];
        
    }else{
        
        [self doneWithNumberPad];
        [self.commentTextView resignFirstResponder];
    }
    
}

- (IBAction)emoticonAction:(id)sender {
    /*
    for (int i = 0; i < 5; i++) {
        
        if (i == [sender tag]) {

            self.terribleImg.backgroundColor = BASECOLOR;
            self.terribleImg.image = [self.terribleImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.terribleImg setTintColor:BLACK];
            
        }else{
            
            self.terribleImg.backgroundColor = WHITE;
            self.terribleImg.image = [self.terribleImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
    }

    */
    if ([sender tag] == 1) {
        
        self.terribleImg.backgroundColor = BASECOLOR;
        [self.terribleImg setTintColor:BLACK];
        self.terribleImg.image = [self.terribleImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        self.sadImg.image = [self.sadImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.sideMouthImg.image = [self.sideMouthImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.happyImg.image = [self.happyImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.superbImg.image = [self.superbImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.sadImg.backgroundColor = WHITE;
        self.sideMouthImg.backgroundColor = WHITE;
        self.happyImg.backgroundColor = WHITE;
        self.superbImg.backgroundColor = WHITE;
        
        feedBackRatingStr = @"1";

        
    }else if ([sender tag] == 2) {
        
        self.sadImg.backgroundColor = BASECOLOR;
        [self.sadImg setTintColor:BLACK];
        self.sadImg.image = [self.sadImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        self.terribleImg.image = [self.terribleImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.sideMouthImg.image = [self.sideMouthImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.happyImg.image = [self.happyImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.superbImg.image = [self.superbImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.terribleImg.backgroundColor = WHITE;
        self.sideMouthImg.backgroundColor = WHITE;
        self.happyImg.backgroundColor = WHITE;
        self.superbImg.backgroundColor = WHITE;
        
        feedBackRatingStr = @"2";

        
    }else if ([sender tag] == 3) {
        
        self.sideMouthImg.backgroundColor = BASECOLOR;
        [self.sideMouthImg setTintColor:BLACK];
        self.sideMouthImg.image = [self.sideMouthImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        self.terribleImg.image = [self.terribleImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.sadImg.image = [self.sadImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.happyImg.image = [self.happyImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.superbImg.image = [self.superbImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.terribleImg.backgroundColor = WHITE;
        self.sadImg.backgroundColor = WHITE;
        self.happyImg.backgroundColor = WHITE;
        self.superbImg.backgroundColor = WHITE;
        
        feedBackRatingStr = @"3";

        
    }else if ([sender tag] == 4) {
        
        self.happyImg.backgroundColor = BASECOLOR;
        [self.happyImg setTintColor:BLACK];
        self.happyImg.image = [self.happyImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        self.terribleImg.image = [self.terribleImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.sadImg.image = [self.sadImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.superbImg.image = [self.superbImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.sideMouthImg.image = [self.sideMouthImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.terribleImg.backgroundColor = WHITE;
        self.sadImg.backgroundColor = WHITE;
        self.sideMouthImg.backgroundColor = WHITE;
        self.superbImg.backgroundColor = WHITE;
        
        feedBackRatingStr = @"4";

        
    }else{
        
        self.superbImg.backgroundColor = BASECOLOR;
        [self.superbImg setTintColor:BLACK];
        self.superbImg.image = [self.superbImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        self.terribleImg.image = [self.terribleImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.sadImg.image = [self.sadImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.happyImg.image = [self.happyImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.sideMouthImg.image = [self.sideMouthImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.terribleImg.backgroundColor = WHITE;
        self.sadImg.backgroundColor = WHITE;
        self.sideMouthImg.backgroundColor = WHITE;
        self.happyImg.backgroundColor = WHITE;
        
        feedBackRatingStr = @"5";

    }
    
}
- (IBAction)callAction:(id)sender {
    
    NSString * phoneNumber = [@"tel://" stringByAppendingString:[NSString stringWithFormat:@"%@",phoneNumberStr]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber] options:@{@"":@""} completionHandler:nil];
     
}

- (IBAction)submitAction:(id)sender {
    
    [self ratingService];
    
}

- (IBAction)navigateAction:(id)sender {

    NSLog(@"%@, %@, %@, %@", currentLat, currentLong, liveTaskObj.addressObj.latitude, liveTaskObj.addressObj.longitude);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?saddr=%@,%@&daddr=%@,%@&dirflg=r",currentLat, currentLong, destinationLat,destinationLong]];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://?"]])
    {
        [[UIApplication sharedApplication] openURL:url options:@{@"":@""} completionHandler:nil];
    }
    else
    {
//        [Utilities showAlert:@"Please install Google maps to Navigate"];
        NSLog(@"Can't use comgooglemaps://");
    }
}

/******************** WEB SERVICE PART **********************/


-(void)acceptedOrderService:(NSTimer *)timer{
    
    if ([Reachability reachabilityForInternetConnection]) {
       

        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        
        if ([timer.userInfo[@"TimerStarted"] isEqualToString:@"Yes"]) {
            
            afn.loaderRequestStr = @"Hide";
            
        }else{
            
            
        }
        
        [afn getDataFromPath:MD_GETORDER withParamData:nil withBlock:^(NSArray * response, NSDictionary *Error,NSString *strCode) {
            
            [self.appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"Live onProcess response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (response.count == 0) {
                        [timerTOCallServer invalidate];
                        timerTOCallServer = nil;
                        FCAlertView *alert = [[FCAlertView alloc] init];
                        
                        [alert showAlertWithTitle:nil
                                     withSubtitle:@"User Cancelled the request"
                                  withCustomImage:nil
                              withDoneButtonTitle:@"OK"
                                       andButtons:nil];
                        alert.colorScheme = BASECOLOR;
                        alert.doneButtonTitleColor = [UIColor whiteColor];
                        alert.animateAlertOutToBottom = YES;
                        alert.hideSeparatorLineView = NO;
                        alert.animateAlertInFromTop = YES;
                        alert.subtitleFont = [UIFont fontWithName:FONT_REGULAR size:14.0];
                        
                            [alert doneActionBlock:^{
                                
                                [self nextScreenVC];
                            }];
                            //                            [Utilities showAlert:@"User Cancelled the request"];

                    }else{
                        
                        if (timerTOCallServer == nil) {
                           
                            [self timerSequences];

                        }

                    liveTaskObj = [[LiveTaskObj alloc]initWithDictionary:response[0]];
                    
                    [self userInterfaceDesigns];
                    
                    self.whiteView.hidden = YES;

                    [self.itemListTblView reloadData];
                    
                    if (liveTaskObj.ordersArr != 0) {
                        
                        for (int i = 0; i < [liveTaskObj.ordersArr count]; i++) {
                            
                            Orders * orderObj = (Orders *)[liveTaskObj.ordersArr objectAtIndex:i];
                            
                            NSString * currentStatus = [NSString stringWithFormat:@"%@",orderObj.status];
                            
//                            if ([currentStatus isEqualToString:@"ARRIVED"]) {
//
//                                if (liveTaskObj.invoiceObj.paid.integerValue == 1) {
//
//                                    [self processStaus:@"COMPLETED"];
//
//                                }else{
                            
                                    [self processStaus:currentStatus];

//                                }
//                            else{
//
//                                [self processStaus:currentStatus];

//                            }
                            
                        }
                    }else{
                        
                                [self processStaus:liveTaskObj.status];

                    }
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


-(void)orderProcessing:(NSString *)statusStr{
    
    NSDictionary * params;
    params = @{@"status":statusStr};
    
    if ([statusStr isEqualToString:@"COMPLETED"]) {
       
        NSString * balanceStr = [self.balanceAmountLbl.text stringByReplacingOccurrencesOfString:CURRENCY withString:@""];

        [timerTOCallServer invalidate];
        timerTOCallServer = nil;
        
        params = @{@"status":statusStr,@"total_pay":self.enterAmountTxtField.text,@"tender_pay":balanceStr,@"payment_mode":@"cash",@"payment_status":@"success"};
    }
    
    NSString * urlPath = [NSString stringWithFormat:@"%@/%@",MD_GETORDER,liveTaskObj.orderIdStr];

    
    if ([Reachability reachabilityForInternetConnection]) {
        
        [self.appDelegate onStartLoader];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:PATCH_METHOD];
        [afn getDataFromPath:urlPath withParamData:params withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            [self.appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"Live onProcess response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    if ([statusStr isEqualToString:@"COMPLETED"]) {
                        
                        
                        [self feedBackViewappears];
                    }
                    
                    liveTaskObj = [[LiveTaskObj alloc]initWithDictionary:response];
                    
//                    if ([statusStr isEqualToString:@"ARRIVED"]) {
//
//                        if (liveTaskObj.invoiceObj.paid.integerValue == 1) {
//
//                            [self processStaus:@"COMPLETED"];
//
//                        }else{
//
//                            [self processStaus:liveTaskObj.status];
//
//                        }
//                    }else{
                    
                        [self processStaus:liveTaskObj.status];

//                    }
                    
                    
                    
                    [self.itemListTblView reloadData];
                    
                    
                });
            }
            
            else
            {
                
                NSString * errorStr = [NSString stringWithFormat:@"%@",Error[@"tender_pay"]];
                
                [Utilities showAlert:errorStr];
                [self amountViewappears];
                
            }
        }];
    }else{
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
}

-(void)ratingService{
    
        NSDictionary * params = @{@"order_id":liveTaskObj.orderIdStr,@"rating":feedBackRatingStr,@"comment":self.commentTextView.text};
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        
        [self.appDelegate onStartLoader];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:MD_SENDRATING withParamData:params withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            [self.appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"Live onProcess response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self nextScreenVC];

                });
            }
            
            else
            {
                
                NSString * errorStr = [NSString stringWithFormat:@"%@",Error[@"tender_pay"]];
                
                [Utilities showAlert:errorStr];
                
            }
        }];
    }else{
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
    
}

-(void)nextScreenVC{
    
    LiveTaskViewController * homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveTaskViewController"];
    [self.navigationController pushViewController:homeVC animated:YES];
}

/******************** WEB SERVICE PART END **********************/


/***** POPUP VIEW ANIMATION ******/

/****** Starts AlertView ***/

-(void)callPopView:(UIView *)popView{
    
    
    /**** Custom AlertView Starts ******/
    
    float duration = 0.3/popView.frame.size.width*fabs(popView.center.x)+ 0.3/2;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         popView.hidden = NO;
                         self.bgView.hidden = NO;
                         
                     }
                     completion:nil];
    
    
    [self initialDelayEnded:popView];
    
}

-(void)initialDelayEnded:(UIView *)getView {
    
    if (count == 1) {
        
        self.cashondeliveryView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        self.cashondeliveryView.alpha = 1.0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3/1.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
        self.cashondeliveryView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        [UIView commitAnimations];
        
    }else{
        
        self.feedbackView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        self.feedbackView.alpha = 1.0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3/1.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
        self.feedbackView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        [UIView commitAnimations];
    }
}

- (void)bounce1AnimationStopped{
    
    
    if (count == 1) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3/2];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
        self.cashondeliveryView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        [UIView commitAnimations];
        
    }else{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3/2];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
        self.feedbackView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        [UIView commitAnimations];
        
    }
    
    
}



- (void)bounce2AnimationStopped{
    
    if (count == 1) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3/2];
        self.cashondeliveryView.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];
        
    }else{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3/2];
        self.feedbackView.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];
    }
}

-(void)closePopUp:(UIView *)closeView{
    
    float duration = 0.3/closeView.frame.size.width*fabs(closeView.center.x)+ 0.3/2;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         closeView.hidden = YES;
                         
                         self.bgView.hidden = YES;
                         [self.view endEditing:YES];
                     }
                     completion:nil];
}

/************** AlertView Ends ************/


-(NSString *)makeSubraction:(NSString *)firstStr getSecond:(NSString *)secondStr{
    
    NSString * getStr = secondStr;
    NSString * firstremoveStr = [getStr stringByReplacingOccurrencesOfString:CURRENCY withString:@""];
    NSString * secondremoveStr = [firstStr stringByReplacingOccurrencesOfString:CURRENCY withString:@""];
    int result = [secondremoveStr intValue] - [firstremoveStr intValue];
    NSString * getSubractedStr = [NSString stringWithFormat:@"%d", result];
    
    return getSubractedStr;
    
}

-(UIImage *)changeTheColor:(UIImage *)getImage{
    
    UIImage *image = getImage;
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, BLACK.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    return flippedImage;
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
