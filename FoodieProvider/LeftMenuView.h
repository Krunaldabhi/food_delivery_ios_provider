//
//  LeftMenuView.h
//  caretaker_user
//
//  Created by apple on 12/15/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol LeftMenuViewprotocol;

@interface LeftMenuView : UIView<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>
{
    AppDelegate *appDelegate;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *idLbl;

@property(strong,nonatomic) NSMutableArray *menuImages;
@property(strong,nonatomic) NSMutableArray *menuImagesText;

@property (nonatomic,retain) id <LeftMenuViewprotocol> LeftMenuViewDelegate;

@end
@protocol LeftMenuViewprotocol <NSObject>

-(void)profileView;
-(void)shiftStatus;
-(void)noticeBoard;
-(void)orderHistory;
-(void)termsandCondition;
-(void)logout;

@end
