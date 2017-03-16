//
//  GBApi.m
//  UE
//
//  Created by zm002 on 16/7/20.
//  Copyright © 2016年 tl. All rights reserved.
//

#import "GBApi.h"
#import "links.h"
#import "notifications.h"
#import "Zjson.h"
#import "Manager.h"
@interface GBApi ()
@property(nonatomic,strong) NSString* url;
@property(nonatomic,strong) NSMutableDictionary<id,id>* params;
@property(nonatomic,strong) UIViewController* delegateVC;
//@property(nonatomic,strong) (void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))
@end
@implementation GBApi
-(void)todoWithRequest:(NSMutableURLRequest *)quest{
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:quest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *http_response=(NSHTTPURLResponse *)response;
        NSLog(@"%@",error);
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
//+(NSMutableURLRequest *)setRequestWithLink:(NSString *)link{
//    NSDictionary *info=[[NSBundle mainBundle] infoDictionary];
//    NSString *path=[NSString stringWithFormat:@"%@/%@",base_link,link];
//    path=[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSURL *url=[NSURL URLWithString:path];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod=@"POST";
//    [request setValue:@"2" forHTTPHeaderField:@"Appterminal"];
//    [request setValue:info[@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
//    [request setValue:@"8" forHTTPHeaderField:@"Apptype"];
//    request.timeoutInterval=20.0f;
//    
//    return request;
//}
-(NSMutableURLRequest *)setRequestWithLink:(NSString *)link{
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
-(instancetype)initWithUrl:(NSString *)url params:(NSMutableDictionary<id,id> *)params vc:(UIViewController*) vc{
    _url = [NSString stringWithFormat:@"%@%@",base_link,url];
    _params = params;
    _delegateVC = vc;
    return self;
}
-(void)post{
    NSMutableURLRequest *request = [Manager setRequestWithLink:_url];
    NSMutableString *bodyStr = [[NSMutableString alloc]initWithString:@""];
    Boolean ifFirst = true;
    for (NSString* d in _params.allKeys) {
        NSString *appendStr = [NSString stringWithFormat:@"%@=%@",d,_params[d]];
        if (!ifFirst){
            appendStr = [NSString stringWithFormat:@"&%@=%@",d,_params[d]];
        }
        ifFirst = false;
//        bodyStr = [NSString stringWithFormat:@"%@%@",bodyStr,appendStr];
        [bodyStr appendString:appendStr];
//        [bodyStr stringByAppendingString:appendStr];
    }
    NSLog(@"%@",bodyStr);
    request.HTTPBody=[bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [Manager todoWithRequest:request];
//    [self todoWithRequest:request];
}

@end
