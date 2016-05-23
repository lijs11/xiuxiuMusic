//
//  KKMusicWeekModel.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKMusicWeekModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title,*details, *pic_url;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSMutableArray *songlist;

@end
//  songlist    KKMusicWeekSongListModel
//{
//    "singerName": "筷子兄弟",
//    "songName": "小苹果"
//},

/**
 "big_pic_url" = "http://3p.pic.ttdtweb.com/online.dongting.com/channel/68/ab041eee/1432716082025.jpg?v=1432716082025";
 count = 0;
 details = "\U300a\U6700\U7f8e\U548c\U58f0\U300b\U8bb2\U8ff0\U771f\U5b9e\U5b58\U5728\U7684\U8d85\U7ea7\U660e\U661f\U4e0e\U6709\U7740\U97f3\U4e50\U5927\U7406\U60f3\U7684\U8ffd\U68a6\U8005\U4e4b\U95f4\U7684\U6545\U4e8b\Uff0c\U201c\U6211\U548c\U4f60\U5531\U201d\U5171\U540c\U8ffd\U5bfb\U97f3\U4e50\U7684\U7406\U60f3\U3002\U534e\U4e3d\U7684\U821e\U53f0\U3001\U7eda\U70c2\U7684\U9c9c\U82b1\U3001\U70ed\U70c8\U7684\U638c\U58f0\U3001\U8df3\U52a8\U7684\U97f3\U7b26\Uff0c\U8c01\U4f1a\U662f\U4e0d\U53ef\U9690\U85cf\U7684\U660e\U661f\Uff1f\U8c01\U5c06\U662f\U8fd9\U4e2a\U821e\U53f0\U4e0a\U7684\U7ec8\U6781\U83b7\U80dc\U8005\Uff1f\U90fd\U5c06\U901a\U8fc7\U300a\U6700\U7f8e\U548c\U58f0\U300b\U6765\U5168\U65b0\U6f14\U7ece\Uff01";
 id = 2406;
 "pic_url" = "http://3p.pic.ttdtweb.com/online.dongting.com/channel/34/d11cc76c/1432716077123.jpg?v=1432716077123";
 songlist =     (
 {
 singerName = "\U5434\U6c76\U82b3 & \U5f20\U6770";
 songName = "\U6211\U4eec\U90fd\U4e00\U6837 (Live)";
 },
 {
 singerName = "\U5f20\U6770 & \U8d75\U4fca";
 songName = "\U60c5\U975e\U5f97\U5df2 (Live)";
 },
 {
 singerName = "\U5f20\U6770 & \U6768\U5764 & \U8427\U656c\U817e & \U8c2d\U7ef4\U7ef4";
 songName = "\U8ddf\U7740\U611f\U89c9\U8d70(Live)";
 },
 {
 singerName = "\U5f20\U6770 & \U911e\U96c5\U5982";
 songName = "\U53ef\U60dc\U4e0d\U662f\U4f60(Live)";
 }
 );
 style = 2;
 time = "2015-05-27";
 title = "\U6700\U7f8e\U548c\U58f0\U70ed\U64ad\U699c";
 type = 0;
 }

 
 
 */