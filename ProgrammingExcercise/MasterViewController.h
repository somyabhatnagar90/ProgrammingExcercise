//
//  MasterViewController.h
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocation.h"

@interface MasterViewController : UITableViewController <CoreLocationDelegate>

@property (nonatomic, weak) NSString *latitude;
@property (nonatomic, weak) NSString *longitude;

@property (nonatomic, strong) NSNumber *latitudeForCoffeePlace;
@property (nonatomic, strong) NSNumber *longitudeForCoffeePlace;

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, retain) CoreLocation *locationController;

@end
