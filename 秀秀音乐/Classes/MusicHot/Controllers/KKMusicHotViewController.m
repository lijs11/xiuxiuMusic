//
//  KKMusicHotViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/4.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMusicHotViewController.h"
#import "KKWebPageViewController.h"
#import "KKMusicHotModel.h"
#import "KKNewCDViewController.h"

#import "KKMusicListViewController.h"
#import "KKMusicHotCell.h"

#import "KKOneTwoThreeCell.h"
#import "KKSongsListCell.h"
#import "KKHeaderView.h"

@interface KKMusicHotViewController ()<KKOneTwoThreeCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableArray *dataSection;
@property (nonatomic,strong)UIImageView *imageBg;

@property (nonatomic, strong) NSMutableArray *imageURLArr;//存放循环图片



@end

@implementation KKMusicHotViewController

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


- (NSMutableArray *)imageURLArr{
    if (_imageURLArr == nil) {
        self.imageURLArr = [NSMutableArray array];
    }
    return _imageURLArr;
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
    
    if (self.dataSourceArr.count > 0) {
        return;
    }

    
     [self updateHotData];//初始化数组
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets =NO;
    self.tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageBg];
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if (section == 0 || section == 2 || section == 3 ) {
        return 1;
//        NSLogg(@"section 1 2 3");
    }else{
        
//        NSLogg(@"section--%ld",section);
//        NSLogg(@"array.count--%ld",[self.dataSourceArr[section] count]);
//       

        return [self.dataSourceArr[section] count];
        
       
    }
    
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KKMusicHotModel *musicModel = self.dataSourceArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {//头部
        
        static NSString *ID = @"KKMusicHotCellID";
        KKMusicHotCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"KKMusicHotCell" owner:self options:nil] lastObject];
        }
        
        [cell configureCycleImage:self.imageURLArr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //图片的index传过来 到对应的ListView中 加载数据 index -> Model.ID -> data
        cell.currentIndex = ^(NSInteger index){
            
            KKMusicHotModel *cellModel = self.dataSourceArr[0][index];
            [self pushToListByMsgID:cellModel.ID title:cellModel.name];
        };
        
        return cell;
    }else if (indexPath.section == 2 || indexPath.section == 3) {//中间两个奇葩
        
        
        static NSString *ID1 = @"KKOneTwoThreeCellID";
        KKOneTwoThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"KKOneTwoThreeCell" owner:self options:nil] lastObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        
        while ([self.dataSourceArr[indexPath.section] count] < 3) {
            [self.dataSourceArr[indexPath.section] addObject:self.dataSourceArr[indexPath.section][0]];
        }
        
        [cell configureCell:self.dataSourceArr[indexPath.section]];//设置数据
        cell.indexPath = indexPath.section;
        
        return cell;
        
        
    }else{//其他正常cell
        
       
        static NSString *ID1 = @"KKSongsListCellID";
        KKSongsListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"KKSongsListCell" owner:self options:nil] lastObject];
        }
        cell.pic.layer.cornerRadius = 5;
        cell.pic.layer.masksToBounds = YES;
        cell.model = musicModel;
        
        return cell;
        
    }
    

}







- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self pushToListByMsgID:@"300002376" title: [self.dataSection[indexPath.section] name]];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        
        KKNewCDViewController *cdVC = [[KKNewCDViewController alloc] init];
        cdVC.navigationCC = self.navigationVc;
        cdVC.NvTitle = [self.dataSection[indexPath.section] name];
        [self.navigationVc pushViewController:cdVC animated:YES];
        
    } else if (indexPath.section == 2 ) {
    } else if (indexPath.section == 3) {
    } else {
        KKMusicHotModel *model = self.dataSourceArr[indexPath.section][indexPath.row];
        if ([model.action[@"type"] isEqualToNumber:@(1)]) {
            KKWebPageViewController *web = [[KKWebPageViewController alloc] init];
            web.urlString = model.action[@"value"];
            web.NavigationCC = self.navigationVc;
            [self.navigationVc pushViewController:web animated:YES];
        } else {
            [self pushToListByMsgID:model.ID  title:[self.dataSection[indexPath.section] name]];
        }
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    KKHeaderView *headerView = [KKHeaderView shareHeaderView:tableView];
    headerView.sectionTitle = [self.dataSection[section] name];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor redColor];
    
   return section == 0 ? nil : headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return section == 0 ? 1 : 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return self.dataSection.count - 1 == section ? 70 : 5;
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 160;
    } else if (indexPath.section == 2 || indexPath.section == 3) {
        return 180;
    } else {
        return 110;
    }
    
}


#pragma mark - 三张图片Tap代理方法
- (void)oneTwoThreeCell:(KKOneTwoThreeCell *)oneTwoThreeCell TapWithImageNum:(NSInteger)row{
    
//    KKMusicListViewController *listVc = [[KKMusicListViewController alloc] init];
//    listVc.navigationCC = self.navigationVc;
    
    NSInteger indexPath = oneTwoThreeCell.indexPath;
    
//    listVc.NvTitle = [self.dataSection[indexPath] name];
//    
//    listVc.msg_id = [self.dataSourceArr[indexPath][row] ID];
//  
//    [self.navigationVc pushViewController:listVc animated:YES];
    
    //防止出错
    if (indexPath > self.dataSourceArr.count) return;
    if (indexPath > self.dataSection.count) return;
    if (row > [self.dataSourceArr[indexPath] count]) return;
    
    
    KKMusicHotModel *model = self.dataSourceArr[indexPath][row];
    KKMusicHotModel *model1 = self.dataSection[indexPath];
    
    KKWebPageViewController *web = [[KKWebPageViewController alloc] init];
    web.urlString = model.ID;
    web.NavigationCC = self.navigationVc;
    web.NVTitle = model.name;
    [self.navigationVc pushViewController:web animated:YES];
    
    
    
}



#pragma mark - 更新传入ListView的数据

//除三张图片
- (void)pushToListByMsgID:(NSString *)msg_id title:(NSString *)title {
    
    KKMusicListViewController *listVc = [[KKMusicListViewController alloc] init];
    listVc.navigationCC = self.navigationVc;
    listVc.msg_id = msg_id;
    listVc.NvTitle = title;
    [self.navigationVc pushViewController:listVc animated:YES];
}



#pragma mark - updateHotData
- (void)updateHotData{
    
    
   [KKNetWorkTool JsonDataWithUrl:kMusicHotViewController success:^(id data) {
        NSArray *sectionArr = data[@"data"];
//       NSLog(@"%@",data);
    int i = 0;
    for (NSDictionary *dictSection  in sectionArr) {
        KKMusicHotModel *modelSection = [[KKMusicHotModel alloc] init];
        [modelSection setValuesForKeysWithDictionary:dictSection];
        
        NSArray *rowArr = dictSection[@"data"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dictRow in rowArr) {
            KKMusicHotModel *modelRow = [[KKMusicHotModel alloc] init];
            [modelRow setValuesForKeysWithDictionary:dictRow];
            modelRow.ID = modelRow.action[@"value"];
            
            if(!modelRow.ID) {
                continue;
            }
            
            if (i == 0) {
                [self.imageURLArr addObject:[NSURL URLWithString:modelRow.pic_url]];
            }
            
            [tempArr addObject:modelRow];
        }
        
        if (tempArr.count > 0) {
            [self.dataSourceArr addObject:tempArr];
            [self.dataSection addObject:modelSection];
        }
        i++;
    }
    [self.tableView reloadData];
    [self.imageBg removeFromSuperview];
    self.imageBg = nil;
} fail:^{
    
} view:self.view parameters:nil];
}

@end
