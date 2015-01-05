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
    DeviceStateUnknown = -1,
    DeviceStateOff = 0,
    DeviceStateOn = 1
};

@interface ArduinoService : NSObject

@property (nonatomic, strong) NSString *serverAddress;

+ (instancetype)sharedInstance;
- (void)fetchCurrentStatsWithSuccess:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure;

#pragma mark - Door Lock

- (void)setDorLockState:(DeviceState)deviceState success:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure;

#pragma mark - Air Conditioner

- (void)setAirConditionerState:(DeviceState)deviceState success:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure;
- (void)setAirConditionerTemperature:(NSUInteger)temperature WithSuccess:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure;

@end
