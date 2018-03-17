//
//  OrderHistoryViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "OrderListTableViewCell.h"
#import "OrderDetailViewController.h"
#import "Theme.h"
#import "config.h"

@interface OrderHistoryViewController ()<UITableViewDataSource, UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    
    NSArray * restaurentNameArr;
    NSArray * orderidArr;
    NSArray * statusArr;
    NSArray * timeArr;
    
    UIView * orderViewContainer;
    UIPickerView * orderPickerView;
    UIView * backgroundView;
    NSString * orderStr;
    


}
@end

@implementation OrderHistoryViewController
@synthesize liveTaskObj;

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self getOrderHistoryService];
    
    [self setArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    orderViewContainer                 = [[UIView alloc] init];
    orderPickerView                    = [[UIPickerView alloc] init];
    orderViewContainer.backgroundColor = [UIColor whiteColor];
    
    [orderPickerView setDataSource:self];
    [orderPickerView setDelegate:self];
    
    [self userInterfaceDesgin];
}

-(void)userInterfaceDesgin{
    
    [Theme regularFontlabel:self.navLbl];
    [Theme regularFontlabel:self.daytodayLbl];
    [Theme regularSemiBoldFontlabel:self.noresultLbl];

    
    self.navLbl.text = NSLocalizedString(@"ORDERNAVLABEL", nil);
    self.noresultLbl.text = NSLocalizedString(@"NORESULTFOUNDLABEL", nil);
        
    self.daytodayLbl.font = [UIFont fontWithName:FONT_BOLD size:16.0];
    self.noresultLbl.font = [UIFont fontWithName:FONT_BOLD size:18.0];

    
    [Theme foursideBorders:nil getBottom:self.daytoDayView getLeftBorder:nil getRightBorder:nil getWidth:0.5 getColor:DARKGRAYFORLINE];
    
    self.noResultView.hidden = YES;
    
//    NORESULTFOUNDLABEL

    
}


-(void)setArray{
    
    timeArr = [[NSArray alloc]initWithObjects:@"Today",@"This Week",@"This Month", nil];
    
}

-(void)getOrderHistoryService{
    
    NSDictionary * params;
    
    if (orderStr != nil) {
        
        if ([orderStr isEqualToString:@"Today"]) {
        
            params = @{@"type":@"today"};
            
        }else if([orderStr isEqualToString:@"This Week"]) {
            
            params = @{@"type":@"weekly"};

        }else{
            
            params = @{@"type":@"monthly"};

        }
    }else{
        
        params = nil;
    }
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        [self.appDelegate onStartLoader];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        [afn getDataFromPath:MD_GETORDERHISTORYLIST withParamData:params withBlock:^(NSArray * response, NSDictionary *Error,NSString *strCode) {
            
            [self.appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"Shift onProcess response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (response.count != 0) {
                        self.orderlistTableView.hidden = NO;
                        self.noResultView.hidden = YES;
                        self.ordersArr = [[NSMutableArray alloc]init];
                        
                        for (int i = 0; i < [response count]; i++) {

                            liveTaskObj = [[LiveTaskObj alloc]initWithDictionary:[response objectAtIndex:i]];
                            
                            [self.ordersArr addObject:liveTaskObj];

                        }
                        
                        [self.orderlistTableView reloadData];
                        
                    }else{
                        
                     self.orderlistTableView.hidden = YES;
                        self.noResultView.hidden = NO;
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

- (IBAction)daytodayAction:(id)sender {
    
    [self showHistoryAction];
}

-(void)showHistoryAction{
    
    orderViewContainer.frame          = CGRectMake(0, (self.view.bounds.size.height)-180, self.view.bounds.size.width, 180);
    orderViewContainer.layer.cornerRadius   = 10;
    
    orderPickerView.frame                   = CGRectMake(0, 0, self.view.frame.size.width, 160);
    orderPickerView.hidden                  = NO;
    orderPickerView.showsSelectionIndicator = YES;
    orderPickerView.tintColor = BASECOLOR;
    
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
    cancelPickerBtn.frame = CGRectMake(orderPickerView.frame.size.width-140, 140, 140, 40);
    [cancelPickerBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelPickerBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
    cancelPickerBtn.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14];
    
    
    [orderViewContainer addSubview:orderPickerView];
    [orderViewContainer addSubview:cancelPickerBtn];
    [orderViewContainer addSubview:setBtn];
    
    [self.view addSubview:orderViewContainer];
}

-(void)setVehicle
{
    orderStr = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:[orderPickerView selectedRowInComponent:0]]];
    
    self.daytodayLbl.text = orderStr;
    
    [self getOrderHistoryService];
    //    [self.vehiclenoBtn setTitle:vehicleStr forState:UIControlStateNormal];
    [self cancelVehicle];
}

-(void)cancelVehicle
{
    [orderViewContainer removeFromSuperview];
    [backgroundView removeFromSuperview];
}


#pragma Picker Delegate and DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [timeArr count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == orderPickerView)
    {
        return [timeArr objectAtIndex:row];
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
    
    labelView.text = [timeArr objectAtIndex:row];
    [labelView setText:labelView.text.uppercaseString];
    return labelView;
}

#pragma Tableview Delegate and Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
        return 1;
        
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

        return [self.ordersArr count];

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    
    LiveTaskObj * taskObj = (LiveTaskObj *)[self.ordersArr objectAtIndex:indexPath.row];
    
    cell.restaurentLbl.text = taskObj.shopObj.name;
    cell.orderIdLbl.text =  [NSString stringWithFormat:@"#%@",taskObj.orderIdStr.stringValue];
    [cell.orderImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",taskObj.shopObj.avatar]] placeholderImage:[UIImage imageNamed:@"user"]];
    cell.statusLbl.text = taskObj.status;
    cell.noofItems.text = [NSString stringWithFormat:@"%lu Items",(unsigned long)taskObj.itemsArray.count];
    cell.amountLbl.text = [NSString stringWithFormat:@"%@%@",CURRENCY,taskObj.invoiceObj.net.stringValue ];
    cell.timeLbl.text = taskObj.created_at;

    cell.listContentView.layer.cornerRadius = 4.0f;
    cell.listContentView.clipsToBounds = YES;
    
    cell.listContentView.layer.shadowOffset = CGSizeMake(0, 0);
    cell.listContentView.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.listContentView.layer.shadowRadius = 2;
    cell.listContentView.layer.shadowOpacity =0.2;
    cell.listContentView.layer.masksToBounds = NO;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveTaskObj * taskObj = (LiveTaskObj *)[self.ordersArr objectAtIndex:indexPath.row];

    OrderDetailViewController * orderDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderDetailViewController"];
    orderDetailVC.liveTaskObj = taskObj;
    
    [self.navigationController pushViewController:orderDetailVC animated:YES];
    
    
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
