//
//  KKMusicMineViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/4.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMusicMineViewController.h"
#import "KKMineCell.h"
#import "KKHistoryOrCollectViewController.h"

@interface KKMusicMineViewController ()

@property (nonatomic, strong) NSMutableArray *dataNameArray;
@property (nonatomic, strong) NSMutableArray *dataImageArray;

@end

@implementation KKMusicMineViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataImageArray = [NSMutableArray arrayWithObjects:@" ", @"icon_posted@2x",@"icon_icommentd@2x", @"icon_nightmode@2x", @"icon_posted@2x",  @"icon_myfriends@2x", nil];
    self.dataNameArray = [NSMutableArray arrayWithObjects: @" ", @"最近播放", @"我的喜爱", @"清除缓存", @"免责声明", @"关于我", nil];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.view.bounds;
    imageView.alpha = 0.5;
    imageView.image = [UIImage imageNamed:@"background.jpg"];
    self.tableView.backgroundView = imageView;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}








#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //公共
    static NSString *ID = @"KKMineCellID";
    
    KKMineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KKMineCell" owner:self options:nil] lastObject];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    //图片文字公共
    if (self.dataNameArray.count) {
    cell.title.text = self.dataNameArray[indexPath.row];
    }
    if (self.dataImageArray[indexPath.row]){
        cell.pic.image = [UIImage imageNamed:self.dataImageArray[indexPath.row]];
    }
    
    //图片文字 1,2
    if (indexPath.row == 0) {
        
        cell.sepaView.alpha = 0;
    }else if (indexPath.row == 1){
        
        
    }else if (indexPath.row == 2){
        
        
    }
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKHistoryOrCollectViewController *hisOrCollectVc = [[KKHistoryOrCollectViewController alloc] init];
    if (indexPath.row == 0) {
        
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else if (indexPath.row == 1){
        hisOrCollectVc.from = @"history1";
        hisOrCollectVc.navigationCC = self.navigationVc;
        hisOrCollectVc.NvTitle = @"播放历史";
        [self.navigationVc pushViewController:hisOrCollectVc animated:YES];
        
    }else if (indexPath.row == 2){
        
        hisOrCollectVc.from = @"collect1";
        hisOrCollectVc.navigationCC = self.navigationVc;
        hisOrCollectVc.NvTitle = @"我的收藏";
        [self.navigationVc pushViewController:hisOrCollectVc animated:YES];
        
    }else if (indexPath.row == 3){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"真的要清除吗?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alertView.delegate = self;
        [alertView show];
        
    }else if (indexPath.row == 4){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"本APP为参考制作,仅供学习" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }else if (indexPath.row == 5){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"APP制作:毛毛虫、\n联系:12345@qq.com" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
    
    
}



#pragma mark - AlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   
    if (buttonIndex == 1) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        [self.view addSubview:hud];
        hud.labelText = @"正在清理中...";
        hud.mode = MBProgressHUDModeDeterminate;
        [hud showAnimated:YES whileExecutingBlock:^{
            
            while (hud.progress < 1.0) {
                hud.progress += 0.01;
                [NSThread sleepForTimeInterval:0.02];
            }
            hud.labelText = @"清理完成！";
            
        }completionBlock:^{
            //清除方法
            
            NSFileManager *mgr = [NSFileManager defaultManager];
            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSArray *pathsArray = [mgr subpathsAtPath:cachesPath];
            for (NSString *str  in pathsArray) {
                [mgr removeItemAtPath:[cachesPath stringByAppendingPathComponent:str] error:nil];
            }            
            
            [[SDImageCache sharedImageCache] cleanDisk];
            [self.tableView reloadData];
            [hud removeFromSuperview];
        }];
        
 }
    
    
    
    
    
}








#pragma mark - 加载最近播放列表





@end
