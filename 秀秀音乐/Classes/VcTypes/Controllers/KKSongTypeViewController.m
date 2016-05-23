//
//  KKSongTypeViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKSongTypeViewController.h"
#import "BottomPlayView.h"
#import "KKSingerTypeCell.h"
#import "KKSingerTypeModel.h"
#import "KKNetWorkTool.h"
#import "KKMusicListViewController.h"

#import "KKSingerViewController.h"
#import "KKCollectionHeaderView.h"

@interface KKSongTypeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableArray *dataSection;

@property (nonatomic,strong)UIImageView *imageBg;

@property (nonatomic, strong) NSString *preTypeName; //记录上一条信息的类别

@end

@implementation KKSongTypeViewController


#pragma mark - 懒加载

- (NSMutableArray *)dataSourceArr{
    if (_dataSourceArr == nil) {
        self.dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

- (NSMutableArray *)dataSection{
    if (_dataSection == nil) {
        self.dataSection = [NSMutableArray array];
    }
    return _dataSection;
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
    self.layout.sectionInset = UIEdgeInsetsMake(8, 8, 75, 8);
    self.layout.minimumInteritemSpacing = 8;
    self.layout.minimumLineSpacing = 5;
    //注册，必须
    [self.collectionView registerNib:[UINib nibWithNibName:@"KKSingerTypeCell" bundle:nil] forCellWithReuseIdentifier:@"KKSingerTypeCellID"];
    
    [self.collectionView registerClass:[KKCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    self.preTypeName = @"热门";
    
    //网络
    [self updateSource];
    
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return self.dataSection.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    

    if (self.dataSourceArr.count > 0) {
        
        NSArray *array = self.dataSourceArr[section];
        
        return array.count;
    }else{
        
        return 0;
    }
    
}

//分组标题
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        KKCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.sectionTitle.text = self.dataSection[indexPath.section];
        reusableview = headerView;
    }
    
    return reusableview;
}
//分组标题
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(320, 40);
   
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKSingerTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKSingerTypeCellID" forIndexPath:indexPath];
    
    
    if (self.dataSourceArr.count > 0) {
        KKSongModel *model = self.dataSourceArr[indexPath.section][indexPath.row];
        cell.songModel = model;
    }
    
    return cell;
}




#pragma mark - item选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKMusicListViewController *listVc = [[KKMusicListViewController alloc] init];
    
    KKSongModel *model = self.dataSourceArr[indexPath.section][indexPath.row];
    listVc.navigationCC = self.navigationCC;
    listVc.NvTitle = model.songlist_name;
    listVc.from = @"songType";
    listVc.pic_url = model.pic_url_240_200;
    listVc.msg_id = [NSString stringWithFormat:@"%@", model.songlist_id];
    [self.navigationCC pushViewController:listVc animated:YES];
    
}

#pragma mark - 更新数据库

- (void)updateSource{
    
    [KKNetWorkTool JsonDataWithUrl:kSongTypeController success:^(id data) {
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in data[@"data"]) {
            KKSongModel *model = [[KKSongModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if (![_preTypeName isEqualToString:model.parentname]) {
                [self.dataSection addObject:model.parentname];
                [self.dataSourceArr addObject:tempArr];
                tempArr = [NSMutableArray array];
            }
            [tempArr addObject:model];
            _preTypeName = model.parentname;
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
