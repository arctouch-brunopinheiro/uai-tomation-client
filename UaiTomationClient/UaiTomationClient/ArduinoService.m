//
//  AirConditionerService.m
//  UaiTomationClient
//
//  Created by Bruno Pinheiro on 1/5/15.
//  Copyright (c) 2015 Bruno Pinheiro. All rights reserved.
//

#import "ArduinoService.h"

#import <AFNetworking.h>

#define URL_FORMAT(_serverAddress, _command) [NSString stringWithFormat:@"http://%@/?%@", _serverAddress, _command]

@interface ArduinoService ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (assign, nonatomic) NSUInteger currentTemperature;

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
        AFCompoundResponseSerializer *serializer = [AFCompoundResponseSerializer serializer];
        serializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        self.manager = [AFHTTPRequestOperationManager manager];
        self.manager.responseSerializer = serializer;
    }
    return self;
}

#pragma mark - API Calls

- (void)setAirConditionerTemperature:(NSUInteger)temperature success:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure {
    NSString *requestUrl = URL_FORMAT(self.serverAddress, @(temperature).stringValue);
    
    [self.manager GET:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

- (void)setAirConditionerState:(DeviceState)deviceState currentTemperature:(NSUInteger)temperature success:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure {
    self.currentTemperature = temperature;
    NSString *deviceStateValue = [self stateAsString:deviceState];
    
    NSString *requestUrl = URL_FORMAT(self.serverAddress, deviceStateValue);
    
    [self.manager GET:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

#pragma mark - Utilities

- (NSString *)stateAsString:(DeviceState)deviceState {
    NSString *deviceStateValue;
    switch (deviceState) {
        case DeviceStateOn:
            deviceStateValue = @(self.currentTemperature).stringValue;
            break;
        case DeviceStateOff:
            deviceStateValue = @"off";
            break;
    }
    return deviceStateValue;
}

@end
