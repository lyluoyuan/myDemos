//
//  GBApi.h
//  UE
//
//  Created by zm002 on 16/7/20.
//  Copyright © 2016年 tl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Zjson.h"
@interface GBApi : NSObject
-(instancetype)initWithUrl:(NSString *)url params:(NSMutableDictionary<id,id> *)params vc:(UIViewController*) vc;
-(void)post;
@property(nonatomic,strong) void(^successBlock)(Zjson *zjson);
@property(nonatomic,strong) void(^failureBlock)(Zjson *zjson);
@property(nonatomic,strong) void(^errorBlock)();
+(void)getLogInCode;

+(void)loginWithUser:(NSString *)user withCode:(NSString *)code;

+(void)cancelLogin;

+(void)changeCodeWithOldPassword:(NSString *)old_password withNewPassword:(NSString *)renew_password withReWritePassword:(NSString *)rewrite_password;

+(void)getRecycleBoxListWithMinLongitude:(CGFloat)min_longgitude withMinLatitude:(CGFloat)min_latitude withMaxLongitude:(CGFloat)max_longtitude withMaxLatitude:(CGFloat)max_latitude;

+(void)getApartList;

+(void)getAppointmentList;

+(void)uploadLocationWithLongitude:(CGFloat)longitude withLatitude:(CGFloat)latitude withUUID:(NSString *)uuid;
@end
