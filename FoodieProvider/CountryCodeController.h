//
//  CountryCodeController.h
//  FoodieUser
//
//  Created by infos on 9/27/17.
//  Copyright © 2017 Tanjara Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryCodeCell.h"
#import "Theme.h"
#import "Utilities.h"
#import "config.h"
#import "Constants.h"

@interface CountryCodeController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchDisplayDelegate,UISearchResultsUpdating,UISearchControllerDelegate, UISearchBarDelegate>
{
    BOOL isFiltered;
    NSMutableArray*filteredstring;
}

/// Returns an array of all country names in alphabetical order.
+ (NSArray<NSString *> *)countryNames;

/// Returns an array of all country codes. The codes are sorted by country
/// name, and their indices match the indices of their respective country name
/// in the `countryNames`list, but note that this means that the codes
/// themselves are not sorted alphabetically.
+ (NSArray<NSString *> *)countryCodes;

/// Returns a dictionary of country names, keyed by country code.
+ (NSDictionary<NSString *, NSString *> *)countryNamesByCode;

/// Returns a dictionary of country codes, keyed by country name.
+ (NSDictionary<NSString *, NSString *> *)countryCodesByName;
@property (weak, nonatomic) IBOutlet UISearchBar *countrySsearchBar;


@property (weak, nonatomic) IBOutlet UILabel *titlesLbl;

@property (weak, nonatomic) IBOutlet UITableView *countrysTableView;

-(IBAction)backAction:(id)sender;

@end
