//
//  ArduinoTableViewController.m
//  UaiTomationClient
//
//  Created by Bruno Pinheiro on 1/5/15.
//  Copyright (c) 2015 Bruno Pinheiro. All rights reserved.
//

#import "ArduinoTableViewController.h"
#import "ArduinoService.h"

@interface ArduinoTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *serverAddres;
@property (weak, nonatomic) IBOutlet UILabel *doorLockStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *airConditionerOnStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *airConditionerTemperatureLabel;

@end

@implementation ArduinoTableViewController

- (IBAction)doorLockValueChanged:(UISwitch *)sender {
    NSString *oldValue = self.airConditionerTemperatureLabel.text;
    
    self.doorLockStateLabel.text = sender.isOn ? @"On" : @"Off";
    
    DeviceState state = sender.isOn ? DeviceStateOn : DeviceStateOff;
    
    [[ArduinoService sharedInstance] setDorLockState:state success:^(NSDictionary *stats) {
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
    
    [[ArduinoService sharedInstance] setAirConditionerState:state success:^(NSDictionary *stats) {
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
    
    self.airConditionerTemperatureLabel.text = [NSString stringWithFormat:@"%.0lfºC", sender.value];
    
    [[ArduinoService sharedInstance] setAirConditionerTemperature:sender.value success:^(NSDictionary *stats) {
        NSLog(@"Air conditioner state changed successfuly");
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Air conditioner state change failed with error: %@", error];
        NSLog(@"%@", errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"Command failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        
        self.airConditionerTemperatureLabel.text = oldValue;
    }];
}

@end
