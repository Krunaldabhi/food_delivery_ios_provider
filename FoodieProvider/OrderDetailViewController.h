//
//  OrderDetailViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveTaskObj.h"
#import "ItemsObj.h"

@interface OrderDetailViewController : UIViewController

@property (strong, nonatomic) LiveTaskObj * liveTaskObj;

@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *OrderIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *deliveredItemsLbl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *destinationLbl;
@property (weak, nonatomic) IBOutlet UILabel *destinationLocationLbl;
@property (weak, nonatomic) IBOutlet UILabel *sourceLbl;
@property (weak, nonatomic) IBOutlet UILabel *sourceLocationLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderDeliveryStatusLbl;
@property (weak, nonatomic) IBOutlet UIImageView *orderDeliveredStatusIconImg;
@property (weak, nonatomic) IBOutlet UIView *orderIDView;
@property (weak, nonatomic) IBOutlet UILabel *orderIDINLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UITableView *orderHistoryTableView;

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UILabel *itemLbl;
@property (weak, nonatomic) IBOutlet UILabel *serviceTaxLbl;
@property (weak, nonatomic) IBOutlet UILabel *deliveryLbl;
@property (weak, nonatomic) IBOutlet UILabel *itemtotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *serviceTaxPrice;
@property (weak, nonatomic) IBOutlet UILabel *deliverychangesLbl;
@property (weak, nonatomic) IBOutlet UILabel *discountLbl;
@property (weak, nonatomic) IBOutlet UILabel *discountAmount;


@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UILabel *totalLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLbl;
@property (weak, nonatomic) IBOutlet UIView *paymentMethodView;
@property (weak, nonatomic) IBOutlet UIView *paymentTypeView;
@property (weak, nonatomic) IBOutlet UILabel *paymentLbl;
@property (weak, nonatomic) IBOutlet UILabel *paymentMethodLbl;

@property (weak, nonatomic) IBOutlet UILabel *noOfItemsStaticLbl;
@property (weak, nonatomic) IBOutlet UILabel *billAmountStaticLbl;
@property (weak, nonatomic) IBOutlet UILabel *billPaidStaticLbl;
@property (weak, nonatomic) IBOutlet UILabel *returnedStaticLbl;

@property (weak, nonatomic) IBOutlet UILabel *nosOfItemsLbl;
@property (weak, nonatomic) IBOutlet UILabel *billAmountLbl;
@property (weak, nonatomic) IBOutlet UILabel *billPaidLbl;
@property (weak, nonatomic) IBOutlet UILabel *returnedPriceLbl;

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *walletLbl;
@property (weak, nonatomic) IBOutlet UILabel *walletPrice;

- (IBAction)backAction:(id)sender;

@end
