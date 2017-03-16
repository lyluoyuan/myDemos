//
//  ProjectModel.m
//  staffOC
//
//  Created by zm004 on 16/7/28.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import "ProjectModel.h"

@implementation ProjectModel
-(instancetype)initWith:(NSDictionary *)json{
    self.articleId = json[@"article_id"] != nil ? (NSString *)json[@"article_id"] : @"";
    self.articleTitle = json[@"article_title"] != nil ? (NSString *)json[@"article_title"] : @"";
    self.articleSort = json[@"article_sort"] != nil ? (NSString *)json[@"article_sort"] : @"";
    self.articleDesc = json[@"article_desc"] != nil ? (NSString *)json[@"article_desc"] : @"";
    self.articleImage = json[@"article_image"] != nil ? (NSString *)json[@"article_image"] : @"";
    self.articleTimePublic = json[@"article_time_public"] != nil ? (NSString *)json[@"article_time_public"] : @"";
    self.url = json[@"url"] != nil ? (NSString *)json[@"url"] : @"";
    self.flgTop = json[@"flg_top"] != nil ? (NSInteger)json[@"flg_top"] : 0;
    return self;
}
@end
