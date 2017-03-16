//
//  Zjson.m
//  staffOC
//
//  Created by zm004 on 16/7/28.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import "Zjson.h"
@implementation Zjson
-(instancetype)initWith:(NSDictionary *)json{
    self.items = json[@"items"] != nil ? (NSArray *)json[@"items"] : [[NSArray alloc]init];
    self.success = json[@"success"] != nil ? (Boolean)json[@"success"] : false;
    self.addon = json[@"addon"] != nil ? (NSDictionary *)json[@"addon"] : [[NSDictionary alloc]init];
    self.detail = json[@"detail"] != nil ? (NSString *)json[@"detail"] : [[NSString alloc]init];
    self.code = json[@"code"] != nil ? (NSInteger)json[@"code"] : 0;
    self.totalCount = json[@"totalCount"] != nil ? (NSInteger)json[@"totalCount"] : 0;
    return self;
}
@end
