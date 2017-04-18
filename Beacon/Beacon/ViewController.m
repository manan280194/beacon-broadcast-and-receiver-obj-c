//
//  ViewController.m
//  Beacon
//
//  Created by Vimal Rughani on 03/02/17.
//  Copyright © 2017 Virtual Reality Systems. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    ---------- Place your UDID and beacon identifier here. ---------- //
    //    ---------- Remember to set both the UDID and identifier same in both project. identifier - com.vrs.ios.Beacon ---------- //
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"your device UDID"];
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                  major:1
                                                                  minor:1
                                                             identifier:@"identifier"];
    
    /*
     The major and minor numbers are for you to identify your beacons if you have a whole bunch of them inside your location.Major can be used to identify main beacon and minor to identify sub beacon.
     */
}

#pragma mark - Action

- (IBAction)buttonClicked:(id)sender {
    //     ----- Get the beacon data to advertise. Utilised in PoweredOn state of peripheral device ----- //
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:[NSNumber numberWithInt:1]];
    
    //     ---------- Start the peripheral manager. ---------- //
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}


- (IBAction)stopBroadcast:(id)sender {
    [self.statusLabel setText:@"Stopped"];
    [self.peripheralManager stopAdvertising];
}


#pragma mark - Peripheral Manager Delegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        //    ---------- Bluetooth is on ---------- //
        //    ---------- Update our status label ---------- //
        self.statusLabel.text = @"Broadcasting...";
        
        //    ---------- Start broadcasting ---------- //
        [self.peripheralManager startAdvertising:self.myBeaconData];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        //    ---------- Update our status label ---------- //
        self.statusLabel.text = @"Bluetooth is turned OFF";
        
        //    ---------- Bluetooth isn't on. Stop broadcasting ---------- //
        [self.peripheralManager stopAdvertising];
    }
    else if (peripheral.state == CBPeripheralManagerStateUnsupported)
    {
        //    ---------- Update our status label ---------- //
        self.statusLabel.text = @"Unsupported";
    }
}
@end
