//
//  JDBCityAirQuality.h
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDBWeather.h"
#import "JDBPollution.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDBCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString * city;
@property (nonatomic, copy, readonly) NSString * state;
@property (nonatomic, copy, readonly) NSString * country;
@property (nonatomic, copy, readonly) JDBWeather * weather;
@property (nonatomic, copy, readonly) JDBPollution * pollution;

-(instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(JDBWeather *)weather pollution:(JDBPollution *)pollution;

@end

@interface JDBCityAirQuality (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
