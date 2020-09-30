//
//  JDBCityAirQuality.m
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "JDBCityAirQuality.h"

@implementation JDBCityAirQuality

static NSString * const cityKey = @"city";
static NSString * const stateKey = @"state";
static NSString * const countryKey = @"country";
static NSString * const currentKey = @"current";
static NSString * const weatherKey = @"weather";
static NSString * const pollutionKey = @"pollution";

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(JDBWeather *)weather pollution:(JDBPollution *)pollution {
    
    self = [super init];
    
    if (self) {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    
    return self;
}

@end

@implementation JDBCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary {
    NSString *city = dictionary[cityKey];
    NSString *state = dictionary[stateKey];
    NSString *country = dictionary[countryKey];
    
    NSDictionary *weatherDict = dictionary[currentKey][weatherKey];
    NSDictionary *pollutionDict = dictionary[currentKey][pollutionKey];
    
    JDBWeather *weather = [[JDBWeather alloc] initWithDictionary:weatherDict];
    JDBPollution *pollution = [[JDBPollution alloc] initWithDictionary:pollutionDict];
    
    return [[JDBCityAirQuality alloc] initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
