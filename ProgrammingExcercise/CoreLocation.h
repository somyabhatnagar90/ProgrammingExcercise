//
//  CoreLocation.h
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CoreLocationDelegate <NSObject>
@required

- (void)update:(CLLocation *)location;
- (void)locationError:(NSError *)error;

@end

@interface CoreLocation : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocation *currentLocation;
@property (nonatomic, retain) id delegate;

@end
