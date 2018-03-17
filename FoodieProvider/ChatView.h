//
//  ChatView.h
//  Binder
//
//  Created by Ramesh on 25/06/16.
//  Copyright © 2016 WePop Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "ChatTableViewCell.h"
#import "ChatTableViewCellXIB.h"
#import "ChatCellSettings.h"

@interface ChatView : UIViewController <UITableViewDataSource,UITableViewDelegate, PNObjectEventListener>
{
     IBOutlet UIButton *btnSend;
    IBOutlet UILabel *lblText;
}
@property (weak, nonatomic) IBOutlet UIImageView *recieverPicImgView;
@property (weak, nonatomic) IBOutlet UILabel *recieverNameLbl;
@property (weak, nonatomic) IBOutlet UITableView *chatTable;
@property (weak,nonatomic) PubNub * pubnub;
@property(strong,nonatomic)NSString * channel;
@property(strong,nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *navLbl;


@property(strong,nonatomic)NSString *strReciverID,*strReciverName,*strReciverPic, *strTotalMsg;

- (IBAction)onsendMessage:(id)sender;
- (IBAction)backBtnAction:(id)sender;

@end
