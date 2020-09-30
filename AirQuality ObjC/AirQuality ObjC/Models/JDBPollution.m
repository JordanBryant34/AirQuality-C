//
//  JDBPollution.m
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "JDBPollution.h"

@implementation JDBPollution

static NSString * const aqiKey = @"aqius";

- (instancetype)initWithInt:(NSInteger)aqi {
    self = [super init];
    
    if (self) {
        _airQualityIndex = aqi;
    }
    
    return self;
}

@end

@implementation JDBPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary {
    NSInteger aqi = [dictionary[aqiKey] integerValue];
    
    return [[JDBPollution alloc] initWithInt:aqi];
}

@end
