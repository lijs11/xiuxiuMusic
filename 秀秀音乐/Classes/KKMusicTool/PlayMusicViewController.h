//
//  PlayMusicViewController.h
//  FMLesson
//
//  Created by caizheyong on 16/2/24.
//  Copyright (c) 2016年 xiaocaicai111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayMusicViewController : UIViewController
@property (nonatomic, strong)NSMutableArray *dataSourceArr; //存储所有的音频数据
@property (nonatomic)NSInteger index; //存储当前需要播放的音频数据的下标

@property (nonatomic,strong)UINavigationController *navigationVc;

//声明一个方法创建音乐播放器界面对象
+ (PlayMusicViewController *)shareWithPlayMusicViewController;
//定义方法完成音频数据的播放
- (void)playMusic;




@end
