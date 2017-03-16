//
//  ProjectModel.h
//  staffOC
//
//  Created by zm004 on 16/7/28.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject
@property(nonatomic,strong) NSString *articleId;
@property(nonatomic,strong) NSString *articleTitle;
@property(nonatomic,strong) NSString *articleSort;
@property(nonatomic,strong) NSString *articleDesc;
@property(nonatomic,strong) NSString *articleImage;
@property(nonatomic,strong) NSString *articleTimePublic;
@property(nonatomic,strong) NSString *url;
@property(nonatomic) NSInteger flgTop;
-(instancetype)initWith:(NSDictionary *)json;
@end
