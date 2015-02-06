//
//  MapViewController.m
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//

#import "MapViewController.h"
#import "MapPoint.h"

@interface MapViewController () {
    BOOL firstLaunch;
}

@end

@implementation MapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
     // Do any additional setup after loading the view.

    firstLaunch = YES;
    
    //Setup MapView
    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    //Plot annotations
    [self plotPositions];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)plotPositions {
    
    CLLocationCoordinate2D coffeeCoordinate;
    coffeeCoordinate.latitude = self.latitude.doubleValue;
    coffeeCoordinate.longitude = self.longitude.doubleValue;
    
    MapPoint *mapPointObject = [[MapPoint alloc] initWithCoordinate:coffeeCoordinate];
    
    [self.mapView addAnnotation:mapPointObject];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"MapPoint";
    
    if ([annotation isKindOfClass:[MapPoint class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = NO;
        annotationView.animatesDrop = YES;
        return annotationView;
    }
    return nil;
}

#pragma mark - MKMapViewDelegate methods

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    CLLocationCoordinate2D centre = {self.latitude.doubleValue, self.longitude.doubleValue};
    MKCoordinateRegion region;
    
    MKCoordinateSpan span;
    span.latitudeDelta = .05;
    span.longitudeDelta =.02;
    
    if (firstLaunch) {
        region = MKCoordinateRegionMake(locationManager.location.coordinate, span);
        firstLaunch = NO;
    } else {
        region = MKCoordinateRegionMake(centre, span);
        
    }
    [mapView setRegion:region animated:YES];
}

@end
