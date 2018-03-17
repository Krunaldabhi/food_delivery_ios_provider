//
//  ReportViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/22/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportTableViewCell.h"
#import "Theme.h"
#import "config.h"
#import "HelpViewController.h"

@interface ReportViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
    
    NSArray * helpArr;
}

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Theme regularFontlabel:self.navLbl];

    helpArr = [[NSArray alloc]initWithObjects:@"Item delayed from restaurent",@"Item delayed on packaging",@"Item updation late", @"Others", nil];
    
//    self.navLbl.text = NSLocalizedString(@"REPORTNAVLABEL", nil);
    self.navLbl.text = self.titleStr;


}

#pragma Tableview Delegate and Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [helpArr count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReportTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"reportCell"];
    
    cell.reportLbl.text = helpArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == [helpArr count] - 1) {
        
        HelpViewController * helpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
        [self.navigationController pushViewController:helpVC animated:YES];

    }
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
