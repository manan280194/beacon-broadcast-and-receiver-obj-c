# beacon-broadcast-and-receiver-obj-c
Demo examples to broadcast and receive BLE signals in iPhone

## Usage:

To run demo project. Perform following steps on both project and you can run project.

## Broadcast

Step - 1: Open project and Link following frameworks from build phases in project settings:
- CoreBluetooth.framework
- CoreLocation.framework

Step - 2: Navigate to ```ViewController.m``` file and set UDID and identifier as per given instruction the file.

Perform following steps if created new project.

Step - 3: Open project navigate to Capabilities in project settings.

Step - 4: Enable background modes and check followings:
- Acts as a Bluetooth LE accessory.

## Receiver

Step - 1: Link following frameworks from build phases in project settings:
- CoreBluetooth.framework
- CoreLocation.framework

Step - 2: Navigate to ```ViewController.m``` file and set UDID and identifier as per given instruction the file.

Perform following steps if created new project.

Step - 3: Add in Info.plist file.
- key: “Privacy - Location Always Usage Description” and 
- value: “Beacon Receiver Location” 

Step - 4: Open project navigate to Capabilities in project settings.

Step - 5: Enable background modes and check followings:
- Location updates
- Uses Bluetooth LE accessories

## Run

Both projects are ready to run. First start broadcasting signals from Broadcast app. Signals will be received automatically when app starts in Receiver app.

## Features

- Make iPhone work as a Beacon and send BLE signals.
- Receive BLE signals.
- Get notified when.
    Entered in region.
    Already in region.
    Exited from region.
- Broadcasting signals in background mode (Under development).

## Author
- Virtual Reality Systems

## Contact Us
- info@virtualrealitysystems.net

## WebSite
- [Virtual Reality Systems](http://www.virtualrealitysystems.net/site/)
