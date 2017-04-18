//
//  ViewController.h
//  Beacon
//
//  Created by Vimal Rughani on 03/02/17.
//  Copyright © 2017 Virtual Reality Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController <CBPeripheralManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) NSDictionary *myBeaconData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

- (IBAction)buttonClicked:(id)sender;
- (IBAction)stopBroadcast:(id)sender;

@end

