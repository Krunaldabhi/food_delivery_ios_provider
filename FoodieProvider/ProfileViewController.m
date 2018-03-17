//
//  ProfileViewController.m
//  FoodieProvider
//
//  Created by APPLE on 9/20/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "ProfileViewController.h"
#import "config.h"
#import "UIView+Toast.h"
#import "Theme.h"

@interface ProfileViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong)ProfileObj * profileObjects;
@end

@implementation ProfileViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getProfileService];
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self designConfig];
    
    // Do any additional setup after loading the view.
}

-(void)designConfig{
    
    self.profileImg.clipsToBounds = YES;
    self.profileImg.layer.cornerRadius = self.profileImg.bounds.size.width/2;
    
    self.navLbl.text = NSLocalizedString(@"PROFILENAVLABEL", nil);
    self.usernameLbl.text = NSLocalizedString(@"USERNAMELABEL", nil);
    self.userIDLbl.text = NSLocalizedString(@"USERIDLABEL", nil);
    self.mobileLbl.text = NSLocalizedString(@"MOBILENUMBERLABEL", nil);
    self.emailLbl.text = NSLocalizedString(@"PROFEMAILADDRESSLABEL", nil);

    [Theme baseButton:self.updateBtn];
    
    [Theme regularFontlabel:self.navLbl];
    [Theme lightFontlabel:self.usernameLbl];
    [Theme lightFontlabel:self.userIDLbl];
    [Theme lightFontlabel:self.mobileLbl];
    [Theme lightFontlabel:self.emailAdderssLbl];
    
    [Theme textfieldOutfocus:self.usernameTxt];
    [Theme textfieldOutfocus:self.userIDText];
    [Theme textfieldOutfocus:self.mobileTxt];
    [Theme textfieldOutfocus:self.emailAddressTxt];
    
    [self addToolBar:self.mobileTxt];
    [self addToolBar:self.userIDText];
    
    self.userIDText.enabled = NO;
    self.mobileTxt.enabled = NO;


}


/******************** WEB SERVICE ********************/

-(void)getProfileService{
    
    
    if ([Reachability reachabilityForInternetConnection]) {
        
        [appDelegate onStartLoader];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        [afn getDataFromPath:MD_GETPROFILE withParamData:nil withBlock:^(id response, NSDictionary *Error,NSString *strCode) {
            
            [appDelegate onEndLoader];
            
            if(response)
            {
                NSLog(@"PROFILE response...%@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^{

                    self.profileObjects = [[ProfileObj alloc]iniWithDictionary:response];

                   [self.profileImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.profileObjects.avatar]] placeholderImage:[UIImage imageNamed:@"user"]];
                    self.usernameTxt.text = self.profileObjects.name;
                    self.userIDText.text = [NSString stringWithFormat:@"%ld",(long)self.profileObjects.idStr];
                    self.mobileTxt.text = self.profileObjects.phone;
                    self.emailAddressTxt.text = self.profileObjects.email;
                    
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

-(void)updateProfile{
    
    if([Reachability reachabilityForInternetConnection])
    {
        NSDictionary * params=@{@"id":self.userIDText.text, @"name":self.usernameTxt.text, @"email":self.emailAddressTxt.text};
        
        NSLog(@"PARAMS...%@", params);
        
        [appDelegate onStartLoader];

        UIImage * convertedImg = [self compressedImg:self.profileImg.image];
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        
        [afn getDataFromPath:MD_UPDATEPROFILE  withParamDataImage:params andImage:convertedImg withBlock:^(id response, NSDictionary *error, NSString *strErrorCode)
         {
             [appDelegate onEndLoader];

             if(response)
             {
                 NSLog(@"PROFILE response...%@", response);
                 
                 self.profileObjects = [[ProfileObj alloc]iniWithDictionary:response];
                 
                 NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                 
                 [userDefaults setObject:self.profileObjects.name forKey:@"name"];
                 [userDefaults setObject:self.profileObjects.avatar forKey:@"avatar"];
                 [userDefaults setInteger:self.profileObjects.idStr forKey:@"id"];
                 
//                 CURRENCY = self.profileObjects.currencyStr;
                 
                 [userDefaults synchronize];
                 
                 [Utilities showAlert:@"Profile Updated Successfully"];
 
             }else
             {
                 [Utilities showAlert:error[@"error"]];

             }
         
         }];

    }else
        
    {
        
        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
}

/******************** WEB SERVICE ENDS********************/


#pragma TextField Delegates and TextField View Setup

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (textField == self.emailAddressTxt) {
            self.view.frame = CGRectMake(0, - 130, self.view.frame.size.width, self.view.frame.size.height);
        }
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        
        if (textField == self.usernameTxt) {
            
            [self.emailAddressTxt becomeFirstResponder];
            
        }else{
            
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
        }
    }];
    
    return YES;
    
}

-(void)addToolBar:(UITextField *)textField{
    
    UIToolbar * numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.tintColor = BASECOLOR;
    numberToolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:
                                                     UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad:)],
                           nil];
    [numberToolbar sizeToFit];
    
    textField.inputAccessoryView = numberToolbar;
}

-(void)doneWithNumberPad:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        
        if ([self.userIDText resignFirstResponder]) {
            
            [self.mobileTxt becomeFirstResponder];
            
        }else if ([self.mobileTxt resignFirstResponder]){
            
        [self.emailAddressTxt becomeFirstResponder];
        }
        
    }];
    
}

- (IBAction)taptoHideAction:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [self.view endEditing:YES];
        
    }];
    
}

-(BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
    
    // Do any additional setup after loading the view.
}

- (IBAction)updateAction:(id)sender {
    
    if (self.usernameTxt.text.length==0) {
        
        [self.view makeToast:@"ENTERUSERNAME"];
    }
    else if (self.mobileTxt.text.length==0) {
        
        [self.view makeToast:@"ENTERMOBILE"];
    }
    else if (self.mobileTxt.text.length < 10 ){
        
        [self.view makeToast:@"VALIDATEMOBILE"];
    }
    else if (self.emailAddressTxt.text.length==0){
        
        [self.view makeToast:@"ENTEREMAIL"];
    }
    else if (self.userIDText.text.length==0){
        
        [self.view makeToast:@"ENTERUSERID"];
    }
    else if (![self validateEmail:self.emailAddressTxt.text]) {
        
        [self.view makeToast:@"VALIDATEEMAIL"];
    }
    else{
        
        [self updateProfile];
    }
    
}

- (IBAction)taptohidekeyboard:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [self.view endEditing:YES];
        
    }];
}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}



- (IBAction)editImgAction:(id)sender {
    
    /* Camera section */
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self takePhoto];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Choose photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self choosePhoto];
        
    }]];
    actionSheet.view.tintColor = BASECOLOR;
    
    [self presentViewController:actionSheet animated:YES completion:NULL];
}

-(void)takePhoto{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController * cameraAlert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Device has no camera" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okayAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [cameraAlert addAction:okayAction];
        
        [self presentViewController:cameraAlert animated:YES completion:NULL];
        
    }
    else{
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
}

-(void)choosePhoto{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profileImg.image = chosenImage;
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}

-(UIImage *)compressedImg:(UIImage *)getImg{
    
    UIImage *img = getImg;
    
    NSData * data = UIImagePNGRepresentation(img);
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 250*900;
    
    while ([data length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        data = UIImageJPEGRepresentation(img, compression);
    }
    
    UIImage * image = [UIImage imageWithData:data];
    
    return image;
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
