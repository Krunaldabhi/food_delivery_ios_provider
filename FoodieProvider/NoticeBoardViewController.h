//
//  NoticeBoardViewController.h
//  FoodieProvider
//
//  Created by APPLE on 9/21/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeObj.h"
@interface NoticeBoardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UILabel *navLbl;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UITableView *noticeTablView;

@property (weak, nonatomic) AppDelegate * appDelegate;
@property (strong, nonatomic) NoticeObj * noticeObj;
@property (weak, nonatomic) IBOutlet UIView *noNoticeView;
@property (weak, nonatomic) IBOutlet UILabel *noresultLbl;



- (IBAction)backAction:(id)sender;

@end
