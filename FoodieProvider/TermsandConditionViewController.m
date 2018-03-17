//
//  TermsandConditionViewController.m
//  FoodieProvider
//
//  Created by APPLE on 10/17/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "TermsandConditionViewController.h"

@interface TermsandConditionViewController ()<UIWebViewDelegate>

@end

@implementation TermsandConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webPageView.autoresizesSubviews = YES;
    self.webPageView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    NSURL *myUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@terms",SERVICE_URL]];
    self.webPageView.scalesPageToFit = YES;
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myUrl];
    self.webPageView.delegate = self;
    [self.webPageView loadRequest:myRequest];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    [self.indicator startAnimating];
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicator stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [self.indicator stopAnimating];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)closeFunction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
