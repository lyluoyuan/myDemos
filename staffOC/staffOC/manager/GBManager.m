//
//  GBManager.m
//  UE
//
//  Created by zm002 on 16/7/19.
//  Copyright © 2016年 tl. All rights reserved.
//

#import "GBManager.h"
#import <math.h>

@implementation GBManager

+(void)storeCodeWithCode:(NSString *)code{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:code forKey:@"code"];
    [def synchronize];
}

+(NSString *)getStoredCode{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSString *code=[def objectForKey:@"code"];
    return code;
}

+(void)storePhoneNumberWithPhone:(NSString *)phone{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:phone forKey:@"phone"];
    [def synchronize];
}

+(NSString *)getStoredPhoneNumber{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSString *phone=[def objectForKey:@"phone"];
    return phone;
}
+(void)storeSwitchStateWithState:(BOOL)state{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:@(state) forKey:@"state"];
    [def synchronize];
}

+(BOOL)getSwitchState{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSNumber *state=[def objectForKey:@"state"];
    return [state boolValue];
}

@end
