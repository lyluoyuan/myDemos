//
//  Wifi.m
//  wifiDemo
//
//  Created by zm004 on 16/6/28.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import "Wifi.h"

@implementation Wifi
+ (NSString *)getWifiName

{
    
    NSString *wifiName = nil;
    
    
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    
    
    if (!wifiInterfaces) {
        
        return nil;
        
    }
    
    
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    
    
    for (NSString *interfaceName in interfaces) {
        
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        
        
        if (dictRef) {
            
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            NSLog(@"network info -> %@", networkInfo);
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            
            
            
            CFRelease(dictRef);
            
        }
        
    }
    
    
    
    CFRelease(wifiInterfaces);
    
    return wifiName;
    
}
@end
