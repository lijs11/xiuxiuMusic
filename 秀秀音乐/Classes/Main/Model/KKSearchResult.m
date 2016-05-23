//
//  KKSearchResult.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/3.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKSearchResult.h"
#import "KKAudition_list.h"
#import "KKUrl_list.h"
@implementation KKSearchResult

+ (NSDictionary *)mj_objectClassInArray{
    
    
    return  @{@"audition_list" : [KKAudition_list class],@"url_list" : [KKUrl_list class]};
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"songId"]) {
        self.song_id = value;
    }
    if ([key isEqualToString:@"singerName"]) {
        self.singer_name = value;
    }
    if ([key isEqualToString:@"name"]) {
        self.song_name = value;
    }
    
    if ([key isEqualToString:@"albumName"]) {
        self.album_name = value;
    }
    if ([key isEqualToString:@"urlList"]) {
        self.url_list = value;
    }
    
    if ([key isEqualToString:@"favorites"]) {
         self.pick_count = [value integerValue];
    }
}


MJCodingImplementation

@end
