//
//  KKSingerViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKSingerViewController.h"
#import "BottomPlayView.h"
#import "PlayMusicViewController.h"
#import "KKSingerModel.h"
#import "UIImageView+WebCache.h"
#import "KKMusicListViewController.h"
#import "KKSingerCell.h"

@interface KKSingerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;



@end

@implementation KKSingerViewController

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
    
    //    self.tableView.tableHeaderView = self.head;
    
    
    [self readMusicListData];
    
}

- (void)readMusicListData{
    
    
    [KKNetWorkTool JsonDataWithUrl:  [NSString stringWithFormat:kSingerController, self.singerTypeID] success:^(id data) {
        for (NSDictionary *dict in data[@"data"]) {
            KKSingerModel *model = [[KKSingerModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [_dataSourceArr addObject:model];
        }
        [self.tableView reloadData];
    } fail:^{
        
    } view:self.view parameters:nil];
    
    
    
    
    
}





#pragma mark - UITableViewData


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSourceArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.创建cell
    static NSString *ID = @"KKSingerCellID";
    KKSingerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KKSingerCell" owner:self options:nil] lastObject];
    }
    
    if (self.dataSourceArr.count) {
        KKSingerModel *model = self.dataSourceArr[indexPath.row];
        cell.model = model;       
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 70;
        
    }else{
        
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1:获取音乐播放器对象
    KKMusicListViewController *listVc = [[KKMusicListViewController alloc] init];
    
    //完成界面跳转
    [self.navigationCC pushViewController:listVc animated:YES];

    
    if (self.dataSourceArr.count > 0) {
        KKSingerModel *model = self.dataSourceArr[indexPath.row];
        listVc.from = @"singerMusic";
        listVc.navigationCC = self.navigationCC;
        listVc.NvTitle = model.singer_name;
        listVc.pic_url = model.pic_url;
        listVc.msg_id = [NSString stringWithFormat:@"%@", model.singer_id];
        
    }
    
    
    
}




@end
