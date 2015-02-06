//
//  Venue.h
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//
#import <Foundation/Foundation.h>
#import "Location.h"
#import "Contact.h"

@interface Venue : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Contact *contact;

@end
