//
//  KKNewCDViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKNewCDViewController.h"
#import "BottomPlayView.h"
#import "KKNewCDViewCell.h"
#import "KKNewCDModel.h"
#import "KKNetWorkTool.h"
#import "KKMusicListViewController.h"

@interface KKNewCDViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@property (nonatomic,strong)UIImageView *imageBg;

@end



@implementation KKNewCDViewController

#pragma mark - 懒加载

- (NSMutableArray *)dataSourceArr{
    if (_dataSourceArr == nil) {
        self.dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

- (UIImageView *)imageBg{
    
    if (_imageBg == nil) {
        self.imageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"network-disabled"]];
        self.imageBg.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    }
   
    return _imageBg;
}





-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    BottomPlayView *bottomPV = [BottomPlayView shareBottomPlayView];
    [self.view addSubview:bottomPV.view];
    
}



#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //布局
    self.layout.itemSize = CGSizeMake((HMScreenW - 24 ) /2, (HMScreenW - 24 ) /2 + 45 );
    self.layout.sectionInset = UIEdgeInsetsMake(5, 8, 75, 8);
    self.layout.minimumInteritemSpacing = 8;
    self.layout.minimumLineSpacing = 3;
    //注册，必须
    [self.collectionView registerNib:[UINib nibWithNibName:@"KKNewCDViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKNewCDCellID"];
    
    //网络  
    [self updateSource];
    
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSourceArr.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKNewCDViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKNewCDCellID" forIndexPath:indexPath];
    
    
    
    if (self.dataSourceArr.count > 0) {
        KKNewCDModel *model = self.dataSourceArr[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

#pragma mark - item选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKMusicListViewController *mlVc = [[KKMusicListViewController alloc] init];
    mlVc.navigationCC = self.navigationCC;
    
    KKNewCDModel *model = self.dataSourceArr[indexPath.row];
    mlVc.NvTitle = model.desc;
    mlVc.msg_id = model.msg_id;
    [self.navigationCC pushViewController:mlVc animated:YES];
    
}

#pragma mark - 更新数据库

- (void)updateSource{
    

[KKNetWorkTool JsonDataWithUrl:kNewCDController success:^(id data) {
    for (NSDictionary *dict in  data[@"data"]) {
        KKNewCDModel *model = [[KKNewCDModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dict];
        
        [self.dataSourceArr addObject:model];
    }
    
    [self.collectionView reloadData];
    
    if ([self.view.subviews containsObject:self.imageBg]) {
        [self.imageBg removeFromSuperview];
    }
  
    
} fail:^{
    
    if ([self.view.subviews containsObject:self.imageBg]) return;
    [self.collectionView addSubview:self.imageBg];
    
    
} view:self.view parameters:nil];


    
}


@end
