//
//  JDBCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "JDBCityAirQualityController.h"
#import "JDBCityAirQuality.h"

@implementation JDBCityAirQualityController

static NSString * const baseURLString = @"https://api.airvisual.com/v2";
static NSString * const countriesComponent = @"countries";
static NSString * const statesComponenet = @"states";
static NSString * const citiesComponent = @"cities";
static NSString * const cityDetailsComponent = @"city";
static NSString * const apiKey = @"cd220acc-8090-4394-bc4e-eadbda8e1004";

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion {
    
    NSURL *baseUrl = [NSURL URLWithString:baseURLString];
    NSURL *countriesUrl = [baseUrl URLByAppendingPathComponent:countriesComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countriesUrl resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalUrl = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            NSLog(@"Error fetching supported countries: %@", error.localizedDescription);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });

        }
        
        if (!data) {
            NSLog(@"No data received from fetching supported countries.");
        
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error: &error];
        NSArray *countryDictionariesArray = topLevelDictionary[@"data"];
        
        NSMutableArray *countriesPlaceholder = [NSMutableArray array];
        
        NSLog(@"%@", countryDictionariesArray);
        
        for (NSDictionary *countryDictionary in countryDictionariesArray) {
            [countriesPlaceholder addObject: countryDictionary[@"country"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(countriesPlaceholder);
        });
        
    }] resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion {
    
    NSURL *baseUrl = [NSURL URLWithString:baseURLString];
    NSURL *statesUrl = [baseUrl URLByAppendingPathComponent:statesComponenet];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    [queryItems addObject:apiKeyQuery];
    [queryItems addObject:countryQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:statesUrl resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalUrl = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching states in country: %@", error.localizedDescription);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
            
        }
        
        if (!data) {
            NSLog(@"No data received from fetching states in country.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error: &error];
        NSArray *stateDictionariesArray = topLevelDictionary[@"data"];
        
        NSMutableArray *statesPlaceholder = [NSMutableArray array];
        
        NSLog(@"%@", stateDictionariesArray);
        
        for (NSDictionary *stateDictionary in stateDictionariesArray) {
            [statesPlaceholder addObject: stateDictionary[@"state"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(statesPlaceholder);
        });
        
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion {
    
    NSURL *baseUrl = [NSURL URLWithString:baseURLString];
    NSURL *citiesUrl = [baseUrl URLByAppendingPathComponent:citiesComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    
    [queryItems addObject:apiKeyQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:stateQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:citiesUrl resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalUrl = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching cities in state: %@", error.localizedDescription);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
            
        }
        
        if (!data) {
            NSLog(@"No data received from fetching cities in state.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error: &error];
        NSArray *citiesDictionaryArray = topLevelDictionary[@"data"];
        
        NSMutableArray *citiesPlaceholder = [NSMutableArray array];
        
        NSLog(@"%@", citiesDictionaryArray);
        
        for (NSDictionary *cityDictionary in citiesDictionaryArray) {
            [citiesPlaceholder addObject: cityDictionary[@"city"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(citiesPlaceholder);
        });
        
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(JDBCityAirQuality * _Nullable))completion {
    
    NSURL *baseUrl = [NSURL URLWithString:baseURLString];
    NSURL *cityDetailsUrl = [baseUrl URLByAppendingPathComponent:cityDetailsComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    
    [queryItems addObject:apiKeyQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:cityQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityDetailsUrl resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalUrl = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching cities in state: %@", error.localizedDescription);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
            
        }
        
        if (!data) {
            NSLog(@"No data received from fetching cities in state.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error: &error];
        NSDictionary *detailsDictionary = topLevelDictionary[@"data"];
        
        JDBCityAirQuality *cityDetails = [[JDBCityAirQuality alloc] initWithDictionary:detailsDictionary];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(cityDetails);
        });
    
    }] resume];
}

@end
