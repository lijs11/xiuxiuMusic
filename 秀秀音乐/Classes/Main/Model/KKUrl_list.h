//
//  KKUrl_list.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKUrl_list : NSObject

@property (nonatomic,strong)NSNumber *bitRate;
@property (nonatomic,copy) NSString *duration;
@property (nonatomic,copy) NSString *size;
@property (nonatomic,copy)NSString *suffix;
@property (nonatomic,strong)NSNumber *type;
@property (nonatomic,copy) NSString *typeDescription;
@property (nonatomic,copy) NSString *url;
@end


/**
 
 bitRate = 128;
 duration = 267000;
 size = 4274833;
 suffix = mp3;
 typeDescription = "\U6807\U51c6\U54c1\U8d28";
 url = "http://m5.file.xiami.com/29/61029/2100172990/1774551197_16955653_l.mp3?auth_key=ef8abada9a16eac2cdd338c247c94ab5-1462752000-0-null";
 },

 
 */