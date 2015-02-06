//
//  VenueCell.h
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//
#import <UIKit/UIKit.h>

@interface VenueCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UIButton *phoneNumber;

-(IBAction)callPhoneNumber:(id)sender;

@end
