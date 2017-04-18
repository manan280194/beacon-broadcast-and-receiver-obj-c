//
//  ViewController.m
//  BeaconReceiver
//
//  Created by Vimal Rughani on 04/02/17.
//  Copyright © 2017 Virtual Reality Systems. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        beaconsList = [[NSMutableArray alloc] init];
        beaconsCount = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    ---------- Setup Location Manager ---------- //
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //    ---------- Place your UDID and beacon identifier here. ---------- //
    //    ---------- Remember to set both the UDID and identifier same in both project. identifier - com.vrs.ios.BeaconReceiver ---------- //
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"your device UDID"];
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:1 minor:1 identifier:@"identifier"];
    
    //    ---------- Start monitoring for region ---------- //
    [self.myBeaconRegion setNotifyEntryStateOnDisplay:YES];
    [self.myBeaconRegion setNotifyOnExit:YES];
    [self.myBeaconRegion setNotifyOnEntry:YES];
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    
    //    ---------- Stop Monitoring when app will terminated ---------- //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillTerminate) name:@"terminate" object:nil];
    
    //    ---------- Remove extra space from table view ---------- //
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    [self.locationManager startUpdatingLocation];
    [self presentAlertWithMessage:@"Entered in region"];
}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    [self.locationManager stopUpdatingLocation];
    [self presentAlertWithMessage:@"Exited from Region"];
}


- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    switch (state) {
        case 0:
            [self presentAlertWithMessage:@"It is unknown whether the location is inside or outside of the region."];
            break;
        case 1:
            [self presentAlertWithMessage:@"The location is inside the given region."];
            [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
            break;
        case 2:
            [self presentAlertWithMessage:@"The location is outside of the given region."];
            break;
        default:
            break;
    }
}


- (void)locationManager:(CLLocationManager*)manager
        didRangeBeacons:(NSArray*)beacons
               inRegion:(CLBeaconRegion*)region
{
    //    ---------- Beacon found ----------- //
    CLBeacon *foundBeacon = [beacons firstObject];
    
    //    ---------- You can retrieve the beacon data from its properties ----------- //
    NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
    NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
    
    if (uuid != nil) {
        //    ---------- Manage table view data ----------- //
        if (![beaconsList containsObject:uuid]) {
            [beaconsList addObject:uuid];
            [beaconsCount addObject:[NSNumber numberWithInteger:1]];
            NSString *message = [NSString stringWithFormat:@"Beacon found: UUID: %@ Major: %@ Minor: %@", uuid, major, minor];
            [self.tableView reloadData];
            [self presentAlertWithMessage:message];
        } else {
            NSInteger index = [beaconsList indexOfObject:uuid];
            NSInteger countAtIndex = [[beaconsCount objectAtIndex:index] integerValue];
            countAtIndex ++;
            [beaconsCount replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:countAtIndex]];
            [self.tableView reloadData];
        }
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [beaconsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *beaconUUID = [beaconsList objectAtIndex:indexPath.row];
    NSInteger count = [[beaconsCount objectAtIndex:indexPath.row] integerValue];
    [cell.textLabel setText:beaconUUID];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld", count]];
    return cell;
}


#pragma mark - Helper

- (UIViewController *)topMostViewController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


- (void)presentAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Beacon" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:dismiss];
    [[self topMostViewController] presentViewController:alertController animated:YES completion:nil];
}


- (void)appWillTerminate {
    [self.locationManager stopMonitoringForRegion:self.myBeaconRegion];
}
@end
