//
//  AFNHelper.h
//  Truck
//
//  Created by veena on 1/12/17.
//  Copyright © 2017 appoets. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define POST_METHOD @"POST"
#define GET_METHOD  @"GET"
#define DELETE_METHOD  @"DELETE"
#define PATCH_METHOD  @"PATCH"
#define PUT_METHOD  @"PUT"


typedef void (^RequestCompletionBlock)(id response, NSDictionary *error, NSString *errorcode);

@interface AFNHelper : NSObject
{
//blocks
    RequestCompletionBlock dataBlock;
}
@property(nonatomic,copy)NSString * loaderRequestStr;

@property(nonatomic,copy)NSString *strReqMethod;

-(id)initWithRequestMethod:(NSString *)method;

-(void)getDataFromPath:(NSString *)path withParamData:(NSDictionary *)dictParam withBlock:(RequestCompletionBlock)block;

-(void)getDataFromPath:(NSString *)path withParamDataImage:(NSDictionary *)dictParam andImage:(UIImage *)image withBlock:(RequestCompletionBlock)block;

-(void)getDataFromPath:(NSString *)path withParamDataImages:(NSDictionary *)dictParam andImages:(NSArray *)images withBlock:(RequestCompletionBlock)block;

-(void)getDataFromPath:(NSString *)path withParamDataImages:(NSDictionary *)dictParam andImagesArray:(NSArray *)images withBlock:(RequestCompletionBlock)block;

-(void)getAddressFromGooglewithParamData:(NSDictionary *)dictParam withBlock:(RequestCompletionBlock)block;

-(void)getAddressFromGooglewAutoCompletewithParamData:(NSDictionary *)dictParam withBlock:(RequestCompletionBlock)block;

-(void)stop;

@end
