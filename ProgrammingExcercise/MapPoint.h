//
//  MapPoint.h
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapPoint : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D) coord;

@end
