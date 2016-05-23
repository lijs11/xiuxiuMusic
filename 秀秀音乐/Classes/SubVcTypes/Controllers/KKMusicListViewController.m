//
//  KKMusicListViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMusicListViewController.h"
#import "BottomPlayView.h"
#import "PlayMusicViewController.h"
#import "KKResultCell.h"
#import "KKMusicListSongModel.h"
#import "UIImageView+WebCache.h"

@interface KKMusicListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *head;
@property (weak, nonatomic) IBOutlet UIImageView *hearImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalSongsLabel;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@property (nonatomic, strong) NSMutableDictionary *userDict;

@end

@implementation KKMusicListViewController

- (NSMutableArray *)dataSourceArr{
    if (_dataSourceArr == nil) {
        self.dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}




-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    BottomPlayView *bottomPV = [BottomPlayView shareBottomPlayView];
    [self.view addSubview:bottomPV.view];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.tableHeaderView = self.head;
    
    self.smallImageView.layer.masksToBounds = YES;
    self.smallImageView.layer.cornerRadius=50; //设置为图片宽度的一半出来为圆形
    self.smallImageView.layer.borderWidth=3.0f; //边框宽度
    self.smallImageView.layer.borderColor=[[UIColor whiteColor] CGColor];//边框颜色
    
    
    
    
    [self readMusicListData];
    
}


- (void)setPic_url:(NSString *)pic_url{
    _pic_url = pic_url;
    [[SDImageCache sharedImageCache] cleanDisk];
    [self.hearImageView sd_setImageWithURL:[NSURL URLWithString:pic_url] placeholderImage:nil];
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:pic_url] placeholderImage:nil];
}



#pragma mark - 数据处理
- (void)readMusicListData{
    
    //来自排行
    if ([self.from isEqualToString:@"weekMusic"]) {
        [self readDataByFrom:[NSString stringWithFormat:kMusicListControllerWeekMusic, self.msg_id]];
    } else if ([self.from isEqualToString:@"singerMusic"]) {
        [self readDataByFrom:[NSString stringWithFormat:kMusicListControllerSingerMusic,self.msg_id]];
    } else if ([self.from isEqualToString:@"songType"]) {
        [self readDataByFrom:[NSString stringWithFormat:kMusicListControllerSongType, self.msg_id]];
    } else {
        [KKNetWorkTool JsonDataWithUrl:[NSString stringWithFormat:kMusicListControllerOther, self.msg_id]success:^(id data) {
            NSMutableArray *tempArr = [NSMutableArray array];
            [self.dataSourceArr removeAllObjects];
            
            for (NSDictionary *dict in data[@"songs"]) {
                NSLogg(@"dict%@",data[@"songs"]);
                //存放用户信息
//                self.userDict = [NSMutableDictionary dictionaryWithDictionary:dict[@"user"]];
//                [_userDict setValue:dict[@"pics"] forKey:@"pics"];
//                for (NSDictionary *dict1 in dict[@"songlist"]) {
//                    [tempArr addObject:dict1[@"_id"]];
//                }
                
                
                KKSearchResult *model = [[KKSearchResult alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataSourceArr addObject:model];
            }
            [self.tableView reloadData];
            
            
        } fail:^{
            
        } view:self.view parameters:nil];
    }
}


- (void)readDataByFrom:(NSString *)fromUrl {
    
    [KKNetWorkTool JsonDataWithUrl:fromUrl success:^(id data) {
        for (NSDictionary *dict in data[@"data"]) {
            KKSearchResult *model = [KKSearchResult new];
            [model setValuesForKeysWithDictionary:dict];
            [_dataSourceArr addObject:model];
        }
//        self.userDict = [NSMutableDictionary dictionaryWithObjects:@[@[self.pic_url], self.NvTitle, [NSString stringWithFormat:@"共%ld首歌", (unsigned long)_dataSourceArr.count]] forKeys:@[@"pics", @"nick_name", @"label"]];
//        
        [self.tableView reloadData];
    } fail:^{
        
    } view:self.view parameters:nil];
    
}



#pragma mark - UITableViewData


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    self.totalSongsLabel.text = [NSString stringWithFormat:@"共%ld首歌",self.dataSourceArr.count];
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


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//  
//    return 0;
//    
//    
//}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 70;
    }else{
        
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1:获取音乐播放器对象
    PlayMusicViewController *playMusicV = [PlayMusicViewController shareWithPlayMusicViewController];
  
    
    //完成界面跳转
    [self.navigationCC pushViewController:playMusicV animated:YES];
    //传递需要播放的数据源和对应的下标
    
    
    if (self.dataSourceArr.count > 0) {
        playMusicV.dataSourceArr = self.dataSourceArr;
        playMusicV.index = indexPath.row;
        //开始播放
        [playMusicV playMusic];
    }
    
  
    
}








@end
