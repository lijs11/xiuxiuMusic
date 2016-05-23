//
//  KKMusicWeekViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMusicWeekViewController.h"
#import "BottomPlayView.h"
#import "KKMusicWeekCell.h"
#import "KKMusicWeekModel.h"
#import "KKMusicListViewController.h"

@interface KKMusicWeekViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic,strong)BottomPlayView *bottomPlayView;

@property (nonatomic,strong)UIImageView *imageBg;

@end

@implementation KKMusicWeekViewController

#pragma mark - 公共懒加载
- (BottomPlayView *)bottomPlayView{
    
    if (_bottomPlayView == nil) {
        self.bottomPlayView = [BottomPlayView shareBottomPlayView];
    }
    return _bottomPlayView;
}

- (UIImageView *)imageBg{
    
    if (_imageBg == nil) {
        self.imageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"network-disabled"]];
        self.imageBg.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    }
    
    return _imageBg;
}

- (NSMutableArray *)dataSourceArr{
    if (_dataSourceArr == nil) {
        self.dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.view addSubview:self.bottomPlayView.view];
    [self.view bringSubviewToFront:self.bottomPlayView.view];
    self.bottomPlayView.view.frame = CGRectMake(0, self.view.height - self.bottomPlayView.view.height, self.bottomPlayView.view.width, self.bottomPlayView.view.height);
    self.bottomPlayView.navigationVc = self.navigationController;
    
    
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self updataWeekMusicData];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"KKMusicWeekCellID";
    KKMusicWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KKMusicWeekCell" owner:self options:nil] lastObject];
    }
    
    
    if (self.dataSourceArr.count > 0) {
        KKMusicWeekModel *model = self.dataSourceArr[indexPath.row];
        cell.model = model;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    return [tableView cellForRowAtIndexPath:indexPath].height;
    return 110;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KKMusicListViewController *mlVc = [[KKMusicListViewController alloc] init];
    
    KKMusicWeekModel *model = self.dataSourceArr[indexPath.row];
    mlVc.from = @"weekMusic";
    mlVc.navigationCC = self.navigationCC;
    mlVc.NvTitle = model.title;
    mlVc.msg_id = model.ID;
    mlVc.pic_url = model.pic_url;
    [self.navigationCC pushViewController:mlVc animated:YES];
}



#pragma mark -数据类
- (void)updataWeekMusicData {
    [KKNetWorkTool JsonDataWithUrl:kMusicWeekController success:^(id data) {
        for (NSDictionary *dict in data[@"data"]) {
//            NSLog(@"%@",dict);
            KKMusicWeekModel *model = [[KKMusicWeekModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            NSLogg(@"model--%@",model.title);
            [self.dataSourceArr addObject:model];
            
        }
        
        if ([self.view.subviews containsObject:self.imageBg]) {
            [self.imageBg removeFromSuperview];
        }
        [self.tableView reloadData];
        
    } fail:^{
        
        if ([self.view.subviews containsObject:self.imageBg]) return;
        [self.tableView addSubview:self.imageBg];
        
    } view:self.view parameters:nil];
}


@end
