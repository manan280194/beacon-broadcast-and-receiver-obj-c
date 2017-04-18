//
//  ViewController.h
//  BeaconReceiver
//
//  Created by Vimal Rughani on 04/02/17.
//  Copyright © 2017 Virtual Reality Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *beaconsList;
    NSMutableArray *beaconsCount;
    
}

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

