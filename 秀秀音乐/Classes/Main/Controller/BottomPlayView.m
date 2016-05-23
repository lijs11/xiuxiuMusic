//
//  BottomPlayView.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/5.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "BottomPlayView.h"
#import "PlayMusicViewController.h"

@interface BottomPlayView ()

- (IBAction)jump;
@property (weak, nonatomic) IBOutlet UIImageView *playLinePic;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *singerName;


@property (nonatomic,strong)CADisplayLink *lineTimer;

@property (nonatomic,assign) int *index;

@end

@implementation BottomPlayView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.playLinePic.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"line1"],[UIImage imageNamed:@"line2"],[UIImage imageNamed:@"line3"],[UIImage imageNamed:@"line4"],nil];
    
    self.playLinePic.animationDuration = 1.0;
    
}



+ (BottomPlayView *)shareBottomPlayView {
    static BottomPlayView *bpv = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bpv = [[self alloc] init];
    });
    return bpv;
}


- (void)setResult:(KKSearchResult *)result{
    
    _result = result;
    
    if (result == nil) {
        
        self.songName.text = @"好像没有播放歌曲哦~";
        self.singerName.text = nil;
    }else{
        
        self.songName.text = result.song_name;
        self.singerName.text = result.singer_name;
    }
    
    
}

- (void)setPlaying:(BOOL)playing{
    
    _playing = playing;
    
    if (playing) {
        
//        [self addTimer];
        [self.playLinePic startAnimating];
        
    }else{
        
//        [self removeTimer];
        [self.playLinePic stopAnimating];
    }
    
}

//- (void)addTimer{
//    
//    if (self.isPlaying == NO) return;
//    
//    [self removeTimer];
//    //避免滑块一开始显示空白
//    [self updateTime];
//    //    self.slider.titleLabel.text = @"0:0";
//    //    [self.slider setTitle:@"0:0" forState:UIControlStateNormal];
//    self.lineTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
//    [self.lineTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    
//}
//
//
//- (void)removeTimer{
//    [self.lineTimer invalidate];
//    self.lineTimer = nil;
//    
//}
//
///**更新时间*/
//- (void)updateTime{
//    
//   
//  
//    
//    
//}






- (IBAction)jump {
    
    //1:获取音乐播放器对象
    PlayMusicViewController *playMusicV = [PlayMusicViewController shareWithPlayMusicViewController];
    //完成界面跳转
    [self.navigationVc pushViewController:playMusicV animated:YES];
    
    
}
@end
