//
//  KKMusicListSongModel.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKMusicListSongModel : NSObject
@property (nonatomic, strong) NSNumber *singerId, *songId;
@property (nonatomic, copy) NSString *singerName, *name;
@property (nonatomic, copy) NSString *albumName;//专辑名字
@property (nonatomic, strong) NSNumber *albumId;//专辑id
//@property (nonatomic, assign) NSInteger pick_count;

@property (nonatomic, copy) NSString *picUrl;  //存储歌曲图片

@property (nonatomic, strong) NSMutableArray *auditionList;

//排行数据中得简介
@property (nonatomic, copy) NSString *alias;

//@property (nonatomic,strong) NSNumber *vip;
//@property (nonatomic,strong) NSNumber *artist_flag;

@end
