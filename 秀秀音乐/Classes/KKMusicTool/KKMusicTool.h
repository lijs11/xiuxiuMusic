//
//  KKMusicTool.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/2.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKSearchResult.h"
@interface KKMusicTool : NSObject


//播放历史
@property (nonatomic,strong,readonly)NSMutableArray *historyResults;
- (void)saveHistoryDeal:(KKSearchResult *)result;
- (void)unsaveHistoryDeal:(KKSearchResult *)result;

//收藏
@property (nonatomic,strong,readonly)NSMutableArray *collectResults;
- (void)saveCollectDeal:(KKSearchResult *)result;
- (void)unsaveCollectDeal:(KKSearchResult *)result;


+ (instancetype)sharedMusicTool;


@end
