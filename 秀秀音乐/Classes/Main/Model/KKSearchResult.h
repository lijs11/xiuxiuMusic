//
//  KKSearchResult.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/3.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKSearchResult : NSObject

@property (nonatomic, strong) NSNumber *singer_id, *song_id;
@property (nonatomic, copy) NSString *singer_name, *song_name;
@property (nonatomic, copy) NSString *album_name;//专辑名字
@property (nonatomic, strong) NSNumber *album_id;//专辑id
@property (nonatomic, assign) NSInteger pick_count;

@property (nonatomic, copy) NSString *pic_url;  //存储歌曲图片

@property (nonatomic, strong) NSMutableArray *audition_list;


//排行数据中得简介
@property (nonatomic, copy) NSString *alias;

@property (nonatomic,strong) NSNumber *vip;
@property (nonatomic,strong) NSNumber *artist_flag;

@property (nonatomic, strong) NSMutableArray *url_list;

@end

//搜索的歌曲信息
/*   
 { "album_id" = 2012920;
"album_name" = "\U6211\U7684\U5c11\U5973\U65f6\U4ee3 \U7535\U5f71\U539f\U58f0\U5e26";
"artist_flag" = 1;
"audition_list" =     (
                       {
                           bitRate = 32;
                           duration = "04:25";
                           size = "1.05 MB";
                           suffix = m4a;
                           type = 0;
                           typeDescription = "\U6d41\U7545\U54c1\U8d28";
                           url = "http://om32.alicdn.com/523/78523/1136455538/1774490672_16884267_l.m4a?auth_key=cfcbaa8170dd1d5486b5ce529a00e2e7-1462320000-0-null";
                       },
                       {
                           bitRate = 128;
                           duration = "04:25";
                           size = "4.05 MB";
                           suffix = mp3;
                           type = 0;
                           typeDescription = "\U6807\U51c6\U54c1\U8d28";
                           url = "http://m5.file.xiami.com/523/78523/1136455538/1774490672_16884267_l.mp3?auth_key=56dd82733642c3bba75b0c8b37a43880-1462320000-0-null";
                       },
                       {
                           bitRate = 320;
                           duration = "04:25";
                           size = "10.13 MB";
                           suffix = mp3;
                           type = 0;
                           typeDescription = "\U8d85\U9ad8\U54c1\U8d28";
                           url = "http://m6.file.xiami.com/523/78523/1136455538/1774490672_16884267_h.mp3?auth_key=f7d375f80ea9b1958994289a034d52ad-1462320000-0-null";
                       }
                       );
"mv_list" =     (
                 {
                     bitrate = 1001;
                     duration = "04:48";
                     durationMilliSecond = 288660;
                     id = 0;
                     lsize = 40451113;
                     picUrl = "http://3p.pic.ttdtweb.com/3p.ttpod.com/video/mv_pic/mv_pic_20/160_90/7845/285806/2000648.jpg";
                     "pic_url" = "http://3p.pic.ttdtweb.com/3p.ttpod.com/video/mv_pic/mv_pic_20/160_90/7845/285806/2000648.jpg";
                     size = "38.58 MB";
                     suffix = mp4;
                     type = 2;
                     typeDescription = 1080P;
                     "type_description" = 1080P;
                     url = "http://otmv.alicdn.com/new/mv_2_20/9e/9e/9e6cd22fb6a9e3718b2d9353a0e9d49e.mp4?k=b413d2276e83c93c&t=1462639855";
                     videoId = 2000648;
                 },
                 {
                     bitrate = 500;
                     duration = "04:48";
                     durationMilliSecond = 288600;
                     id = 0;
                     lsize = 25123975;
                     picUrl = "http://3p.pic.ttdtweb.com/3p.ttpod.com/video/mv_pic/mv_pic_20/160_90/7845/285806/2000648.jpg";
                     "pic_url" = "http://3p.pic.ttdtweb.com/3p.ttpod.com/video/mv_pic/mv_pic_20/160_90/7845/285806/2000648.jpg";
                     size = "23.96 MB";
                     suffix = mp4;
                     type = 0;
                     typeDescription = "\U6807\U6e05";
                     "type_description" = "\U6807\U6e05";
                     url = "http://otmv.alicdn.com/new/mv_1_20/2b/87/2b71b51fc70854caf3de8b260a995187.mp4?k=3c29f183f5d2eb37&t=1462639855";
                     videoId = 2000648;
                 },
                 {
                     bitrate = 1544;
                     duration = "04:48";
                     durationMilliSecond = 288480;
                     id = 0;
                     lsize = 60310938;
                     picUrl = "http://3p.pic.ttdtweb.com/3p.ttpod.com/video/mv_pic/mv_pic_20/160_90/7845/285806/2000648.jpg";
                     "pic_url" = "http://3p.pic.ttdtweb.com/3p.ttpod.com/video/mv_pic/mv_pic_20/160_90/7845/285806/2000648.jpg";
                     size = "57.52 MB";
                     suffix = mp4;
                     type = 2;
                     typeDescription = 1080P;
                     "type_description" = 1080P;
                     url = "http://otmv.alicdn.com/new/mv_3_20/3c/20/3cbad41f6f82519bde95f3567a67d020.mp4?k=cf5ba07fea51c9c7&t=1462639855";
                     videoId = 2000648;
                 },
                 {
                     bitrate = 1882;
                     duration = "04:48";
                     durationMilliSecond = 288600;
                     id = 0;
                     lsize = 74940652;
                     picUrl = "http://3p.pic.ttdtweb.com/3p.ttpod.com/video/mv_pic/mv_pic_20/160_90/7845/285806/2000648.jpg";
                     "pic_url" = "http://3p.pic.ttdtweb.com/3p.ttpod.com/video/mv_pic/mv_pic_20/160_90/7845/285806/2000648.jpg";
                     size = "71.47 MB";
                     suffix = mp4;
                     type = 2;
                     typeDescription = 1080P;
                     "type_description" = 1080P;
                     url = "http://otmv.alicdn.com/new/mv_3_20/6d/72/6d8f1c5971258dfb2593630447b5de72.mp4?k=fce68a696c5fedb6&t=1462639855";
                     videoId = 2000648;
                 }
                 );
"pick_count" = 260896;
"singer_id" = 1000882;
"singer_name" = "\U7530\U99a5\U7504";
"song_id" = 35129899;
"song_name" = "\U5c0f\U5e78\U8fd0";
"url_list" =     (
                  {
                      bitRate = 32;
                      duration = "04:25";
                      size = "1.05 MB";
                      suffix = m4a;
                      type = 0;
                      typeDescription = "\U6d41\U7545\U54c1\U8d28";
                      url = "http://om32.alicdn.com/523/78523/1136455538/1774490672_16884267_l.m4a?auth_key=cfcbaa8170dd1d5486b5ce529a00e2e7-1462320000-0-null";
                  },
                  {
                      bitRate = 128;
                      duration = "04:25";
                      size = "4.05 MB";
                      suffix = mp3;
                      type = 0;
                      typeDescription = "\U6807\U51c6\U54c1\U8d28";
                      url = "http://m5.file.xiami.com/523/78523/1136455538/1774490672_16884267_l.mp3?auth_key=56dd82733642c3bba75b0c8b37a43880-1462320000-0-null";
                  },
                  {
                      bitRate = 320;
                      duration = "04:25";
                      size = "10.13 MB";
                      suffix = mp3;
                      type = 0;
                      typeDescription = "\U8d85\U9ad8\U54c1\U8d28";
                      url = "http://m6.file.xiami.com/523/78523/1136455538/1774490672_16884267_h.mp3?auth_key=f7d375f80ea9b1958994289a034d52ad-1462320000-0-null";
                  }
                  );
vip = 0;
}*/