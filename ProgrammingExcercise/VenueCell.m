//
//  VenueCell.m
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//

#import "VenueCell.h"

@implementation VenueCell

@synthesize phoneNumber;

//Feature for calling phone from within the application
- (IBAction)callPhoneNumber:(id)sender {
    
    if (phoneNumber.titleLabel.text != nil) {
        NSString *number =  [@"telprompt://" stringByAppendingString:phoneNumber.titleLabel.text];
        NSURL *phoneURL = [NSURL URLWithString:number];
        
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        } else {
            UIAlertView *cAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Call facility not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [cAlert show];
        }
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Phone Number" message:@"No phone number provided by the owner" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    
}


@end
