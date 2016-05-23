//
//  KKMusicListSongModel.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMusicListSongModel.h"
#import "KKAudition_list.h"
@implementation KKMusicListSongModel

+ (NSDictionary *)mj_objectClassInArray{
    
    
    return  @{@"auditionList" : [KKAudition_list class]};
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
