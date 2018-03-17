//
//  OrderDetailViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "LiveTaskDetailTableViewCell.h"

#import "Theme.h"


@interface OrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
    NSArray * itemsArr;
    NSArray * itemPriceArr;
}

@end

@implementation OrderDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.mainView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 1000)];
    [self.scrollView addSubview:self.mainView];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(self.mainView.frame.size.width, self.mainView.frame.size.height)];
    
    [self userInterfaceDesign];
}

-(void)userInterfaceDesign{
    
    [Theme regularFontlabel:self.OrderIdLbl];
    self.OrderIdLbl.font = [UIFont fontWithName:FONT_BOLD size:14.0];
    
    [Theme regularFontlabel:self.destinationLbl];
    [Theme regularFontlabel:self.sourceLbl];
    [Theme regularFontlabel:self.orderIDINLbl];
    [Theme regularFontlabel:self.timeLbl];
    [Theme regularFontlabel:self.paymentLbl];
    [Theme regularFontlabel:self.paymentMethodLbl];
    
    [Theme regularSemiBoldFontlabel:self.itemLbl];
    [Theme regularSemiBoldFontlabel:self.serviceTaxLbl];
    [Theme regularSemiBoldFontlabel:self.deliverychangesLbl];
    [Theme regularSemiBoldFontlabel:self.itemtotalPrice];
    [Theme regularSemiBoldFontlabel:self.serviceTaxPrice];
    [Theme regularSemiBoldFontlabel:self.deliveryLbl];
    [Theme regularSemiBoldFontlabel:self.totalLbl];
    [Theme regularSemiBoldFontlabel:self.totalAmountLbl];
    [Theme regularSemiBoldFontlabel:self.discountAmount];
    [Theme regularSemiBoldFontlabel:self.discountLbl];
    [Theme regularSemiBoldFontlabel:self.walletPrice];
    [Theme regularSemiBoldFontlabel:self.walletLbl];

    
    [Theme smallLabel:self.deliveredItemsLbl];
    [Theme smallLabel:self.destinationLocationLbl];
    [Theme smallLabel:self.sourceLocationLbl];
    [Theme smallLabel:self.orderDeliveryStatusLbl];
    [Theme regularFontlabel:self.noOfItemsStaticLbl];
    
    [Theme regularFontlabel:self.nosOfItemsLbl];
    [Theme regularFontlabel:self.billAmountStaticLbl];
    [Theme regularFontlabel:self.billAmountLbl];
    [Theme regularFontlabel:self.billPaidStaticLbl];
    [Theme regularFontlabel:self.billPaidLbl];
    [Theme regularFontlabel:self.returnedStaticLbl];
    [Theme regularFontlabel:self.returnedPriceLbl];
    [Theme regularFontlabel:self.orderDeliveryStatusLbl];
    
    self.OrderIdLbl.textColor = BASECOLOR;
    
    [self setTextforLabels];
    
    [self setBordersForViews];
    [self assignColors];
    [self setTextforObjects];
    [self setArrays];
}

-(void)setTextforLabels{
    
    self.noOfItemsStaticLbl.text = NSLocalizedString(@"NOOFITEMSINDETAILSLABEL", nil);
    self.billAmountStaticLbl.text = NSLocalizedString(@"BILLAMOUNTLABEL", nil);
    self.billPaidStaticLbl.text = NSLocalizedString(@"BILLPAIDLABEL", nil);
    self.returnedStaticLbl.text = NSLocalizedString(@"RETURNEDLABEL", nil);
    self.itemLbl.text = NSLocalizedString(@"ITEMTOTALLABEL", nil);
    self.serviceTaxLbl.text = NSLocalizedString(@"SERVICETAX", nil);
    self.deliveryLbl.text = NSLocalizedString(@"DELIVERYCHANGESLABEL", nil);
    self.discountLbl.text = NSLocalizedString(@"DISCOUNTLABEL", nil);
    self.totalLbl.text = NSLocalizedString(@"TOTALLABEL", nil);
    self.walletLbl.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"WALLETDEDUCTIONLABEL", nil)];
    
}

-(void)setTextforObjects{
    
    Orders * orderObj = (Orders *)[self.liveTaskObj.ordersArr lastObject];
    
    self.OrderIdLbl.text =  [NSString stringWithFormat:@"ORDER #%@",self.liveTaskObj.orderIdStr.stringValue];
    
    self.deliveredItemsLbl.text = [NSString stringWithFormat:@"%@ | %lu Items, %@%@",orderObj.status,(unsigned long)self.liveTaskObj.itemsArray.count,CURRENCY,self.liveTaskObj.invoiceObj.net.stringValue];
    
    self.destinationLbl.text = self.liveTaskObj.shopObj.name;
    self.destinationLocationLbl.text = self.liveTaskObj.shopObj.address;
    self.sourceLbl.text = self.liveTaskObj.addressObj.type;
    self.sourceLbl.text = self.sourceLbl.text.uppercaseString;
    self.sourceLocationLbl.text = self.liveTaskObj.addressObj.map_address;
 
    
    self.orderIDINLbl.hidden = YES;
    
    self.timeLbl.text = [NSString stringWithFormat:@"%@",orderObj.created_at];
    self.walletPrice.text = [NSString stringWithFormat:@"%@%@",CURRENCY, self.liveTaskObj.invoiceObj.wallet_amount.stringValue ];
    
    self.totalAmountLbl.text = [NSString stringWithFormat:@"%@%@",CURRENCY, self.liveTaskObj.invoiceObj.payable.stringValue ];
    
    
    if ([self.liveTaskObj.invoiceObj.payment_mode isEqualToString:@"stripe"] || [self.liveTaskObj.invoiceObj.payment_mode isEqualToString:@"braintree"]) {
        
        self.paymentMethodLbl.text = @"Card";
        
    }else if ([self.liveTaskObj.invoiceObj.payment_mode isEqualToString:@"wallet"]) {
        
        self.paymentMethodLbl.text = @"Wallet";
        
    }else{
        
        self.paymentMethodLbl.text = @"Cash";
        
    }
    
    self.paymentMethodLbl.text = [self.paymentMethodLbl.text capitalizedString];

    self.nosOfItemsLbl.text    = [NSString stringWithFormat:@"%lu",(unsigned long)self.liveTaskObj.itemsArray.count];
    self.billAmountLbl.text    = [NSString stringWithFormat:@"%@%@",CURRENCY,self.liveTaskObj.invoiceObj.net];
    self.billPaidLbl.text      = [NSString stringWithFormat:@"%@%@",CURRENCY,self.liveTaskObj.invoiceObj.total_pay];
    self.returnedPriceLbl.text = [NSString stringWithFormat:@"%@%@",CURRENCY,self.liveTaskObj.invoiceObj.tender_pay];
    
}

-(void)assignColors{
    
    self.returnedPriceLbl.textColor = BASECOLOR;
    self.returnedStaticLbl.textColor = BASECOLOR;
    self.paymentMethodLbl.textColor = BASECOLOR;
    self.orderIDINLbl.textColor = BASECOLOR;
    self.timeLbl.textColor = DESCDARKCOLOR;
    self.orderDeliveryStatusLbl.textColor = ORDERSTATUSSUCCESSCOLOR;
    self.OrderIdLbl.text = self.OrderIdLbl.text.uppercaseString;
    
    if ([self.liveTaskObj.status isEqualToString:@"COMPLETED"]) {
        
        self.orderDeliveryStatusLbl.text = @"Order Delivered Successfully";
        self.orderDeliveredStatusIconImg.image = [UIImage imageNamed:@"verified"];

        
    }else{
        [self.orderDeliveryStatusLbl setTextColor:[UIColor redColor]];
        self.orderDeliveryStatusLbl.text = @"Order Cancelled";
        self.orderDeliveredStatusIconImg.image = [UIImage imageNamed:@"ordercancelled"];
        
    }
    
}

-(void)setArrays{
    
    itemsArr = [[NSArray alloc]initWithObjects:@"Spicy Prawn Tikka * 1",@"Spicy Fish Tikka * 1", nil];
    itemPriceArr = [[NSArray alloc]initWithObjects:@"$150",@"$150", nil];
    
}

-(void)setBordersForViews{
    
    CALayer * bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.orderIDView.frame.size.height - 1.0, self.orderIDView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor =  DARKGRAYFORLINE.CGColor;
    [self.orderIDView.layer addSublayer:bottomBorder];
    
    CALayer * topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f,0.0f, self.orderIDView.frame.size.width, 0.3f);
    topBorder.backgroundColor =  LIGHTGRAYFORLINE.CGColor;
    [self.orderIDView.layer addSublayer:topBorder];
    
    CALayer * paymentbottomBorder = [CALayer layer];
    paymentbottomBorder.frame = CGRectMake(0.0f, self.paymentMethodView.frame.size.height - 1.0, self.paymentMethodView.frame.size.width, 1.0f);
    paymentbottomBorder.backgroundColor =  DARKGRAYFORLINE.CGColor;
    [self.paymentMethodView.layer addSublayer:paymentbottomBorder];
    
    CALayer * paymenttopBorder = [CALayer layer];
    paymenttopBorder.frame = CGRectMake(0.0f,0.0f, self.paymentMethodView.frame.size.width, 0.3f);
    paymenttopBorder.backgroundColor =  LIGHTGRAYFORLINE.CGColor;
    [self.paymentMethodView.layer addSublayer:paymenttopBorder];
    
    CALayer * paymentMethodbottomBorder = [CALayer layer];
    paymentMethodbottomBorder.frame = CGRectMake(0.0f, self.paymentTypeView.frame.size.height - 1.0, self.paymentTypeView.frame.size.width, 1.0f);
    paymentMethodbottomBorder.backgroundColor =  DARKGRAYFORLINE.CGColor;
    [self.paymentTypeView.layer addSublayer:paymentMethodbottomBorder];

    CALayer * totaltopBorder = [CALayer layer];
    totaltopBorder.frame = CGRectMake(0.0f,0.0f, self.totalView.frame.size.width, 0.5f);
    totaltopBorder.backgroundColor =  DARKGRAYFORLINE.CGColor;
    [self.totalView.layer addSublayer:totaltopBorder];
    
    CALayer * tableBottomBorder = [CALayer layer];
    tableBottomBorder.frame = CGRectMake(0.0f,(self.orderHistoryTableView.frame.size.height - 0.5f), self.orderHistoryTableView.frame.size.width, 0.5f);
    tableBottomBorder.backgroundColor =  DARKGRAYFORLINE.CGColor;
    [self.orderHistoryTableView.layer addSublayer:tableBottomBorder];
    
}



#pragma Tableview Delegate and Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.liveTaskObj.itemsArray count];
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveTaskDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"liveCell"];
    
    ItemsObj * items = self.liveTaskObj.itemsArray[indexPath.row];
    
    cell.itemName.text = items.productObj.name;
    
    cell.itemQuantity.text = [items.quantity stringValue];

    NSString * str = [NSString stringWithFormat:@"%@", [items.cartObj.nameArr componentsJoinedByString:@", "]];
    NSNumber * addOnAmount;
    
    if ([str isEqualToString:@""]) {
        
        addOnAmount = 0;
        
    }else{
        
        //        addOnAmount = items.cartObj.totalAddOnAmountArr[indexPath.row];
        addOnAmount = items.cartObj.overallwithAddedAmnt;
        
        
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
                                CURRENCY,self.liveTaskObj.invoiceObj.gross.stringValue];
    
    /***** Update Footer field Text  *******/
    
    
    self.itemtotalPrice.text = [NSString stringWithFormat:@"%@%@",
                                CURRENCY,self.liveTaskObj.invoiceObj.gross.stringValue];
    self.serviceTaxPrice.text = [NSString stringWithFormat:@"%@%@",CURRENCY,self.liveTaskObj.invoiceObj.tax.stringValue];
    self.deliverychangesLbl.text =[NSString stringWithFormat:@"%@%@",CURRENCY,self.liveTaskObj.invoiceObj.delivery_charge.stringValue];
    self.discountAmount.text =[NSString stringWithFormat:@"%@%@",CURRENCY,self.liveTaskObj.invoiceObj.discount.stringValue];

    return cell;
    
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

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
