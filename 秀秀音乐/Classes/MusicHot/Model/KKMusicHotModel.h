//
//  KKMusicHotModel.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKMusicHotModel : NSObject

@property (nonatomic, copy) NSString *name, *desc;//分区名字
@property (nonatomic, strong) NSNumber *style; //暂时不知
@property (nonatomic, strong) NSNumber *_id, *order; //id和数量
@property (nonatomic, strong) NSMutableArray *data;

//data中
//_id, desc, name, order, pic_url, tag, action:{type, value:"http://.php"}
//在热门歌单中 data中
//listen_count, author, id

@property (nonatomic, strong) NSDictionary *action;
@property (nonatomic, strong) NSString *pic_url, *listen_count, *author, *ID;

@end


/**
 
 {
 action =                     {
 type = 5;
 value = 308916866;
 };
 author = "\U963f\U91cc\U97f3\U4e50";
 comments = 0;
 desc = "\U963f\U91cc\U97f3\U4e50";
 id = 3339;
 listenCount = 1625;
 name = "\U8fd9\U662f\U4e00\U4efd\U5b64\U5355\U6307\U6570\U7206\U8868\U7684\U6b4c\U5355";
 picUrl = "http://pic.xiami.net/images/trade/ams_homepage/0/573058b83858f_0_1462786232.jpg";
 },

 
 
 */