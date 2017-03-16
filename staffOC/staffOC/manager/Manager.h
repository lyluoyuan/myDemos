//
//  Manager.h
//  staffOC
//
//  Created by zm004 on 16/8/18.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject
+(NSMutableURLRequest *)setRequestWithLink:(NSString *)link;
+(void)todoWithRequest:(NSMutableURLRequest *)quest;
@end
