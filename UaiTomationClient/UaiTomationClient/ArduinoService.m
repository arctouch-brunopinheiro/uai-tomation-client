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

- (void)setAirConditionerState:(DeviceState)deviceState success:(ArduinoRequestSuccess)success failure:(ArduinoRequestFailure)failure {
    
    NSString *deviceStateValue;
    
    switch (deviceState) {
        case DeviceStateOn:
            deviceStateValue = @"On";
            break;
        case DeviceStateOff:
            deviceStateValue = @"Off";
            break;
    }
    
    NSString *requestUrl = URL_FORMAT(self.serverAddress, deviceStateValue);
    
    [self.manager GET:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
