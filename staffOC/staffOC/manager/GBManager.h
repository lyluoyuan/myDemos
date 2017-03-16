//
//  GBManager.h
//  UE
//
//  Created by zm002 on 16/7/19.
//  Copyright © 2016年 tl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GBManager : NSObject
+(void)storeCodeWithCode:(NSString *)code;

+(NSString *)getStoredCode;

+(void)storePhoneNumberWithPhone:(NSString *)phone;

+(NSString *)getStoredPhoneNumber;

+(void)storeSwitchStateWithState:(BOOL)state;

+(BOOL)getSwitchState;

@end
