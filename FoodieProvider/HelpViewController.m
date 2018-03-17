//
//  HelpViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/22/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "HelpViewController.h"
#import "ChatView.h"
#import "config.h"
#import "Theme.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self userInterfaceDesign];

    
}

-(void)userInterfaceDesign{
    
    
    [Theme regularFontlabel:self.navLbl];
    [Theme regularFontlabel:_topicLbl];
    [Theme fontForTextView:self.reasonTxtView];
    
    self.navLbl.text = @"Others";

    self.topicLbl.textColor = BLACK;
    
    self.topicLbl.text = NSLocalizedString(@"REASONTEXT", nil);
    [self.reasonTxtView setText:NSLocalizedString(@"DISPUTETEXT", nil)];
    [self.chatBtn setTitle:NSLocalizedString(@"CHATUSTEXT", nil) forState:UIControlStateNormal];
    [self.callBtn setTitle:NSLocalizedString(@"CALLUSTEXT", nil) forState:UIControlStateNormal];
    
    [Theme cornerRadius:nil forLabel:nil fortextfield:nil forButton:self.chatBtn];
    [Theme cornerRadius:nil forLabel:nil fortextfield:nil forButton:self.callBtn];
    
    [self.chatBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
    [self.callBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
    
    self.chatBtn.layer.masksToBounds = NO;
    self.chatBtn.layer.borderWidth = 0.5f;
    self.chatBtn.layer.borderColor = BASECOLOR.CGColor;
    
    self.callBtn.layer.masksToBounds = NO;
    self.callBtn.layer.borderWidth = 0.5f;
    self.callBtn.layer.borderColor = BASECOLOR.CGColor;
    
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

- (IBAction)chatAction:(id)sender {
    
    ChatView * chatView = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatView"];
    [self presentViewController:chatView animated:YES completion:nil];
}

- (IBAction)callAction:(id)sender {
}
@end
