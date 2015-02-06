//
//  MapViewController.h
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapPoint.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end
