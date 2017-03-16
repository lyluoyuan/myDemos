//
//  Wifi.h
//  wifiDemo
//
//  Created by zm004 on 16/6/28.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
@interface Wifi : NSObject
+ (NSString *)getWifiName;
@end
