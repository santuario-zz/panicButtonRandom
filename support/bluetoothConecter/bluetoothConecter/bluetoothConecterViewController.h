//
//  bluetoothConecterViewController.h
//  bluetoothConecter
//
//  Created by 3π on 6/5/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

/*
 Bluetooth Device MODEL 918561
 
 Services:
 
 ffe0
 1803 Link Loss
 1802 Immediate Alert
 1804 Tx Power
 180f Battery Service
 180a Device Information
 */

#import <UIKit/UIKit.h>

@import CoreBluetooth;
@import QuartzCore;


#define PANIC_BUTTON_DEVICE_INFO_SERVICE_UUID @"180a"
#define PANIC_BUTTON_DEVICE_BATTERY_SERVICE_UUID @"180f"
#define PANIC_BUTTON_DEVICE_TX_POWER_SERVICE_UUID @"1804"
#define PANIC_BUTTON_DEVICE_IMMEDIATE_ALERT_SERVICE_UUID @"1802"
#define PANIC_BUTTON_DEVICE_LINK_LOSS_SERVICE_UUID @"1803"
#define PANIC_BUTTON_DEVICE_SERVICE_UUID @"ffe0"

#define PANIC_BUTTON_DEVICE_CHARACTERISTIC_UUID @"ffe1"
#define PANIC_BUTTON_DEVICE_ALERT_LEVEL_CHARACTERISTIC_UUID @"2A06"







@interface bluetoothConecterViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate>

// Bluetooth
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *panicButtonPeripheral;

// Properties for your Object controls
@property (nonatomic, strong) IBOutlet UITextView  *deviceInfoTextView;
@property (nonatomic, strong) IBOutlet UITextView  *linkLossTextView;
@property (nonatomic, strong) IBOutlet UITextView  *serviceTextView;

// Properties to hold data characteristics for the peripheral device
@property (nonatomic, strong) NSString   *connected;
@property (nonatomic, strong) NSString   *panicButtonDeviceData;
@property (nonatomic, strong) NSString   *panicButtonLinkLossData;
@property (nonatomic, strong) NSString   *panicButtonServiceData;





@end
