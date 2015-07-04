//
//  LocationManager.m
//
//
//  Created by Sam Lau on 6/13/15.
//
//

#import "LocationManager.h"
#import <ReactiveCocoa.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <MAMapKit/MAMapKit.h>

// Constants
static NSString* const kAMAP_API_KEY = @"abf0b40fdb4377ef5a7e4eaf6d6f7427";

@interface LocationManager () <MAMapViewDelegate, AMapSearchDelegate>

@property (copy, nonatomic) NSString* address;
// Location
@property (strong, nonatomic) MAMapView* mapView;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) NSString *currentCity;
// AMapSearch
@property (strong, nonatomic) AMapSearchAPI* mapSearch;
@property (strong, nonatomic) AMapPlaceSearchRequest *placeSearchRequest;

@end

@implementation LocationManager

#pragma mark - Initializer
+ (LocationManager*)shareInstance
{
    static LocationManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LocationManager alloc] init];
    });

    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }

    [MAMapServices sharedServices].apiKey = kAMAP_API_KEY;
    _mapView = [[MAMapView alloc] init];
    _mapView.delegate = self;

    _mapSearch = [[AMapSearchAPI alloc] initWithSearchKey:kAMAP_API_KEY Delegate:self];
    _mapSearch.language = AMapSearchLanguage_zh_CN;

    [[RACObserve(self, currentLocation) ignore:nil] subscribeNext:^(CLLocation* location) {
        AMapReGeocodeSearchRequest* request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];

        [_mapSearch AMapReGoecodeSearch:request];
    }];
    return self;
}

#pragma mark - Custom Accessors
- (AMapPlaceSearchRequest *)placeSearchRequest
{
    if (!_placeSearchRequest) {
        _placeSearchRequest = [AMapPlaceSearchRequest new];
        _placeSearchRequest.searchType = AMapSearchType_PlaceKeyword;
        _placeSearchRequest.requireExtension = YES;
    }
    
    return _placeSearchRequest;
}

#pragma mark - Business methods
- (void)findCurrentLocation
{
    self.mapView.showsUserLocation = YES;
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation
{
    if (userLocation) {
        self.currentLocation = [userLocation.location copy];
        self.mapView.showsUserLocation = NO;
    }
}
- (void)mapView:(MAMapView*)mapView didFailToLocateUserWithError:(NSError*)error
{
    self.address = nil;
}

- (void)searchHintResultsWithKeyWord:(NSString *)keyWord
{
    self.placeSearchRequest.keywords = keyWord;
    self.placeSearchRequest.city = @[self.currentCity];
    // send search request
    [self.mapSearch AMapPlaceSearch:self.placeSearchRequest];
}

#pragma mark - AMapSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest*)request response:(AMapReGeocodeSearchResponse*)response
{
    AMapAddressComponent* addressComponent = response.regeocode.addressComponent;
    if (addressComponent) {
        self.address = [NSString stringWithFormat:@"%@%@%@附近", addressComponent.district, addressComponent.township, addressComponent.neighborhood];
        // save the current city for search place
        self.currentCity = addressComponent.city;
    }
}

- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    // clear last search result data
    self.searchHintResults = nil;
    
    // search result empty
    if (response.pois.count == 0) {
        return;
    }
    
    // save the search result
    self.searchHintResults = response.pois;
}

@end
