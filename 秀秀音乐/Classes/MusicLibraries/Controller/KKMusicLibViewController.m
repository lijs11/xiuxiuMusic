//
//  KKMusicLibViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/4.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMusicLibViewController.h"
#import "KKMusicLibModel.h"
#import "KKMusicLibCell.h"

#import "KKNewCDViewController.h"
#import "KKMusicWeekViewController.h"
#import "KKSingerTypeViewController.h"
#import "KKSongTypeViewController.h"
#import "KKMusicListViewController.h"
#import "KKBaseViewController.h"

@interface KKMusicLibViewController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArray;



@end


@implementation KKMusicLibViewController

#pragma mark - 懒加载

- (NSMutableArray *)dataSourceArray{
    if (_dataSourceArray == nil) {
        self.dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self updateData];
    
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //1.创建cell
    static NSString *ID = @"KKMusicLibCell1";
    KKMusicLibCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KKMusicLibCell" owner:self options:nil] lastObject];
    }
    
    KKMusicLibModel *model = self.dataSourceArray[indexPath.row];
    cell.model = model;
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    KKBaseViewController *Vc;
    KKMusicLibCell *cell = (KKMusicLibCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        Vc = [[KKNewCDViewController alloc] init];
    }else if (indexPath.row == 1){
         Vc = [[KKMusicWeekViewController alloc] init];
    }else if (indexPath.row == 2){
        Vc = [[KKSingerTypeViewController alloc] init];
    }else if (indexPath.row == 3){
        Vc = [[KKSongTypeViewController alloc] init];
    }else if (indexPath.row == 4){
        KKMusicListViewController *ListVc = [[KKMusicListViewController alloc] init];
        ListVc.from = @"songType";
        ListVc.msg_id = @"3";
        Vc = ListVc;
    }
    
    Vc.navigationCC = self.navigationVc;
    Vc.NvTitle = cell.model.typeName;
    NSLogg(@"Class--%@ indexPath--%ld",[Vc class],indexPath.row);
    
    [self.navigationVc pushViewController:Vc animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 70;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 192;
    
}





#pragma mark - updateData
- (void)updateData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"musicType.plist" ofType:nil];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict in array) {
        
        KKMusicLibModel *model = [[KKMusicLibModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.dataSourceArray addObject:model];
    }
    
    [self.tableView reloadData];
}

@end
