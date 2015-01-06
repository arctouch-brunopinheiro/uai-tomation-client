//
//  AirConditionerService.h
//  UaiTomationClient
//
//  Created by Bruno Pinheiro on 1/5/15.
//  Copyright (c) 2015 Bruno Pinheiro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ArduinoRequestSuccess)(NSDictionary *stats);
typedef void(^ArduinoRequestFailure)(NSError *error);

typedef NS_ENUM(NSInteger, DeviceState) {
    DeviceStateOn,
    DeviceStateOff
};

@interface ArduinoService : NSObject

@property (nonatomic, strong) NSString *serverAddress;

+ (instancetype)sharedInstanceWithServerAddress:(NSString *)serverAddress;

#pragma mark - Air Conditioner

- (void)setAirConditionerState:(DeviceState)deviceState currentTemperature:(NSUInteger)temperature success:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure;
- (void)setAirConditionerTemperature:(NSUInteger)temperature success:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure;

@end
