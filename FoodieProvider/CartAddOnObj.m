//
//  CartAddOnObj.m
//  FoodieProvider
//
//  Created by APPLE on 11/24/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import "CartAddOnObj.h"

@implementation CartAddOnObj

-(id)initWithCartDictionary:(NSArray *)response{
    
    NSLog(@"%@",response);
    
    NSMutableArray * totaladdOnArr = [[NSMutableArray alloc]init];
    NSMutableArray * totaladdOnNameArr = [[NSMutableArray alloc]init];
    NSMutableArray * totaladdOnPriceArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [response count]; i++) {
       
    self.addOnObj = [[AddOnObj alloc]initWithAddonDictionary:response[i]];

        [totaladdOnArr addObject:self.addOnObj];
        [totaladdOnNameArr addObject:self.addOnObj.addOnProductObj.name];
        
        int amount = self.addOnObj.quantity.intValue * self.addOnObj.addOnProductObj.price.intValue;
        
        self.overallAmnt = [NSNumber numberWithInt:amount];
        
        NSLog(@"%@",self.overallAmnt);
        
        [totaladdOnPriceArr addObject:self.overallAmnt];

        }
    
//    for (int i = 0; i < [totaladdOnPriceArr count]; i++) {
    
        NSInteger sum = 0;
        
        for (NSNumber *num in totaladdOnPriceArr)
        {
            sum += [num intValue];
        }
        
        NSLog(@"%ld",(long)sum);
        
//        NSNumber * addNumber = [NSNumber numberWithInteger:sum];
    
        self.overallwithAddedAmnt = [NSNumber numberWithInteger:sum];
//        [totalamountAddonArr addObject:addNumber];
    
//    }
    
    if (totaladdOnArr > 0) {
        
        self.cartArr = [NSArray arrayWithArray:totaladdOnArr];
        self.nameArr = [NSArray arrayWithArray:totaladdOnNameArr];
    }
    
//    if (totalamountAddonArr > 0) {
//        
//        self.totalAddOnAmountArr = [NSArray arrayWithArray:totalamountAddonArr];
//        
//    }
    
    return self;
}

@end
