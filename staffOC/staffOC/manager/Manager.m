//
//  Manager.m
//  staffOC
//
//  Created by zm004 on 16/8/18.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import "Manager.h"

@implementation Manager
+(NSMutableURLRequest *)setRequestWithLink:(NSString *)link{
    NSDictionary *info=[[NSBundle mainBundle] infoDictionary];
    NSString *path = [[NSMutableString alloc]initWithString:link];
    path=[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url=[NSURL URLWithString:link];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    [request setValue:@"2" forHTTPHeaderField:@"Appterminal"];
    [request setValue:info[@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
    [request setValue:@"1" forHTTPHeaderField:@"Apptype"];
    request.timeoutInterval=20.0f;
    return request;
}
+(void)todoWithRequest:(NSMutableURLRequest *)quest{
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:quest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *http_response=(NSHTTPURLResponse *)response;
        NSLog(@"%@",error);
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
        
        if(http_response.statusCode==200){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if([dict[@"success"] boolValue]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    [[NSNotificationCenter defaultCenter] postNotificationName:noti object:@"success" userInfo:dict];
                });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    [[NSNotificationCenter defaultCenter] postNotificationName:noti object:dict[@"detail"] userInfo:nil];
                });
            }
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [[NSNotificationCenter defaultCenter] postNotificationName:noti object:@"请求失败" userInfo:nil];
            });
        }
    }];
    [task resume];
}
@end
