//
//  LocationUpdateObj.m
//  FoodieProvider
//
//  Created by APPLE on 10/16/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "LocationUpdateObj.h"

@implementation LocationUpdateObj
@synthesize appDelegate;

-(id)initWithLocationUpdate:(NSString *)latitude getLongitute:(NSString *)longitude{
    
    if([Reachability reachabilityForInternetConnection])
    {
        NSDictionary * params;
        
        if (latitude != nil) {
            
            params=@{@"latitude":latitude, @"longitude":longitude};

        }else
        {
            params=@{@"latitude":@"0.00", @"longitude":@"0.00"};

        }
        
        NSLog(@"PARAMS...%@", params);
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        
        afn.loaderRequestStr = @"Hide";
        
        [afn getDataFromPath:MD_LOCATIONUPDATE withParamData:params withBlock:^(id response, NSDictionary *error, NSString *strErrorCode)
         {
             
             if(response)
             {
                 NSLog(@"Updated Location response...%@", response);
                 
             }else
             {
                 
             }
             
         }];
        
    }else
        
    {
        
//        [Utilities showAlert:NSLocalizedString(@"CHKNET", nil)];
    }
    
    return self;
}

@end
