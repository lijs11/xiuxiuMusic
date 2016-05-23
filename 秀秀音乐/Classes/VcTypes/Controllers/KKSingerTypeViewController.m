//
//  KKSingerTypeViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKSingerTypeViewController.h"
#import "BottomPlayView.h"
#import "KKSingerTypeCell.h"
#import "KKSingerTypeModel.h"
#import "KKNetWorkTool.h"
#import "KKMusicListViewController.h"

#import "KKSingerViewController.h"

@interface KKSingerTypeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@property (nonatomic,strong)UIImageView *imageBg;

@end

@implementation KKSingerTypeViewController


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
    self.layout.itemSize = CGSizeMake((HMScreenW - 45 ) /3, (HMScreenW - 45 ) /3 + 30 );
    self.layout.sectionInset = UIEdgeInsetsMake(5, 8, 75, 8);
    self.layout.minimumInteritemSpacing = 8;
    self.layout.minimumLineSpacing = 5;
    //注册，必须
    [self.collectionView registerNib:[UINib nibWithNibName:@"KKSingerTypeCell" bundle:nil] forCellWithReuseIdentifier:@"KKSingerTypeCellID"];
    
    //网络
    [self updateSource];
    
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSourceArr.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKSingerTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKSingerTypeCellID" forIndexPath:indexPath];
    
    
    if (self.dataSourceArr.count > 0) {
        KKSingerTypeModel *model = self.dataSourceArr[indexPath.row];
        cell.model = model;
        
    }
    
    return cell;
}

#pragma mark - item选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKSingerViewController *singerVc = [[KKSingerViewController alloc] init];
    singerVc.navigationCC = self.navigationCC;
    
    KKSingerTypeModel *model = self.dataSourceArr[indexPath.row];
    singerVc.navigationCC = self.navigationCC;
    singerVc.NvTitle = model.title;
    singerVc.singerTypeID = model.ID;
    [self.navigationCC pushViewController:singerVc animated:YES];
    
}

#pragma mark - 更新数据库

- (void)updateSource{
    
    
    [KKNetWorkTool JsonDataWithUrl:kSingerTypeController success:^(id data) {
        for (NSDictionary *dict in data[@"data"]) {
            KKSingerTypeModel *model = [KKSingerTypeModel new];
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
