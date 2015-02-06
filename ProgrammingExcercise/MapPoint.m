//
//  MapPoint.m
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//

#import "MapPoint.h"

@implementation MapPoint

@synthesize coordinate;

//Annotations
- (id)initWithCoordinate:(CLLocationCoordinate2D)coord {
    if ((self = [super init])) {
        coordinate = coord;
    }
    return self;
}

@end
