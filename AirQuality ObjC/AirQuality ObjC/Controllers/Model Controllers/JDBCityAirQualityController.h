//
//  JDBCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by Jordan Bryant on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDBCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDBCityAirQualityController : NSObject

+(void)fetchSupportedCountries:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^) (JDBCityAirQuality *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
