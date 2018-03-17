//
//  DisputeViewController.m
//  FoodieProvider
//
//  Created by APPLE on 11/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "DisputeViewController.h"

@interface DisputeViewController (){
    
    NSString * phoneNumberStr;
}

@end

@implementation DisputeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getdata:)
                                                 name:@"getdata"
                                               object:nil];

    
    [self setUserInterface];
    [self setText];

}

-(void)setUserInterface{
    
    [Theme cornerRadius:self.view forLabel:nil fortextfield:nil forButton:nil];
    [Theme chooseFontforlabel:self.headerLabel font:FONT_BOLD fontSize:18];
    [Theme chooseFontforlabel:self.orderIdLbl font:FONT_SEMIBOLD fontSize:18];
    [Theme chooseFontforlabel:self.orderIdwithcontentLabel font:FONT_SEMIBOLD fontSize:18];
    [Theme chooseFontforlabel:self.yourDisputeLbl font:FONT_MEDIUM fontSize:14];

    [Theme baseButton:self.callBtn];
    [Theme baseButton:self.cancelBtn];

}

-(void)setText{
    
    
    [self.callBtn setTitle:NSLocalizedString(@"CALLNAMEBTN", nil) forState:UIControlStateNormal];
    [self.cancelBtn setTitle:NSLocalizedString(@"CANCELNAMEBTN", nil) forState:UIControlStateNormal];
    self.headerLabel.text = NSLocalizedString(@"DISPUTEMANAGERNAVLABEL", nil);
    self.orderIdLbl.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"ORDERTEXT", nil)];
    self.yourDisputeLbl.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"RAISEDISPUTELABEL", nil)];

}

-(void)getdata:(NSNotification *)notification{
    
    self.orderIdwithcontentLabel.text = notification.userInfo[@"OrderId"];
    phoneNumberStr = notification.userInfo[@"Dispute_No"];

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

- (IBAction)callOrCancelAction:(id)sender {
    
    if ([sender tag] == 101) {
        
        NSString * phoneNumber = [@"tel://" stringByAppendingString:[NSString stringWithFormat:@"%@",phoneNumberStr]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber] options:@{@"":@""} completionHandler:nil];

    }else{
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeDispute" object:nil];
    }
}
@end
