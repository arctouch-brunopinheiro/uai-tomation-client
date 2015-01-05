//
//  ArduinoTableViewController.m
//  UaiTomationClient
//
//  Created by Bruno Pinheiro on 1/5/15.
//  Copyright (c) 2015 Bruno Pinheiro. All rights reserved.
//

#import "ArduinoTableViewController.h"

@interface ArduinoTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *doorLockStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *airConditionerOnStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *airConditionerTemperatureLabel;

@end

@implementation ArduinoTableViewController

- (IBAction)doorLockValueChanged:(UISwitch *)sender {
    self.doorLockStateLabel.text = sender.isOn ? @"On" : @"Off";
}

- (IBAction)airConditionerOnStateChanged:(UISwitch *)sender {
    self.airConditionerOnStateLabel.text = sender.isOn ? @"On" : @"Off";
}

- (IBAction)airConditionerTemperatureChanged:(UIStepper *)sender {
    self.airConditionerTemperatureLabel.text = [NSString stringWithFormat:@"%.0lfºC", sender.value];
}

@end
