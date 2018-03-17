//
//  ChatView.m
//  Binder
//
//  Created by Ramesh on 25/06/16.
//  Copyright © 2016 WePop Info Solutions Pvt. Ltd. All rights reserved.
//
#import "ChatView.h"
#import "ViewController.h"
//#import <SocketIOClientSwift/SocketIOClientSwift-Swift.h>
//#import <SocketIOClientSwift/>
#import "AppDelegate.h"
#import "Constants.h"
#import "MessageObj.h"


@interface ChatView ()<UITextViewDelegate>
{
    int nMsgCount;
    UITextField *currentTextView;
    UITextView *currentTextView1;
    bool keyboardIsShown;
    UITapGestureRecognizer *tapGesture;
    UIScrollView *scrollView;
    // AppDelegate *appDelegate;
    UIView *viewNavBar;
    
    
}
@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatTextViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;

/*Uncomment second line and comment first to use XIB instead of code*/
@property (strong,nonatomic) ChatTableViewCell *chatCell;
//@property (strong,nonatomic) ChatTableViewCellXIB *chatCell;

@property (strong,nonatomic) ContentView *handler;

@end

@implementation ChatView
{
    NSMutableArray *currentMessages;
    ChatCellSettings *chatCellSettings;
    NSArray *arrMessageList;
    
}
@synthesize chatCell,strReciverID,strReciverName,strReciverPic, strTotalMsg;

#pragma mark -
#pragma mark - Methods

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    [self.appDelegate onStartLoader];

    [self.appDelegate getMessagesFromHistory];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    nMsgCount=300;
    
    self.view.backgroundColor = CHATBG;
    [self.navLbl setText:NSLocalizedString(@"CHATNAVLABEL", nil)];
    
    currentMessages = [[NSMutableArray alloc] init];
    chatCellSettings = [ChatCellSettings getInstance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addMessageToTableView:)
                                                 name:@"addMessage"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTableView:)
                                                 name:@"refreshData"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadHistoryTable:)
                                                 name:@"loadHistory"
                                               object:nil];
    
    [self pubNub];

    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    // tapRecognizer.cancelsTouchesInView = NO;
    [self.chatTable addGestureRecognizer:tapRecognizer];
    
    [chatCellSettings setSenderBubbleColor:BASETEXT];
    [chatCellSettings setReceiverBubbleColor:BASECOLOR];
    [chatCellSettings setSenderBubbleNameTextColor:WHITE];
    [chatCellSettings setReceiverBubbleNameTextColor:WHITE];
    [chatCellSettings setSenderBubbleMessageTextColor:WHITE];
    [chatCellSettings setReceiverBubbleMessageTextColor:WHITE];
    [chatCellSettings setSenderBubbleTimeTextColor:WHITE];
    [chatCellSettings setReceiverBubbleTimeTextColor:WHITE];
    
    UIFont * regularFont = [UIFont fontWithName:FONT_REGULAR size:14.0];
    UIFont * smallFont = [UIFont fontWithName:FONT_REGULAR size:12.0];

    [chatCellSettings setSenderBubbleFontWithSizeForName:regularFont];
    [chatCellSettings setReceiverBubbleFontWithSizeForName:regularFont];
    [chatCellSettings setSenderBubbleFontWithSizeForMessage:regularFont];
    [chatCellSettings setReceiverBubbleFontWithSizeForMessage:regularFont];
    [chatCellSettings setSenderBubbleFontWithSizeForTime:smallFont];
    [chatCellSettings setReceiverBubbleFontWithSizeForTime:smallFont];
    
    [chatCellSettings senderBubbleTailRequired:YES];
    [chatCellSettings receiverBubbleTailRequired:YES];
    [Theme fontForTextView:self.chatTextView];
    [Theme regularFontlabel:lblText];
    
    [[self chatTable] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[self chatTable] registerClass:[ChatTableViewCell class] forCellReuseIdentifier:@"chatSend"];
    
    [[self chatTable] registerClass:[ChatTableViewCell class] forCellReuseIdentifier:@"chatReceive"];
    
    [self.handler updateMinimumNumberOfLines:1 andMaximumNumberOfLine:3];

    
    
    self.chatTextView.delegate=self;
    
}

- (void)pubNub
{
    
    _channel = CHATCHANNEL;
    
    self.pubnub = [self.appDelegate enterChannel:_channel];
    
}

-(void)loadHistoryTable:(NSNotification *)messageData{

    MessageObj * message;
    
    message = [[MessageObj alloc]initWithHistoryMessage:messageData.object];
    
    NSMutableArray * messageArr =[NSMutableArray arrayWithArray:messageData.object];
    
    [messageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MessageObj * message;
        if ([obj[@"username"] isEqualToString:@"admin"]) {
            
            message = [[MessageObj alloc] initIMessageWithName:@"" message:obj[@"message"] time:@"" type:@"admin"];
        }
        else if ([obj[@"username"] isEqualToString:@"user"])
        {
            message = [[MessageObj alloc] initIMessageWithName:@"" message:obj[@"message"] time:@"" type:@"self"];
        }
        [currentMessages  addObject:message];
        
    }];
    
    [self.chatTable reloadData];
    
    NSIndexPath* ip = [NSIndexPath indexPathForRow:currentMessages.count-1 inSection:0];
    [self.chatTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:UITableViewRowAnimationLeft];
    [self.appDelegate onEndLoader];
    
}

- (void)addMessageToTableView:(NSNotification *)messageData
{
    MessageObj * message;
        
    NSDictionary * messageDic = messageData.object;
    
    NSString * messageName = [messageDic valueForKey:@"username"];
    
    if ([messageName isEqualToString:@"admin"]) {
        
        message = [[MessageObj alloc] initIMessageWithName:@"" message:[messageDic valueForKey:@"message"] time:@"" type:@"admin"];
        [self updateTableView:message];
        
        
    }
    else if ([messageName isEqualToString:@"user"])
    {
        message = [[MessageObj alloc] initIMessageWithName:@"" message:[messageDic valueForKey:@"message"] time:@"" type:@"self"];
        [self updateTableView:message];
        
    }

}

-(void)refreshTableView:(NSNotification *)messageData{
    
    MessageObj * message;
    //    [currentMessages addObject:[message initIMessageWithName:@"" message:messageData.object time:@"" type:@"Other"]];
    message = [[MessageObj alloc] initIMessageWithName:@"" message:messageData.object time:@"" type:@"admin"];
    
    [self updateTableView:message];
    
}

#pragma mark - Keyboard Delegate

- (void)keyboardWillShow:(NSNotification*)noti
{
    CGSize keyboardSize = [[[noti userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.view.frame.size.height-keyboardSize.height-_contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
    
    UITableView *tableView = (UITableView *)[self.view viewWithTag:10001];
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    
    tableView.contentInset = contentInsets;
    tableView.scrollIndicatorInsets = contentInsets;
    
    NSIndexPath* editingIndexPath = [NSIndexPath indexPathForRow:[self.chatTable numberOfRowsInSection:0]-1 inSection:0];
    [tableView scrollToRowAtIndexPath:editingIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
   
}

- (void)keyboardWillHide:(NSNotification*)noti
{
    _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.view.frame.size.height-_contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
    
    UITableView *tableView = (UITableView *)[self.view viewWithTag:10001];

    [UIView animateWithDuration:3.0f animations:^{
        tableView.contentInset = UIEdgeInsetsZero;
        tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
 
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [viewNavBar removeFromSuperview];
    
    
}

- (IBAction)backEvent:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}



#pragma mark -
#pragma mark - Actions
-(IBAction)onSingle:(id)sender
{
    // [self keyboardWillHide:nil];
    [self performSegueWithIdentifier:@"Chat_SingleView" sender:self];
    
}


- (IBAction)onsendMessage:(id)sender {
    
    NSString *message = [NSString stringWithFormat:@"%@", self.chatTextView.text];
    
    if (self.chatTextView.text.length != 0) {
        
        NSDictionary * userDic = @{@"Metadata":@"user"};
        NSDictionary * sendMsgDic = @{@"username":@"user",@"message":message};
        
        [self.pubnub publish:(id)sendMsgDic toChannel:CHATCHANNEL storeInHistory:YES
                withMetadata:userDic completion:^(PNPublishStatus * _Nonnull status)
         {
             // Message successfully published to specified channel.
             if (!status.isError) {
                 
                 self.chatTextView.text = @"";
                 MessageObj *sendMessage;
                 
                 sendMessage = [[MessageObj alloc] initIMessageWithName:@"" message:message time:@"" type:@"self"];
                 
                 [self updateTableView:sendMessage];
                 [self.chatTextView setText:@""];
                 lblText.hidden=NO;

                 // Message successfully published to specified channel.
             }
             else {
                 
                 /**
                  Handle message publish error. Check 'category' property to find
                  out possible reason because of which request did fail.
                  Review 'errorData' property (which has PNErrorData data type) of status
                  object to get additional information about issue.
                  
                  Request can be resent using: [status retry];
                  
                  */
                 
             }
         }];
        
    }else{
        
        lblText.hidden=YES;

    }
    
   
}

- (IBAction)backBtnAction:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}



- (void) updateTableView:(MessageObj *)msg
{
    
    [self.handler textViewDidChange:self.chatTextView];
    NSLog(@"%ld",currentMessages.count);
    [currentMessages insertObject:msg atIndex:currentMessages.count];
    [self.chatTable reloadData];
    
    //Always scroll the chat table when the user sends the message
    if([self.chatTable numberOfRowsInSection:0]!=0)
    {
        NSIndexPath* ip = [NSIndexPath indexPathForRow:[self.chatTable numberOfRowsInSection:0]-1 inSection:0];
        [self.chatTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:UITableViewRowAnimationLeft];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currentMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.tag = 10001;
    
    MessageObj *message = [currentMessages objectAtIndex:indexPath.row];
    
    if([message.messageType isEqualToString:@"self"])
    {
        /*Uncomment second line and comment first to use XIB instead of code*/
        chatCell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chatSend"];
        
        chatCell.chatNameLabel.text = message.userName;
        
        chatCell.chatMessageLabel.text = message.userMessage;
        
        chatCell.chatTimeLabel.text = message.userTime;
        
        chatCell.chatUserImage.hidden = YES;

        
        
        /*Comment this line is you are using XIB*/
        chatCell.authorType = iMessageBubbleTableViewCellAuthorTypeSender;
    }
    else
    {
        /*Uncomment second line and comment first to use XIB instead of code*/
        chatCell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chatReceive"];
        
        chatCell.chatMessageLabel.text = message.userMessage;
        
        chatCell.chatNameLabel.text = @"SUPPORT";
        
        chatCell.chatTimeLabel.text = message.userTime;
        chatCell.chatUserImage.image = [UIImage imageNamed:@"chatlogo"];
        
        // chatCell.chatUserImage.image = [UIImage imageNamed:@"defaultUser"];
        
        /*Comment this line is you are using XIB*/
        chatCell.authorType = iMessageBubbleTableViewCellAuthorTypeReceiver;
    }
    
    return chatCell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageObj *message = [currentMessages objectAtIndex:indexPath.row];
    
    CGSize size;
    
    CGSize Namesize;
    CGSize Timesize;
    CGSize Messagesize;
    
    NSArray *fontArray = [[NSArray alloc] init];
    
    //Get the chal cell font settings. This is to correctly find out the height of each of the cell according to the text written in those cells which change according to their fonts and sizes.
    //If you want to keep the same font sizes for both sender and receiver cells then remove this code and manually enter the font name with size in Namesize, Messagesize and Timesize.
    if([message.messageType isEqualToString:@"self"])
    {
        fontArray = chatCellSettings.getSenderBubbleFontWithSize;
    }
    else
    {
        fontArray = chatCellSettings.getReceiverBubbleFontWithSize;
    }
    
    //Find the required cell height
    Namesize = [@"Name" boundingRectWithSize:CGSizeMake(220.0f, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:fontArray[0]}
                                     context:nil].size;
    
    
    
    Messagesize = [message.userMessage boundingRectWithSize:CGSizeMake(220.0f, CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:fontArray[1]}
                                                    context:nil].size;
    
    
    Timesize = [@"Time" boundingRectWithSize:CGSizeMake(220.0f, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:fontArray[2]}
                                     context:nil].size;
    
    
    size.height = Messagesize.height + Namesize.height + Timesize.height +
    28.0f;
    
    return size.height;
}


#pragma mark -
#pragma mark - Keyboard

-(void)dismissKeyBoard
{
    //[self keyboardWillHide:nil];
    // [_txtMessage resignFirstResponder];
    [self.chatTextView resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextView *)textField{
    
    // [self keyboardWillHide:nil];
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // NSLog(@"Text View Chars: %lu",(unsigned long)text.length);
    
    
    if ([text isEqualToString:@" "])
    {
        if (![textView.text isEqualToString:@""])
        {
            if([text isEqualToString:@"\n"])
            {
                [textView resignFirstResponder];
                return NO;
            }
            if (text.length!=0)
            {
                lblText.hidden=YES;
                [btnSend setBackgroundImage:[UIImage imageNamed:@"chat_send_pressed.png"] forState:UIControlStateNormal];
            }
            else
            {
                if (range.location==0)
                {
                    lblText.hidden=NO;
                    [btnSend setBackgroundImage:[UIImage imageNamed:@"chat_send_normal.png"] forState:UIControlStateNormal];
                }
                
            }
            
        }
        else
        {
            return false;
        }
    }
    else
    {
        if([text isEqualToString:@"\n"])
        {
            [textView resignFirstResponder];
            return NO;
        }
        if (text.length!=0)
        {
            lblText.hidden=YES;
            [btnSend setBackgroundImage:[UIImage imageNamed:@"chat_send_pressed.png"] forState:UIControlStateNormal];
        }
        else
        {
            if (range.location==0)
            {
                lblText.hidden=NO;
                [btnSend setBackgroundImage:[UIImage imageNamed:@"chat_send_normal.png"] forState:UIControlStateNormal];
            }
            
        }
        
    }
    
    
    return YES;
}



@end
