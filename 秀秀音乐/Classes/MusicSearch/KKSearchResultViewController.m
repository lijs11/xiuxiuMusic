//
//  KKSearchResultViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/4.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKSearchResultViewController.h"
#import "KKSearchParam.h"
#import "KKSearchResult.h"
#import "KKNetWorkTool.h"
#import "KKResultCell.h"
#import "PlayMusicViewController.h"

@interface KKSearchResultViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation KKSearchResultViewController

#pragma mark - 懒加载
- (UISearchBar *)searchBar{
    if (_searchBar == nil) {
        self.searchBar = [[UISearchBar alloc] init];
    }
    return _searchBar;
}

- (NSMutableArray *)dataSourceArr{
    if (_dataSourceArr == nil) {
        self.dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}


#pragma mark - 初始化
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationVc.navigationBar.hidden = NO;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"想听就搜呗";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"歌曲/歌手/专辑";
    [self.searchBar sizeToFit];
    self.searchBar.delegate = self;
    
    
    if (self.searchText) {
        
        self.searchBar.text = self.searchText;
        [self updateSearchData:self.searchText];
    }
    
}

- (void)back {
  
    [self.navigationVc popViewControllerAnimated:YES];
    
    
}


#pragma mark - searchBar




- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([searchText isEqualToString:@""] || !searchText) {
        return;
    }
    
    if (self.dataSourceArr) {
        [self.dataSourceArr removeAllObjects];
    }
    //根据关键字，重新请求
    [self updateSearchData:searchText];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
     [self.searchBar resignFirstResponder];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKSearchResult *result = self.dataSourceArr[indexPath.row];
    
    //1:获取音乐播放器对象
    PlayMusicViewController *playMusicV = [PlayMusicViewController shareWithPlayMusicViewController];
    //完成界面跳转
    [self.navigationController pushViewController:playMusicV animated:YES];
    //传递需要播放的数据源和对应的下标
    playMusicV.dataSourceArr = self.dataSourceArr;
    playMusicV.index = indexPath.row;
    //开始播放
    [playMusicV playMusic];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

#pragma mark - updateSearchData

- (void)updateSearchData:(NSString *)keyWord{


        //    NSDictionary *parameDict = [NSDictionary dictionaryWithObjects:@[keyWord, @"1", @"50"] forKeys:@[@"q", @"page", @"size"]];
        KKSearchParam *param = [[KKSearchParam alloc] init];
        param.q = keyWord;
        param.page = @1;
        param.size = @50;
    
        [KKNetWorkTool JsonDataWithUrl:kSearchController success:^(id data) {
    
            for (NSDictionary *dict in data[@"data"]) {
                KKSearchResult *result = [[KKSearchResult alloc] init];
                [result mj_setKeyValues:dict];
                [self.dataSourceArr addObject:result];
                
            }
            [self.tableView reloadData];
    
        } fail:^{
    
            [MBProgressHUD showError:@"网络异常，请稍后重试!"];
            
        } view:self.view parameters:param.mj_keyValues];
 }



@end
