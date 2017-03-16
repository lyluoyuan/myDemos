//
//  Zjson.h
//  staffOC
//
//  Created by zm004 on 16/7/28.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Zjson : NSObject
@property(nonatomic,strong) NSArray<NSDictionary *>* items;
@property(nonatomic) Boolean success;
@property(nonatomic,strong) NSDictionary* addon;
@property(nonatomic,strong) NSString* detail;
@property(nonatomic) NSInteger code;
@property(nonatomic) NSInteger totalCount;
-(instancetype)initWith:(NSDictionary *)json;
@end
