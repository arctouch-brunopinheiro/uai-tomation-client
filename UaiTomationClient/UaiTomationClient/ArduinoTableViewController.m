//
//  ArduinoTableViewController.m
//  UaiTomationClient
//
//  Created by Bruno Pinheiro on 1/5/15.
//  Copyright (c) 2015 Bruno Pinheiro. All rights reserved.
//

#import "ArduinoTableViewController.h"
#import "ArduinoService.h"

#define TemperatureStepperDefaultValue 21.0

@interface ArduinoTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *serverAddress;
@property (weak, nonatomic) IBOutlet UILabel *doorLockStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *airConditionerOnStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *airConditionerTemperatureLabel;
@property (weak, nonatomic) IBOutlet UIStepper *airConditionerTemperatureStepper;

@end

@implementation ArduinoTableViewController

- (void)viewWillAppear:(BOOL)animated {
    self.airConditionerTemperatureStepper.value = TemperatureStepperDefaultValue;
}

- (IBAction)doorLockValueChanged:(UISwitch *)sender {
    NSString *oldValue = self.airConditionerTemperatureLabel.text;
    
    self.doorLockStateLabel.text = sender.isOn ? @"On" : @"Off";
    
    DeviceState state = sender.isOn ? DeviceStateOn : DeviceStateOff;
    
    [[ArduinoService sharedInstanceWithServerAddress:self.serverAddress.text] setDorLockState:state success:^(NSDictionary *stats) {
        NSLog(@"Door lock state changed successfuly");
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Air conditioner state change failed with error: %@", error];
        NSLog(@"%@", errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"Command failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        
        self.doorLockStateLabel.text = oldValue;
    }];
}

- (IBAction)airConditionerOnStateChanged:(UISwitch *)sender {
    NSString *oldValue = self.airConditionerTemperatureLabel.text;
    
    self.airConditionerOnStateLabel.text = sender.isOn ? @"On" : @"Off";
  
    DeviceState state = sender.isOn ? DeviceStateOn : DeviceStateOff;
    
    [[ArduinoService sharedInstanceWithServerAddress:self.serverAddress.text] setAirConditionerState:state success:^(NSDictionary *stats) {
        NSLog(@"Air conditioner state changed successfuly");
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Air conditioner state change failed with error: %@", error];
        NSLog(@"%@", errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"Command failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        
        self.airConditionerOnStateLabel.text = oldValue;
    }];
}

- (IBAction)airConditionerTemperatureChanged:(UIStepper *)sender {
    NSString *oldValue = self.airConditionerTemperatureLabel.text;
    
//    self.airConditionerTemperatureLabel.text = [NSString stringWithFormat:@"%.0lfºC", sender.value];
    
    BOOL temperatureIncreased = sender.value > TemperatureStepperDefaultValue;
    sender.value = TemperatureStepperDefaultValue;
    
    [[ArduinoService sharedInstanceWithServerAddress:self.serverAddress.text] setAirConditionerWarm:temperatureIncreased success:^(NSDictionary *stats) {
        NSLog(@"Air conditioner state changed successfuly");
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Air conditioner state change failed with error: %@", error];
        NSLog(@"%@", errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"Command failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        
        self.airConditionerTemperatureLabel.text = oldValue;
    }];
}


@end
