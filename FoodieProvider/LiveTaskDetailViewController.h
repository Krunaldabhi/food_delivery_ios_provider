//
//  LiveTaskDetailViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/19/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveTaskObj.h"
#import "ItemsObj.h"
#import "PriceObj.h"

@interface LiveTaskDetailViewController : UIViewController <CLLocationManagerDelegate> {
    
    CLLocationManager * locationManager;
    CLLocation *currentLocation;

}
@property (weak, nonatomic) IBOutlet UILabel *currencystrLbl;

@property (strong, nonatomic) LiveTaskObj * liveTaskObj;
@property (strong, nonatomic) PriceObj * priceObj;
@property (strong, nonatomic) AppDelegate * appDelegate;


@property (weak, nonatomic) IBOutlet UILabel *navLbl;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
- (IBAction)menuAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *whiteView;


@property (weak, nonatomic) IBOutlet UIView *orderView;
@property (weak, nonatomic) IBOutlet UIView *ordertopView;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLbl;
@property (weak, nonatomic) IBOutlet UIImageView *orderImg;
@property (weak, nonatomic) IBOutlet UILabel *restaurentLbl;
@property (weak, nonatomic) IBOutlet UILabel *metersAwayLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@property (weak, nonatomic) IBOutlet UIView *orderIdView;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderTimelbl;

@property (weak, nonatomic) IBOutlet UITableView *itemListTblView;

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UILabel *itemLbl;
@property (weak, nonatomic) IBOutlet UILabel *serviceTaxLbl;
@property (weak, nonatomic) IBOutlet UILabel *deliveryLbl;
@property (weak, nonatomic) IBOutlet UILabel *itemtotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *serviceTaxPrice;
@property (weak, nonatomic) IBOutlet UILabel *deliverychangesLbl;
@property (weak, nonatomic) IBOutlet UILabel *discountLbl;
@property (weak, nonatomic) IBOutlet UILabel *discountAmountLbl;

@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UILabel *totalLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLbl;

@property (weak, nonatomic) IBOutlet UIView *trackingView;
@property (weak, nonatomic) IBOutlet UIView *reachedrestaurentView;
@property (weak, nonatomic) IBOutlet UIView *pickedupView;
@property (weak, nonatomic) IBOutlet UIView *onthewayView;
@property (weak, nonatomic) IBOutlet UIView *reachedCustomerPlaceView;
@property (weak, nonatomic) IBOutlet UIView *cashwalletView;
@property (weak, nonatomic) IBOutlet UIImageView *reachedrestrntImg;
@property (weak, nonatomic) IBOutlet UIImageView *pickedupImg;
@property (weak, nonatomic) IBOutlet UIImageView *onthewayImg;
@property (weak, nonatomic) IBOutlet UIImageView *customerplaceImg;
@property (weak, nonatomic) IBOutlet UIImageView *walletImg;

@property (weak, nonatomic) IBOutlet UIButton *acceptBtn;
- (IBAction)acceptAction:(id)sender;

/*COD VIEW*/
@property (weak, nonatomic) IBOutlet UIView *cashondeliveryView;
@property (weak, nonatomic) IBOutlet UIImageView *moneyImg;
@property (weak, nonatomic) IBOutlet UILabel *amounttoPayLbl;
@property (weak, nonatomic) IBOutlet UILabel *entertheAmountLbl;
@property (weak, nonatomic) IBOutlet UILabel *balanceLbl;


@property (weak, nonatomic) IBOutlet UIButton *paidBtn;
@property (weak, nonatomic) IBOutlet UILabel *amountFrmCustomerLbl;

/* Slider View */

@property (weak, nonatomic) IBOutlet UISlider *processSlider;
- (IBAction)sliderValueChangedAction:(id)sender;
- (IBAction)fadetheTextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *sliderImg;
@property (weak, nonatomic) IBOutlet UILabel *processStateLbl;


@property (weak, nonatomic) IBOutlet UITextField *enterAmountTxtField;
@property (weak, nonatomic) IBOutlet UILabel *balanceAmountLbl;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *hidetheView;
- (IBAction)tapAction:(id)sender;
- (IBAction)paidAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *hideKeyBoard;

- (IBAction)hideKeyboardAction:(id)sender;

/*FEEDBACK VIEW */
@property (weak, nonatomic) IBOutlet UIView *feedbackView;
@property (weak, nonatomic) IBOutlet UILabel *feedLbl;
@property (weak, nonatomic) IBOutlet UILabel *howthedeliveryLbl;
@property (weak, nonatomic) IBOutlet UIView *emoticonsView;

@property (weak, nonatomic) IBOutlet UILabel *reasonLbl;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *disputeView;

@property (weak, nonatomic) IBOutlet UIButton *terribleBtn;
@property (weak, nonatomic) IBOutlet UIButton *badBtn;
@property (weak, nonatomic) IBOutlet UIButton *okayBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
@property (weak, nonatomic) IBOutlet UIButton *superbBtn;

@property (weak, nonatomic) IBOutlet UIImageView *terribleImg;
@property (weak, nonatomic) IBOutlet UIImageView *sadImg;
@property (weak, nonatomic) IBOutlet UIImageView *sideMouthImg;
@property (weak, nonatomic) IBOutlet UIImageView *happyImg;
@property (weak, nonatomic) IBOutlet UIImageView *superbImg;

@property (weak, nonatomic) IBOutlet UILabel *paymentMethodLbl;
@property (weak, nonatomic) IBOutlet UILabel *walletPrice;

@property (weak, nonatomic) IBOutlet UILabel *walletLbl;



- (IBAction)emoticonAction:(id)sender;

- (IBAction)submitAction:(id)sender;


@end
