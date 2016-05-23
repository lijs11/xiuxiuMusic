//
//  KKHistoryOrCollectViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/12.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKHistoryOrCollectViewController.h"
#import "BottomPlayView.h"
#import "KKMusicTool.h"
#import "KKResultCell.h"
#import "PlayMusicViewController.h"
@interface KKHistoryOrCollectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;


@end

@implementation KKHistoryOrCollectViewController

- (NSMutableArray *)dataSourceArr{
    if (_dataSourceArr == nil) {
        if ([self.from isEqual:@"history1"]) {
//            [self.dataSourceArr removeAllObjects];
            self.dataSourceArr = [KKMusicTool sharedMusicTool].historyResults;
        }else if ([self.from isEqual:@"collect1"]){
//            [self.dataSourceArr removeAllObjects];
            self.dataSourceArr = [KKMusicTool sharedMusicTool].collectResults;
        }
        
    }    
    
    if (_dataSourceArr == nil) {
        self.dataSourceArr = [NSMutableArray array];
    }
    
    
    return _dataSourceArr;
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    BottomPlayView *bottomPV = [BottomPlayView shareBottomPlayView];
    [self.view addSubview:bottomPV.view];
    
#warning 一定要实时更新
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    
    
}




#pragma mark - UITableViewData


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return self.dataSourceArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.创建cell
    static NSString *ID = @"resultcell";
    KKResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KKResultCell" owner:self options:nil] lastObject];
    }
    
    if (self.dataSourceArr.count) {
        KKSearchResult *result = self.dataSourceArr[indexPath.row];
        cell.songname.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row + 1,result.song_name];//为了有序号
        cell.result = result;
        
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1:获取音乐播放器对象
    PlayMusicViewController *playMusicV = [PlayMusicViewController shareWithPlayMusicViewController];
    
    
    //完成界面跳转
    [self.navigationCC pushViewController:playMusicV animated:YES];
    //传递需要播放的数据源和对应的下标
    
    
    if (self.dataSourceArr.count == 0) return;
//       [playMusicV.dataSourceArr removeAllObjects];
        playMusicV.dataSourceArr = self.dataSourceArr;
        playMusicV.index = indexPath.row;
        //开始播放
        [playMusicV playMusic];
    
}




#pragma mark - 删除

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSLogg(@"delete%ld",indexPath.row);
        [UIView animateWithDuration:0.0 animations:^{
            
            
            if ([self.from isEqual:@"history1"]) {
               
                KKSearchResult *result = self.dataSourceArr[indexPath.row];
                [[KKMusicTool sharedMusicTool] unsaveHistoryDeal:result];
                self.dataSourceArr = [KKMusicTool sharedMusicTool].historyResults;
                 NSLogg(@"delete%@---%ld",result,indexPath.row);
            }else if ([self.from isEqual:@"collect1"]){
                //            [self.dataSourceArr removeAllObjects];
                [[KKMusicTool sharedMusicTool] unsaveCollectDeal:self.dataSourceArr[indexPath.row]];
                self.dataSourceArr = [KKMusicTool sharedMusicTool].collectResults;
            }
        } completion:^(BOOL finished) {
            
            
            [self.tableView reloadData];
            
        }];
        
    }
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//    });
    
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return @"移除";
    
    
}








@end
