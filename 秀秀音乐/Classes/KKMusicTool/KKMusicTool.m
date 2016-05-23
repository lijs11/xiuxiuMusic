//
//  KKMusicTool.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/2.
//  Copyright (c) 2016年 KK. All rights reserved.
//

//自定义路径 用户浏览历史
#define HMHistoryDealsFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"historyDeals.plist"]
//自定义路径 用户收藏
#define HMCollectDealsFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collectDeals.plist"]



#import "KKMusicTool.h"


@interface KKMusicTool()
//播放历史
@property (nonatomic,strong)NSMutableArray *historyResults;

//收藏
@property (nonatomic,strong)NSMutableArray *collectResults;

@end


@implementation KKMusicTool
#pragma mark - 播放历史
- (NSMutableArray *)historyResults{
    
    if (_historyResults == nil) {
        _historyResults = [NSKeyedUnarchiver unarchiveObjectWithFile:HMHistoryDealsFilePath];
        if (_historyResults == nil) {
            _historyResults = [NSMutableArray array];
        }
    }
    
    return _historyResults;
}


- (NSMutableArray *)collectResults{
    
    if (_collectResults == nil) {
        _collectResults = [NSKeyedUnarchiver unarchiveObjectWithFile:HMCollectDealsFilePath];
        if (_collectResults == nil) {
            _collectResults = [NSMutableArray array];
        }
    }
    
    return _collectResults;
}



- (void)saveHistoryDeal:(KKSearchResult *)result{
    [self.historyResults removeObject:result];
    
    if (self.historyResults.count > 20) {//保证里面只有20个。、数字可以改
        NSRange range = NSMakeRange(20, self.historyResults.count - 20);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.historyResults removeObjectsAtIndexes:indexSet];
    }
    
    [self.historyResults insertObject:result atIndex:0];
    [NSKeyedArchiver archiveRootObject:self.historyResults toFile:HMHistoryDealsFilePath];
}



- (void)saveCollectDeal:(KKSearchResult *)result{
    [self.collectResults removeObject:result];
    
    //    if (self.collectDeals.count > 10) {//保证里面只有11个。、数字可以改
    //        NSRange range = NSMakeRange(10, self.collectDeals.count - 10);
    //        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    //        [self.collectDeals removeObjectsAtIndexes:indexSet];
    //    }
    
    
    [self.collectResults insertObject:result atIndex:0];
    [NSKeyedArchiver archiveRootObject:self.collectResults toFile:HMCollectDealsFilePath];
}

- (void)unsaveCollectDeal:(KKSearchResult *)result{
    
    [self.collectResults removeObject:result];
   
    
    [NSKeyedArchiver archiveRootObject:self.collectResults toFile:HMCollectDealsFilePath];
}

- (void)unsaveHistoryDeal:(KKSearchResult *)result{
    
    [self.historyResults removeObject:result];
    [NSKeyedArchiver archiveRootObject:self.historyResults toFile:HMHistoryDealsFilePath];
    
}




#pragma mark - 唯一性 --- 单例
static id _instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedMusicTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
    
}

//拷贝默认只返回一个。Zone是内存空间
- (id)copyWithZone:(NSZone *)zone{
    
    return _instance;//instance之前肯定创建好的，有对象才能拷贝，所以返回单例。要准守NSCopying
}






@end
