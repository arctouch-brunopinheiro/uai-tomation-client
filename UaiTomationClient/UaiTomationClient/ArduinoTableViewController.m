//
//  ArduinoTableViewController.m
//  UaiTomationClient
//
//  Created by Bruno Pinheiro on 1/5/15.
//  Copyright (c) 2015 Bruno Pinheiro. All rights reserved.
//

#import "ArduinoTableViewController.h"
#import "ArduinoService.h"

static NSUInteger const kMaxTemperature = 24;
static NSUInteger const kMinTemperature = 16;

@interface ArduinoTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *serverAddress;
@property (weak, nonatomic) IBOutlet UILabel *airConditionerOnStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *airConditionerTemperatureLabel;
@property (weak, nonatomic) IBOutlet UIStepper *airConditionerTemperatureStepper;

@property (assign, nonatomic) NSUInteger temperature;

@end

@implementation ArduinoTableViewController

- (void)viewDidLoad {
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.scrollEnabled = NO;
    
    self.temperature = (kMaxTemperature + kMinTemperature) / 2;
    self.airConditionerTemperatureStepper.value = self.temperature;
    self.airConditionerTemperatureStepper.maximumValue = kMaxTemperature;
    self.airConditionerTemperatureStepper.minimumValue = kMinTemperature;
    
    [self updateTemperatureLabel:self.temperature];
    [self updateStateLabel:YES];
}

- (void)updateTemperatureLabel:(NSUInteger)temperature {
    self.airConditionerTemperatureLabel.text = [NSString stringWithFormat:@"Temperature %.0luºC", (unsigned long)temperature];
}

- (void)updateStateLabel:(BOOL)isOn {
    self.airConditionerOnStateLabel.text = isOn ? @"On" : @"Off";
}

- (IBAction)airConditionerOnStateChanged:(UISwitch *)sender {
    [self updateStateLabel:sender.isOn];
    
    DeviceState state = sender.isOn ? DeviceStateOn : DeviceStateOff;
    
    [[ArduinoService sharedInstanceWithServerAddress:self.serverAddress.text] setAirConditionerState:state currentTemperature:self.temperature success:^(NSDictionary *stats) {
        NSLog(@"Air conditioner state changed successfuly");
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Air conditioner state change failed with error: %@", error];
        NSLog(@"%@", errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"Command failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        
        [self updateStateLabel:!sender.isOn];
        sender.on = !sender.isOn;
    }];
}

- (IBAction)airConditionerTemperatureChanged:(UIStepper *)sender {
    [self updateTemperatureLabel:sender.value];
    
    [[ArduinoService sharedInstanceWithServerAddress:self.serverAddress.text] setAirConditionerTemperature:sender.value success:^(NSDictionary *stats) {
        self.temperature = sender.value;
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Air conditioner state change failed with error: %@", error];
        NSLog(@"%@", errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"Command failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [self updateTemperatureLabel:self.temperature];
    }];
}

- (IBAction)brunoModeClicked:(UIButton *)sender {
    int temperature = 16;
    [self updateTemperatureLabel:temperature];
    
    [[ArduinoService sharedInstanceWithServerAddress:self.serverAddress.text] setAirConditionerTemperature:temperature success:^(NSDictionary *stats) {
        self.temperature = temperature;
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Air conditioner state change failed with error: %@", error];
        NSLog(@"%@", errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"Command failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [self updateTemperatureLabel:self.temperature];
    }];
}

- (IBAction)mommModeClicked:(UIButton *)sender {
    int temperature = 32;
    [self updateTemperatureLabel:temperature];
    
    [[ArduinoService sharedInstanceWithServerAddress:self.serverAddress.text] setAirConditionerTemperature:temperature success:^(NSDictionary *stats) {
        self.temperature = temperature;
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Air conditioner state change failed with error: %@", error];
        NSLog(@"%@", errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"Command failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [self updateTemperatureLabel:self.temperature];
    }];
}
- (IBAction)goodForEverybodyClicked:(UIButton *)sender {
    int temperature = 22;
    [self updateTemperatureLabel:temperature];
    
    [[ArduinoService sharedInstanceWithServerAddress:self.serverAddress.text] setAirConditionerTemperature:99 success:^(NSDictionary *stats) {
        self.temperature = temperature;
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Air conditioner state change failed with error: %@", error];
        NSLog(@"%@", errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"Command failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [self updateTemperatureLabel:self.temperature];
    }];
}
@end
