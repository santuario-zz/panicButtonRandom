//
//  LGViewController.m
//  LGBluetoothExample
//
//  Created by David Sahakyan on 2/7/14.
//  Copyright (c) 2014 David Sahakyan. All rights reserved.
//

#import "LGViewController.h"

#import "LGBluetooth.h"

@implementation LGViewController

- (IBAction)testPressed:(UIButton *)sender
{
    // Scaning 4 seconds for peripherals
    [[LGCentralManager sharedInstance] scanForPeripheralsByInterval:4
                                                         completion:^(NSArray *peripherals)
     {
         // If we found any peripherals sending to test
         if (peripherals.count) {
             NSLog(@"peripherals.count :: %@", [@(peripherals.count) stringValue] );
             //[self testPeripheral:peripherals[0]];
             [self connectToPanicButtonDevice:peripherals[0]];
         }
         
         
         
         [LGUtils readDataFromCharactUUID:@"ffe1"
                              serviceUUID:@"ffe0"
                               peripheral:peripherals[0]
                               completion:^(NSData *data, NSError *error) {
                                   NSLog(@"Data : %s Error : %@", (char *)[data bytes], error);
                               }];
         
         
     }];
}

- (void)testPeripheral:(LGPeripheral *)peripheral
{


    // First of all, opening connection
    [peripheral connectWithCompletion:^(NSError *error) {
        // Discovering services of peripheral
        [peripheral discoverServicesWithCompletion:^(NSArray *services, NSError *error) {
            // Searching in all services, our - 5ec0 service
            for (LGService *service in services) {
                if ([service.UUIDString isEqualToString:@"5ec0"]) {
                    // Discovering characteristics of 5ec0 service
                    [service discoverCharacteristicsWithCompletion:^(NSArray *characteristics, NSError *error) {
                        __block int i = 0;
                        // Searching writable characteristic - cef9
                        for (LGCharacteristic *charact in characteristics) {
                            if ([charact.UUIDString isEqualToString:@"cef9"]) {
                                [charact writeByte:0xFF completion:^(NSError *error) {
                                    if (++i == 3) {
                                        [peripheral disconnectWithCompletion:nil];
                                    }
                                }];
                            } else {
                                // Otherwise reading value
                                [charact readValueWithBlock:^(NSData *data, NSError *error) {
                                    if (++i == 3) {
                                        [peripheral disconnectWithCompletion:nil];
                                    }
                                }];
                            }
                        }
                    }];
                }
            }
        }];
    }];
    
    
}


-(void)connectToPanicButtonDevice:(LGPeripheral *)peripheral{
    
    [peripheral connectWithCompletion:^(NSError *error) {
        // Discovering services of peripheral
        [peripheral discoverServicesWithCompletion:^(NSArray *services, NSError *error) {
            // Searching in all services, our - 5ec0 service
            for (LGService *service in services) {
                
                NSLog(@"Service :: %@ UUID :: %@", service.description, service.UUIDString);
                
                
                
                if ([service.UUIDString isEqualToString:@"ffe0"]) {
                    // Discovering characteristics of 5ec0 service
                    [service discoverCharacteristicsWithCompletion:^(NSArray *characteristics, NSError *error) {
                       
                        // Searching writable characteristic
                        for (LGCharacteristic *charact in characteristics) {
       
                            NSLog(@"characteristics :: %@" , charact.UUIDString);
                            
                            
                        }
                    }];
                }
                
                
                
            }
        }];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialization of CentralManager
    [LGCentralManager sharedInstance];
}




/*
ffe0
1803 Link Loss
1802 Immediate Alert
1804 Tx Power
180f Battery Service
180a Device Information
*/


@end
