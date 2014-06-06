//
//  bluetoothConecterViewController.m
//  bluetoothConecter
//
//  Created by 3π on 6/5/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "bluetoothConecterViewController.h"

@interface bluetoothConecterViewController ()

@end

@implementation bluetoothConecterViewController


#pragma mark - Life Cycle Methods
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialize
#pragma mark -


-(void)initialize{
    
    self.panicButtonDeviceData = nil;
    
    // Scan for all available CoreBluetooth LE devices
	NSArray *services = @[[CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_BATTERY_SERVICE_UUID],
                          [CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_CHARACTERISTIC_UUID],
                          [CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_IMMEDIATE_ALERT_SERVICE_UUID],
                          [CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_INFO_SERVICE_UUID],
                          [CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_LINK_LOSS_SERVICE_UUID],
                          [CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_SERVICE_UUID]];
    
	CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
	
    [centralManager scanForPeripheralsWithServices:services options:nil];
	self.centralManager = centralManager;
    
}


#pragma mark - CBCentralManagerDelegate Methods
#pragma mark -

// method called whenever you have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    self.connected = [NSString stringWithFormat:@"Connected: %@", peripheral.state == CBPeripheralStateConnected ? @"YES" : @"NO"];
    NSLog(@"%@", self.connected);
    
    
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    if ([localName length] > 0) {
        NSLog(@"Found Panic Button Device: %@", localName);
        [self.centralManager stopScan];
        self.panicButtonPeripheral = peripheral;
        peripheral.delegate = self;
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

// method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // Determine the state of the peripheral
    
    NSString *stringState;
    if ([central state] == CBCentralManagerStatePoweredOff) {
        stringState = @"CoreBluetooth BLE hardware is powered off";
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        stringState = @"CoreBluetooth BLE hardware is powered on and ready";
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        stringState = @"CoreBluetooth BLE state is unauthorized";
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        stringState = @"CoreBluetooth BLE state is unknown";
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        stringState = @"CoreBluetooth BLE hardware is unsupported on this platform";
    }
    
    NSLog(@"%@", stringState);
    self.deviceInfoTextView.text = stringState;
}


#pragma mark - CBPeripheralDelegate Methods

// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service: %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{

    
    if ([service.UUID isEqual:[CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_BATTERY_SERVICE_UUID]])  {
        for (CBCharacteristic *aChar in service.characteristics)
        {
            NSLog(@"PANIC_BUTTON_DEVICE_BATTERY_SERVICE_UUID :: characteristic: %@", aChar);// battery level
        }
    }
    
    if ([service.UUID isEqual:[CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_TX_POWER_SERVICE_UUID]])  {
        for (CBCharacteristic *aChar in service.characteristics)
        {
            NSLog(@"PANIC_BUTTON_DEVICE_TX_POWER_SERVICE_UUID :: characteristic: %@", aChar);// 2A07
        }
    }
    
    if ([service.UUID isEqual:[CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_IMMEDIATE_ALERT_SERVICE_UUID]])  {
        for (CBCharacteristic *aChar in service.characteristics)
        {
            NSLog(@"PANIC_BUTTON_DEVICE_IMMEDIATE_ALERT_SERVICE_UUID :: characteristic: %@", aChar);// 2A06
        }
    }
    
    if ([service.UUID isEqual:[CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_LINK_LOSS_SERVICE_UUID]])  {
        for (CBCharacteristic *aChar in service.characteristics)
        {
            NSLog(@"PANIC_BUTTON_DEVICE_LINK_LOSS_SERVICE_UUID :: characteristic: %@", aChar);// 2A06
        }
    }
    
    if ([service.UUID isEqual:[CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_SERVICE_UUID]])  {
        for (CBCharacteristic *aChar in service.characteristics)
        {
            NSLog(@"PANIC_BUTTON_DEVICE_SERVICE_UUID :: characteristic: %@", aChar);// FFE1
            [self.panicButtonPeripheral setNotifyValue:YES forCharacteristic:aChar];
        }
    }
    
    
}

// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:PANIC_BUTTON_DEVICE_CHARACTERISTIC_UUID]]) { // 1
        [self getPanicButtonStatus:characteristic error:error];
    }
    

    
}


#pragma mark - CBCharacteristic Methods


-(void)getPanicButtonStatus:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@" :::: PANIC BUTTON PUSHED :::: %@", [characteristic value]);
}


-(void)checkPanicButtonLinkLoss:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@" :::: LINK LOSS :::: %@", [characteristic value]);
}

-(void)checkPanicButtonImmediateAlert:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@" :::: IMMEDIATE ALERT :::: %@", [characteristic value]);
}







@end
