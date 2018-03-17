//
//  Utilities.m
//  HealingRadiusPro
//
//  Created by STS-038 on 09/03/15.
//  Copyright (c) 2015 SPAN Technology Services. All rights reserved.
//

#import "Utilities.h"
#import <UIKit/UIKit.h>
#import "config.h"
//#import <FCAlertView.h>
#import "Theme.h"

@implementation Utilities


+ (NSString *)setPhoneNumberMASKFromString:(NSString *)string
{
    
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""options:NSRegularExpressionSearch range:NSMakeRange(0, string.length)];
    NSArray *stringComponents = [NSArray arrayWithObjects:[string substringWithRange:NSMakeRange(0, 3)],
                                 [string substringWithRange:NSMakeRange(3, 3)],
                                 [string substringWithRange:NSMakeRange(6, [string length]-6)], nil];
    string = [NSString stringWithFormat:@"(%@) %@-%@", [stringComponents objectAtIndex:0], [stringComponents objectAtIndex:1], [stringComponents objectAtIndex:2]];
    return string;
}

+ (NSString *)setAddressFormatFromString:(NSString *)address1 :(NSString *)address2 :(NSString *)city :(NSString *)state :(NSString *)zipcode
{
    address1 = [self removeNullFromString:address1];
    address2 = [self removeNullFromString:address2];
    city = [self removeNullFromString:city];
    state = [self removeNullFromString:state];
    zipcode = [self removeNullFromString:zipcode];

    address1 = [self removeSpecialCharacterFromString:address1];
    address2 = [self removeSpecialCharacterFromString:address2];
    city = [self removeSpecialCharacterFromString:city];
    state = [self removeSpecialCharacterFromString:state];
    zipcode = [self removeSpecialCharacterFromString:zipcode];
    
    NSString *addressFormatString;
    
    if ([address1 isEqualToString:@""])
    {
        addressFormatString = [NSString stringWithFormat:@"%@, %@, %@ %@", address2, city, state, zipcode];
    }
    else if ([address2 isEqualToString:@""])
    {
        addressFormatString = [NSString stringWithFormat:@"%@, %@, %@ %@",address1, city, state, zipcode];
    }
    else if ([address1 isEqualToString:@""] && [address2 isEqualToString:@""])
    {
        addressFormatString = [NSString stringWithFormat:@"%@, %@ %@", city, state, zipcode];
    }
    else if ([address1 isEqualToString:@""] && [address2 isEqualToString:@""] && [city isEqualToString:@""])
    {
        addressFormatString = [NSString stringWithFormat:@"%@ %@", state, zipcode];
    }
    else
    {
        addressFormatString = [NSString stringWithFormat:@"%@ %@, %@, %@ %@",address1, address2, city, state, zipcode];
    }
    
    addressFormatString = [addressFormatString stringByReplacingOccurrencesOfString:@",," withString:@","];
    addressFormatString = [addressFormatString stringByReplacingOccurrencesOfString:@"<null>," withString:@""];
    addressFormatString = [addressFormatString stringByReplacingOccurrencesOfString:@" ," withString:@","];
    
    return addressFormatString;
}

+ (NSString *)setAddressFormatForLine2:(NSString *)city :(NSString *)state :(NSString *)zipcode
{
    city = [self removeNullFromString:city];
    state = [self removeNullFromString:state];
    zipcode = [self removeNullFromString:zipcode];
    
    city = [self removeSpecialCharacterFromString:city];
    state = [self removeSpecialCharacterFromString:state];
    zipcode = [self removeSpecialCharacterFromString:zipcode];
    
    NSString *addressFormatString = [NSString stringWithFormat:@"%@, %@ %@",city, state, zipcode];
    
    addressFormatString = [addressFormatString stringByReplacingOccurrencesOfString:@",," withString:@","];
    addressFormatString = [addressFormatString stringByReplacingOccurrencesOfString:@"<null>," withString:@""];
    addressFormatString = [addressFormatString stringByReplacingOccurrencesOfString:@" ," withString:@","];
    
    if ([addressFormatString hasPrefix:@","])
    {
        addressFormatString = [addressFormatString substringFromIndex:1];
    }
    return addressFormatString;
}

+ (NSString *)removeNullFromString:(NSString *)string
{
    if (string == (id)[NSNull null] || string.length == 0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"] || [string isEqualToString:@" "] || [string isEqualToString:@"01/01/0001"] || [string isEqualToString:@"1/1/0001"] || [string isEqualToString:@"0001-01-01T00:00:00"])
    {
        string = @"";
    }
    return string;
}

+ (NSNumber *)removeNullFromNumber:(NSNumber *)number
{
    if (number == (id)[NSNull null])
    {
        number = 0;
    }
    return number;
}

+ (NSString *)removeNullFromString:(NSString *)string replaceWith:(NSString *)replaceString
{    
    if (string == (id)[NSNull null] || string.length == 0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"] || [string isEqualToString:@" "] || [string isEqualToString:@"01/01/0001"] || [string isEqualToString:@"1/1/0001"] || [string isEqualToString:@"0001-01-01T00:00:00"])
    {
        string = replaceString;
    }
    return string;
}

+ (NSString *)removeSpecialCharacterFromString:(NSString *)string
{
    
    string = [string stringByReplacingOccurrencesOfString:@" +" withString:@" "options:NSRegularExpressionSearch range:NSMakeRange(0, string.length)];
    string = (NSString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"\"\"" options:NSRegularExpressionSearch range:NSMakeRange(0, string.length)];
    return string;
}


+ (NSString *)toBase64String:(NSString *)string
{
    NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    return base64String;
}


+ (NSString *) fuelQuantityFormatter:(NSString *) string
{
    double fuelQuantity = [string doubleValue];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:3];
    [formatter setMinimumFractionDigits:3];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithDouble:fuelQuantity]];
    
    return numberString;
}

+ (NSString *)convertTimeFormat:(NSString *)string
{
    NSArray *startTimeSplitArray= [string componentsSeparatedByString:@" "];
    
    NSString *startTimeVal=[startTimeSplitArray objectAtIndex:1];
    
//    if (![startTimeSplitArray isKindOfClass:[NSNull class]] && [startTimeSplitArray count]>1)
//    {
//        startTimeVal = [startTimeSplitArray objectAtIndex:1];
//        
//        NSArray *secondsArray = [startTimeVal componentsSeparatedByString:@"."];
//        
//        if (![secondsArray isKindOfClass:[NSNull class]]  && [secondsArray count]>1)
//        {
//            startTimeVal = [secondsArray objectAtIndex:0];
//        }
//    }
    
    NSDateFormatter *startTimeFormatter1 = [[NSDateFormatter alloc] init];
    startTimeFormatter1.dateFormat = @"HH:mm:ss";
    
    NSDate *dateStartTime = [startTimeFormatter1 dateFromString:startTimeVal];
    startTimeFormatter1.dateFormat = @"hh:mm a";
    
    NSString *startTimeString = [startTimeFormatter1 stringFromDate:dateStartTime];

    return startTimeString;
}

+ (NSString *)convertDateFormatter:(NSString *)dateTimeString
{
    NSArray *dateSplitArray= [dateTimeString componentsSeparatedByString:@"T"];
    NSString *startDate;
    if (![dateSplitArray isKindOfClass:[NSNull class]])
    {
        startDate = [dateSplitArray objectAtIndex:0];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",startDate]];
    
   // [dateFormatter setDateFormat:@"EEE, MMM dd, yyyy"];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [dateFormatter stringFromDate:date1];
    
    return dateString;
}

+ (NSString *)convertDateTimeToGMT:(NSString *)dateTimeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd MMM yyyy";
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    dateFormatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    NSTimeZone *gmtZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    
    NSDate *newDate = [dateFormatter1 dateFromString:dateTimeString];
    [dateFormatter1 setTimeZone:gmtZone];
    NSString *gmtDateTimeStr = [dateFormatter stringFromDate:newDate];
    
    if (newDate == nil)
    {
        NSDate *newDate = [dateFormatter dateFromString:dateTimeString];
        [dateFormatter setTimeZone:gmtZone];
        gmtDateTimeStr = [dateFormatter stringFromDate:newDate];
    }
    
    return gmtDateTimeStr;
}

+ (void)showAlert:(NSString *)message{
    
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    
    [alert showAlertWithTitle:nil
                 withSubtitle:message
              withCustomImage:nil
          withDoneButtonTitle:@"OK"
                   andButtons:nil];
    alert.colorScheme = BASECOLOR;
    alert.doneButtonTitleColor = [UIColor whiteColor];
    alert.animateAlertOutToBottom = YES;
    alert.hideSeparatorLineView = NO;
    alert.animateAlertInFromTop = YES;
    alert.subtitleFont = [UIFont fontWithName:FONT_REGULAR size:14.0];
    
    alert.subTitleColor = DESCDARKCOLOR;
    alert.doneButtonCustomFont =  [UIFont fontWithName:FONT_REGULAR size:16.0];
    
}

+ (void)showAlertWithButtonAction:(NSString *)message popOrDismiss:(BOOL)popOrDismiss
{
    
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    
    [alert showAlertWithTitle:nil
                 withSubtitle:message
              withCustomImage:nil
          withDoneButtonTitle:@"OK"
                   andButtons:nil];
    alert.colorScheme = BASECOLOR;
    alert.doneButtonTitleColor = [UIColor whiteColor];
    alert.animateAlertOutToBottom = YES;
    alert.hideSeparatorLineView = NO;
    alert.animateAlertInFromTop = YES;
    alert.subtitleFont = [UIFont fontWithName:FONT_REGULAR size:14.0];
    if (popOrDismiss) {
        
        [alert doneActionBlock:^{
          
            
        }];
        
    }else{
        
        [alert doneActionBlock:nil];

    }

    
    alert.subTitleColor = DESCDARKCOLOR;
    alert.doneButtonCustomFont =  [UIFont fontWithName:FONT_REGULAR size:16.0];
    
}



+(NSString *)findmobilecountryCode{
    
    NSLocale * currentLocale = [NSLocale currentLocale];
    
    NSString * countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSDictionary * dictDialingCodes = [[NSDictionary alloc]initWithObjectsAndKeys:
                        @"972", @"IL",
                        @"93", @"AF",
                        @"355", @"AL",
                        @"213", @"DZ",
                        @"1", @"AS",
                        @"376", @"AD",
                        @"244", @"AO",
                        @"1", @"AI",
                        @"1", @"AG",
                        @"54", @"AR",
                        @"374", @"AM",
                        @"297", @"AW",
                        @"61", @"AU",
                        @"43", @"AT",
                        @"994", @"AZ",
                        @"1", @"BS",
                        @"973", @"BH",
                        @"880", @"BD",
                        @"1", @"BB",
                        @"375", @"BY",
                        @"32", @"BE",
                        @"501", @"BZ",
                        @"229", @"BJ",
                        @"1", @"BM", @"975", @"BT",
                        @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                        @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                        @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                        @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                        @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                        @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                        @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                        @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                        @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                        @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                        @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                        @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                        @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                        @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                        @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                        @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                        @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                        @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                        @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                        @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                        @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                        @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                        @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                        @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                        @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                        @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                        @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                        @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                        @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                        @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                        @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                        @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                        @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                        @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                        @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                        @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                        @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                        @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                        @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                        @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                        @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                        @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                        @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                        @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                        @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                        @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                        @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                        @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                        @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                        @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                        @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                        @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963",
                        @"SY",@"886",
                        @"TW", @"255",
                        @"TZ", @"670",
                        @"TL",@"58",
                        @"VE",@"84",
                        @"VN",
                        @"284", @"VG",
                        @"340", @"VI",
                        @"678",@"VU",
                        @"681",@"WF",
                        @"685",@"WS",
                        @"967",@"YE",
                        @"262",@"YT",
                        @"27",@"ZA",
                        @"260",@"ZM",
                        @"263",@"ZW",
                        nil];
    
    NSString * getStringCode = [dictDialingCodes objectForKey:countryCode];
    
    return getStringCode;
}

+(NSString *)datetoTimeConversionStr:(NSString *)getThestringTime{
    
    if ([getThestringTime isEqual:[NSNull null]]) {
        
        return @"";
    }
    else{
        
        NSString * getTitleforTimeStr = [Utilities removeNullFromString:[NSString stringWithFormat:@"%@",getThestringTime]];
        NSArray * splitEndDateString = [getTitleforTimeStr componentsSeparatedByString:@" "];
        //        NSString *dateString = [splitEndDateString objectAtIndex:0];
        NSString *timeString = [splitEndDateString objectAtIndex:1];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss";
        NSDate *date = [dateFormatter dateFromString:timeString];
        
        dateFormatter.dateFormat = @"hh:mm a";
        NSString *pmamStartDateString = [dateFormatter stringFromDate:date];
        
        return pmamStartDateString;
        
    }
}


@end
