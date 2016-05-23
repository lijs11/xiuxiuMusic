//
//  KKMusicHotModel.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMusicHotModel.h"

@implementation KKMusicHotModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"picUrl"]) {
        self.pic_url = value;
    }
    
    if ([key isEqualToString:@"listenCount"]) {
        self.listen_count = value;
    }
}


@end
