//
//  MasterViewController.m
//  CoffeeKit
//
//  Created by Somya Bhatnagar on 31/01/2015.
//
//

#import "MasterViewController.h"
#import "Venue.h"
#import "VenueCell.h"
#import "Contact.h"
#import "MapViewController.h"
#import <RestKit/RestKit.h>

#define kCLIENTID "ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G"
#define kCLIENTSECRET "YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL"

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *venues;

@end

@implementation MasterViewController

@synthesize latitude;
@synthesize longitude;
@synthesize locationController;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Initialize object for CoreLocation class
    self.locationController = [[CoreLocation alloc] init];
    self.locationController.delegate = self;
    
    //Configure RestKit
    [self configureRestKit];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    //Start updating the location of the user
    [self.locationController.locationManager startUpdatingLocation];

    [self update:self.locationController.locationManager.location];
}

//CoreLocation class delegate

#pragma mark - CoreLocationDelegate method

- (void)update:(CLLocation *)location {
    self.latitude= [NSString stringWithFormat:@"%f", [location coordinate].latitude];
    self.longitude = [NSString stringWithFormat:@"%f", [location coordinate].longitude];
    
    //Load the Venue list after getting the user's current location
    [self loadVenues];
    [self.tableView reloadData];
}

- (void)locationError:(NSError *)error {
    self.latitude = [error description];
    self.longitude = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set labels to the cells
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];

    Venue *venue = _venues[indexPath.row];
    
    cell.nameLabel.text = venue.name;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.0fm", venue.location.distance.floatValue];
    [cell.phoneNumber setTitle:venue.contact.phone forState:UIControlStateNormal];
    
    return cell;
}

- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name"]];
    
    // define location object mapping
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    
    //define contact object mapping
    RKObjectMapping *contactMapping = [RKObjectMapping mappingForClass:[Contact class]];
    [contactMapping addAttributeMappingsFromDictionary:@{@"formattedPhone": @"formattedPhone", @"phone": @"phone", @"twitter": @"twitter"}];
    
    // define relationship mapping
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"contact" toKeyPath:@"contact" withMapping:contactMapping]];

    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:venueMapping method:RKRequestMethodGET pathPattern:@"/v2/venues/search" keyPath:@"response.venues" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];

}

- (void)loadVenues
{
    //set parameters to fetch data from the api
    
    //if you are running this app on a simulator I recommend using this
    //Even if the app is running on simulator and is taking a static latLon postion it will ask for user's current location authorization.
    //This is for the app to run on the device so I havent modified the code for both.
    //Follow the steps provided in the README.md file.
    
    NSString *latLon = @"37.33,-122.03"; // approximate latLon of The Mothership (a.k.a Apple headquarters)
    
    //Uncomment the following lines if you want to run the app on a device.
    
    // NSString *latLon = [NSString stringWithFormat:@"%@, %@", self.latitude, self.longitude];
    
    NSString *clientID = [NSString stringWithUTF8String:kCLIENTID];
    NSString *clientSecret = [NSString stringWithUTF8String:kCLIENTSECRET];
    
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:latLon, @"ll", clientID, @"client_id", clientSecret, @"client_secret", @"4bf58dd8d48988d1e0931735", @"categoryId", @"20140118", @"v", nil];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/search" parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        _venues = mappingResult.array;
        [self.tableView reloadData];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"What do you mean by 'there is no coffee?': %@", error);
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //forward pass the value to MapViewController
    if ([segue.identifier isEqualToString:@"DetailViewController"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Venue *venue = _venues[indexPath.row];
        MapViewController *mapViewController = segue.destinationViewController;
        mapViewController.latitude = venue.location.lat;
        mapViewController.longitude = venue.location.lng;
    }
}

@end
