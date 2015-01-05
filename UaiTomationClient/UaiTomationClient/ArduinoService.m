//
//  AirConditionerService.m
//  UaiTomationClient
//
//  Created by Bruno Pinheiro on 1/5/15.
//  Copyright (c) 2015 Bruno Pinheiro. All rights reserved.
//

#import "ArduinoService.h"

#import <AFNetworking.h>

@interface ArduinoService ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;


@end

@implementation ArduinoService

+ (instancetype)sharedInstance {
    static id sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

+ (instancetype)sharedInstanceWithServerAddress:(NSString *)serverAddress {
    id manager = [self sharedInstance];
    [manager setServerAddress:serverAddress];
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

- (void)fetchCurrentStatsWithSuccess:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure {
    
    [self.manager GET:@"http://example.com/stats.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
        
    }];
}

- (void)setAirConditionerState:(DeviceState)deviceState success:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure {
    
    NSUInteger deviceStateValue;
    
    switch (deviceState) {
        case DeviceStateOn:
            deviceStateValue = 1;
            break;
        case DeviceStateOff:
            deviceStateValue = 0;
            break;
        default:
            deviceStateValue = -1;
            break;
    }
    
    NSDictionary *parameters = @{@"status": @(deviceStateValue).stringValue};
    
    [self.manager POST:@"http://example.com/resources.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

- (void)setAirConditionerTemperature:(NSUInteger)temperature WithSuccess:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure {
    NSDictionary *parameters = @{@"status": @(temperature).stringValue};
    
    [self.manager POST:@"http://example.com/resources.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

@end
