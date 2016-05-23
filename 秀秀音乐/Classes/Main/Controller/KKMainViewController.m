//
//  KKMainViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/2.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMainViewController.h"
#import "KKNetWorkTool.h"
#import "KKSearchParam.h"
#import "KKSearchResult.h"
#import "KKAudition_list.h"
#import <AVFoundation/AVFoundation.h>

#import "UINavigationController+FDFullscreenPopGesture.h"

#import "SwipeView.h"
#import "KKMusicLibViewController.h"
#import "KKMusicHotViewController.h"
#import "KKSearchViewController.h"
#import "KKMusicMineViewController.h"

#import "BottomPlayView.h"

@interface KKMainViewController ()<SwipeViewDataSource,SwipeViewDelegate>

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (nonatomic, strong) NSMutableArray *items;//存放swipeView
@property (weak, nonatomic) IBOutlet UIView *moveView;
@property (nonatomic,strong)BottomPlayView *bottomPlayView;
@end

@implementation KKMainViewController

- (BottomPlayView *)bottomPlayView{
    
    if (_bottomPlayView == nil) {
       self.bottomPlayView = [BottomPlayView shareBottomPlayView];
    }
    return _bottomPlayView;
}

- (void)dealloc {
    //释放代理
    _swipeView.delegate = nil;
    _swipeView.dataSource = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.view addSubview:self.bottomPlayView.view];
    [self.view bringSubviewToFront:self.bottomPlayView.view];
    self.bottomPlayView.view.frame = CGRectMake(0, self.view.height - self.bottomPlayView.view.height, self.bottomPlayView.view.width, self.bottomPlayView.view.height);
    self.bottomPlayView.navigationVc = self.navigationController;
   
}




- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    //    self.navigationController.hidesBarsOnSwipe = YES; //滑动隐藏
    self.fd_prefersNavigationBarHidden = YES;
    self.swipeView.pagingEnabled = YES;
    self.swipeView.delegate = self;
    self.swipeView.dataSource = self;
    self.swipeView.wrapEnabled = YES;
    [self setupView];
    [_swipeView reloadData];
    
//    [self.view addSubview:self.bottomPlayView.view];
//    [self.view bringSubviewToFront:self.bottomPlayView.view];
    
    
   
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
   
//    self.bottomPlayView.backgroundColor = [UIColor redColor];
//    NSLog(@"%lf",self.bottomPlayView.height);
    
    
}







#pragma mark - 配置swipeView视图

- (void)setupView {
    
    KKMusicHotViewController *hotVC = [[KKMusicHotViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:nav];
    hotVC.navigationVc = self.navigationController;
    
    KKMusicLibViewController *typeVC = [[KKMusicLibViewController alloc] init];
    typeVC.navigationVc = self.navigationController;
    
    KKMusicMineViewController *mineVC = [[KKMusicMineViewController alloc] init];
    mineVC.navigationVc = self.navigationController;
    
    KKSearchViewController *searchVC =  [[KKSearchViewController alloc] init];
    searchVC.navigationVc = self.navigationController;
    
    self.items = [NSMutableArray arrayWithObjects:typeVC,  hotVC, searchVC, mineVC, nil];
    
}

#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //return the total number of items in the carousel
    return _items.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    return [_items[index] view];
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}



#pragma mark - button action
- (IBAction)btnSearch:(id)sender {
    _swipeView.currentItemIndex = 2;
}
- (IBAction)btnMine:(id)sender {
    _swipeView.currentItemIndex = 3;
}
- (IBAction)btnHot:(id)sender {
    _swipeView.currentItemIndex = 1;
}
- (IBAction)btnMusic:(id)sender {
    _swipeView.currentItemIndex = 0;
}




- (void)swipeViewDidScroll:(SwipeView *)swipeView {
    
    for (int i = 0; i < _items.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100 + i];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    switch (swipeView.currentItemIndex) {
        case 0:{
            [self updateLineViewFrame:0];
            break;
        }
        case 1:{
            [self updateLineViewFrame:1];
            break;
        }
        case 2: {
            [self updateLineViewFrame:2];
            break;
        }
        case 3: {
            [self updateLineViewFrame:3];
            break;
        }
        default:
            break;
    }
}

- (void)updateLineViewFrame:(NSInteger)index {
    CGRect frame = _moveView.frame;
    UIButton *btn = (UIButton *)[self.view viewWithTag:100 + index];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    frame.origin.x = index * ([UIScreen mainScreen].bounds.size.width / 4) + btn.frame.size.width / 4   + 1;
    _moveView.frame = frame;
}



@end
