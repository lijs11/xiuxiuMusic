//
//  KKSearchViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/3.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKSearchViewController.h"
#import "KKNetWorkTool.h"
#import "KKSearchParam.h"
#import "KKSearchResult.h"
#import "KKAudition_list.h"
#import <AVFoundation/AVFoundation.h>

#import "KKSearchResultViewController.h"


@interface KKSearchViewController ()<UISearchBarDelegate>

//@property (weak, nonatomic) IBOutlet UIButton *playOrPausr;
//@property (nonatomic,strong)NSMutableArray *resultArray;
//@property (nonatomic,strong)AVPlayer *player;
//@property (nonatomic,assign) BOOL isPlaying;
//- (IBAction)play;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

- (IBAction)SearchBarTopBtn:(UIButton *)sender;

- (IBAction)titleLabel:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *titleLable1;
@property (weak, nonatomic) IBOutlet UIButton *titleLable2;
@property (weak, nonatomic) IBOutlet UIButton *titleLable3;
@property (weak, nonatomic) IBOutlet UIButton *titleLable4;
@property (weak, nonatomic) IBOutlet UIButton *titleLable5;
@property (weak, nonatomic) IBOutlet UIButton *titleLable6;


@end

@implementation KKSearchViewController

- (NSMutableArray *)dataSourceArr{
    if (_dataSourceArr == nil) {
        self.dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    if (self.dataSourceArr.count > 0) {
        return;
    }
    
    [self updateSearchData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.searchBar.delegate = self;
//    [self readSearchData:@"小幸运"];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLogg(@"searchBarSearchButtonClicked");
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return NO;
}



- (IBAction)SearchBarTopBtn:(UIButton *)sender {
    
    KKSearchResultViewController *kksr = [[KKSearchResultViewController alloc] init];
    kksr.navigationVc = self.navigationVc;
    [self.navigationVc pushViewController:kksr animated:YES];
    
}

- (IBAction)titleLabel:(UIButton *)sender {
    
    KKSearchResultViewController *kksr = [[KKSearchResultViewController alloc] init];
    kksr.navigationVc = self.navigationVc;
    kksr.searchText = sender.currentTitle;
    [self.navigationVc pushViewController:kksr animated:YES];
    
    
}

- (void)updateSearchData{
    
    [KKNetWorkTool JsonDataWithUrl:kOpenSearchController success:^(id data) {
        for (NSDictionary *dict in data[@"data"]) {
            [_dataSourceArr addObject:dict[@"val"]];
        }
        [self.titleLable1 setTitle:_dataSourceArr[0] forState:UIControlStateNormal];
        [self.titleLable2 setTitle:_dataSourceArr[1] forState:UIControlStateNormal];
        [self.titleLable3 setTitle:_dataSourceArr[2] forState:UIControlStateNormal];
        [self.titleLable4 setTitle:_dataSourceArr[3] forState:UIControlStateNormal];
        [self.titleLable5 setTitle:_dataSourceArr[4] forState:UIControlStateNormal];
        [self.titleLable6 setTitle:_dataSourceArr[5] forState:UIControlStateNormal];
        NSLogg(@"titleLable1--%@",_dataSourceArr);
        
    } fail:^{
        
    } view:self.view parameters:nil];
    
    
    
}






//- (NSMutableArray *)resultArray{
//    if (_resultArray == nil) {
//        self.resultArray = [NSMutableArray array];
//    }
//    return _resultArray;
//}
//
//- (AVPlayer *)player{
//
//    if (_player == nil) {
//        self.player = [[AVPlayer alloc] initWithPlayerItem:nil];
//    }
//    return _player;
//}



//- (IBAction)play {
//    
//    if (self.isPlaying) {
//        [self.player pause];
//        self.isPlaying = NO;
//        [self.resultArray removeAllObjects];
//        [self readSearchData:@"将军"];//测试，此步会延迟 需要判断
//        
//    }
//    
//    
//    if (self.resultArray.count == 0) return;
//    
//    
//    //播放器
//    NSString *playing;
//    KKSearchResult *result = [self.resultArray lastObject];
//    if (result.audition_list.count > 0) {
//        KKAudition_list *list = [result.audition_list firstObject];
//        playing = list.url;
//    }
//    if (!playing) return;
//    
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:playing]];
//    //url = "http://om32.alicdn.com/523/78523/1136455538/1774490672_16884267_l.m4a?auth_key=cfcbaa8170dd1d5486b5ce529a00e2e7-1462320000-0-null"
//    
//    [self.player replaceCurrentItemWithPlayerItem:playerItem];
//    [self.player play];
//    self.isPlaying = YES;
//}
//
//
//
//- (void)readSearchData:(NSString *)keyWord {
//    //    NSDictionary *parameDict = [NSDictionary dictionaryWithObjects:@[keyWord, @"1", @"50"] forKeys:@[@"q", @"page", @"size"]];
//    KKSearchParam *param = [[KKSearchParam alloc] init];
//    param.q = keyWord;
//    param.page = @1;
//    param.size = @10;
//    
//    [KKNetWorkTool JsonDataWithUrl:kSearchController success:^(id data) {
//        
//        for (NSDictionary *dict in data[@"data"]) {
//            KKSearchResult *result = [[KKSearchResult alloc] init];
//            [result mj_setKeyValues:dict];
//            [self.resultArray addObject:result];
//            NSLog(@"---result--%@,album_name--%@",result,dict);
//        }
//        
//    } fail:^{
//        
//        
//        
//    } view:self.view parameters:param.mj_keyValues];
//}






@end
