//
//  NoticeBoardViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "NoticeBoardViewController.h"
#import "NoticeTableViewCell.h"
#import "Theme.h"
#import "config.h"

@interface NoticeBoardViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray * noticeArr;
}

@end

@implementation NoticeBoardViewController
@synthesize noticeObj;

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self getNoticeBoardService];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.noNoticeView.hidden = YES;
    
    [Theme regularFontlabel:self.navLbl];
    [Theme regularSemiBoldFontlabel:self.noresultLbl];

    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.navLbl.text = NSLocalizedString(@"NOTICENAVLABEL", nil);
    self.noresultLbl.text = NSLocalizedString(@"NONOTICEFOUNDLABEL", nil);

}

-(void)getNoticeBoardService{
    
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        [self.appDelegate onStartLoader];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        [afn getDataFromPath:MD_GETNOTICEBOARD withParamData:nil withBlock:^(NSArray * response, NSDictionary *Error,NSString *strCode) {
            
            [self.appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"Shift onProcess response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (response.count != 0) {
                        
                        self.noNoticeView.hidden = YES;
                        self.noticeTablView.hidden = NO;
                        noticeArr = [[NSMutableArray alloc]init];
                        
                        for (int i = 0; i < [response count]; i++) {
                            
                            noticeObj = [[NoticeObj alloc]initWithNoticeData:[response objectAtIndex:i]];
                            
                            [noticeArr addObject:noticeObj];
                        }
                        
                        [self.noticeTablView reloadData];
                        
                    }else{
                        
                        self.noNoticeView.hidden = NO;
                        self.noticeTablView.hidden = YES;
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


#pragma Tableview Delegate and Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [noticeArr count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoticeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"noticeCell"];
    
    noticeObj = (NoticeObj *)[noticeArr objectAtIndex:indexPath.row];
    
    cell.mainLbl.text = noticeObj.title;
    cell.dateLbl.text = noticeObj.created_at;
    cell.toLbl.text = [NSString stringWithFormat:@"Dear Delivery people,"];
    cell.messageLbl.text = noticeObj.notice;
    cell.precautionLbl.text = noticeObj.note;

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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
