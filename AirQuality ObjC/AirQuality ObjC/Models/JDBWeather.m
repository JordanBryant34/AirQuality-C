//
//  JDBWeather.m
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "JDBWeather.h"

@implementation JDBWeather

static NSString * const temperatureKey = @"tp";
static NSString * const humidityKey = @"hu";
static NSString * const windSpeedKey = @"ws";

- (instancetype)initWithWeatherInfo:(NSInteger)temperature humidity:(NSInteger)humidity windSpeed:(NSInteger)windSpeed {
    
    self = [super init];
    
    if (self) {
        _temperature = temperature;
        _humidity = humidity;
        _windSpeed = windSpeed;
    }
    
    return self;
}

@end

@implementation JDBWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary {
    NSInteger temperature = [dictionary[temperatureKey] integerValue];
    NSInteger humidity = [dictionary[humidityKey] integerValue];
    NSInteger windSpeed = [dictionary[windSpeedKey] integerValue];
    
    return [[JDBWeather alloc] initWithWeatherInfo:temperature humidity:humidity windSpeed:windSpeed];
}

@end
