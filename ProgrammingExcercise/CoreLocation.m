//
//  CoreLocation.m
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//

#import "CoreLocation.h"
#import <CoreLocation/CoreLocation.h>

@implementation CoreLocation

- (id)init {
    self = [super init];
    if(self != nil) {
        
        //initializing the CLLocationManager
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //setting the authorization
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    NSLog(@"%@", [locations lastObject]);
    
    CLLocation *newLocation = [locations lastObject];
    
    [self.delegate update:newLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.delegate locationError:error];
}

@end
