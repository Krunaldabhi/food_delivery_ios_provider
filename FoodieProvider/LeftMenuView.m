//
//  LeftMenuView.m
//  caretaker_user
//
//  Created by apple on 12/15/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "LeftMenuView.h"
#import "LeftMenuTableViewCell.h"
#import "config.h"
#import "AppDelegate.h"


@implementation LeftMenuView
@synthesize menuImages,menuImagesText,menuTableView;

@synthesize nameLbl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self setDesign];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setDesign];
}

- (void)setDesign
{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];

    self.imgUser.layer.cornerRadius=self.imgUser.frame.size.height/2;
    self.imgUser.clipsToBounds=YES;
    
    NSLog(@"Your Name is --- > %@",[userDefaults objectForKey:@"name"]);
    
    NSString * nameStr = [userDefaults objectForKey:@"name"];
    self.nameLbl.text = nameStr;
    NSString * imgString = [userDefaults objectForKey:@"avatar"];
    
    if ([imgString isEqualToString:@""]) {
       
        self.imgUser.image = [UIImage imageNamed:@"user"];
        
    }else{
        
        [self.imgUser sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVICE_URL,imgString]] placeholderImage:[UIImage imageNamed:@"user"]];
    }
            
    menuImages=[[NSMutableArray alloc]initWithObjects:@"user",@"shop",@"note",@"history",@"book",nil];
    menuImagesText=[[NSMutableArray alloc]initWithObjects:@"Profile",@"Shift Status",@"Notice Board",@"Order History",@"Terms and Conditions",nil];
    
    NSString * shiftCheck = [[NSUserDefaults standardUserDefaults] valueForKey:@"ShiftStatus"];

    
    if ([shiftCheck isEqualToString:@"End"]) {
        
        [menuImagesText addObject:@"Logout"];
        [menuImages addObject:@"logout_main"];

    }else{
        
        
    }
    
    [menuTableView reloadData];
    
}


#pragma mark -- Table View Delegates Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuImagesText count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftMenuTableViewCell *cell = (LeftMenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"LeftMenuTableViewCellID"];
    
    if (cell == nil)
    {
        cell = (LeftMenuTableViewCell *) [[[NSBundle mainBundle] loadNibNamed:@"LeftMenuTableViewCell" owner:self options:nil] lastObject];
    }
    cell.menuImg.image=[UIImage imageNamed:[menuImages objectAtIndex:indexPath.row]];
    cell.menuLbl.text=[menuImagesText objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *viewRedirectionString = [menuImagesText objectAtIndex:indexPath.row];
    
    if ([viewRedirectionString isEqualToString:@"Profile"])
    {
        [self.LeftMenuViewDelegate profileView];
    }
    else if ([viewRedirectionString isEqualToString:@"Shift Status"])
    {
        [self.LeftMenuViewDelegate shiftStatus];
    }
    else if ([viewRedirectionString isEqualToString:@"Notice Board"])
    {
        [self.LeftMenuViewDelegate noticeBoard];
    }
    else if ([viewRedirectionString isEqualToString:@"Order History"])
    {
        [self.LeftMenuViewDelegate orderHistory];
    }
    else if ([viewRedirectionString isEqualToString:@"Terms and Conditions"])
    {
        [self.LeftMenuViewDelegate termsandCondition];
    }
    else if ([viewRedirectionString isEqualToString:@"Logout"])
    {
        [self.LeftMenuViewDelegate logout];
    }

}

- (IBAction)proPicImgBtnAction:(id)sender
{
    [self.LeftMenuViewDelegate profileView];
}
@end
