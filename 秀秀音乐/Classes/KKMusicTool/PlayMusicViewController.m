//
//  PlayMusicViewController.m
//  FMLesson
//
//  Created by caizheyong on 16/2/24.
//  Copyright (c) 2016年 xiaocaicai111. All rights reserved.
//

#import "PlayMusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "KKSearchResult.h"
#import "KKAudition_list.h"
#import "KKUrl_list.h"
#import "PlayerHelper.h"
#import "HMLrcView.h"
#import "BottomPlayView.h"

#import "KKMusicTool.h"

@interface PlayMusicViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage; //背景图片
@property (strong, nonatomic) IBOutlet UILabel *songTitleLabel; //歌曲标题
@property (strong, nonatomic) IBOutlet UILabel *singerTitleLabel; //歌手

//@property (strong, nonatomic) IBOutlet UISlider *progress;
@property (weak, nonatomic) IBOutlet UIButton *slider;
@property (weak, nonatomic) IBOutlet UIButton *currentTimeView;
@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (strong, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

- (IBAction)previousMusic:(id)sender;
- (IBAction)nextMusic:(id)sender;
- (IBAction)playMusic:(id)sender;

@property (nonatomic, strong)NSTimer *timer; //存储时间计时器对象
@property (nonatomic, strong)AVQueuePlayer *player; //存储播放器对象
@property (nonatomic, strong)AVPlayerItem *playerItem; //存储音频信息
@property (nonatomic,strong) KKSearchResult *isPlayingResult;//储存正在播放对象，防止重新播
@property (nonatomic,assign)double progress;

@property (nonatomic,weak) id timeObserve;
@property (nonatomic,assign,getter=isHavingObserver) BOOL havingObserver;//这个方法有点废
@property (nonatomic,assign,getter=isisPlaying) BOOL isPlaying;//是否播放音乐


/**手势处理*/
- (IBAction)panSlider:(UIPanGestureRecognizer *)sender;
- (IBAction)tap:(UITapGestureRecognizer *)sender;


/**歌词按键处理*/
- (IBAction)lyricOrPic:(UIButton *)sender;
/**歌词显示定时器*/
@property (nonatomic,strong)CADisplayLink *lrcTimer;

@property (weak, nonatomic) IBOutlet HMLrcView *lrcView;

//给外面bottomView赋值用
@property (nonatomic,strong)BottomPlayView *bottomPlayView;

//收藏
- (IBAction)collectBtn:(UIButton *)sender;

@end

@implementation PlayMusicViewController

#pragma mark - 单例
+ (PlayMusicViewController *)shareWithPlayMusicViewController {
    static PlayMusicViewController *playV = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playV = [[PlayMusicViewController alloc]initWithNibName:@"PlayMusicViewController" bundle:nil];
    });
    return playV;
}

#pragma mark - 懒加载
- (BottomPlayView *)bottomPlayView{
    if (_bottomPlayView == nil) {
        self.bottomPlayView = [BottomPlayView shareBottomPlayView];
    }
    return _bottomPlayView;
}






//懒加载常见音频播放器对象
- (AVQueuePlayer *)player {
    if (_player == nil) {
        self.player = [PlayerHelper sharePlayerHelper].aPlayer;
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"播放界面";
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
//    //为背景图片添加高斯模糊效果
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//    effectView.frame = self.backgroundImage.frame;
//    [self.backgroundImage addSubview:effectView];
    //修改标签的边角
    
    KKSearchResult *result = self.dataSourceArr[self.index];
    self.songTitleLabel.text = result.song_name;
    self.singerTitleLabel.text = result.singer_name;
    
    
    
    
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark PlayMusic
//播放音乐
- (void)playMusic {
    
    self.isPlaying = YES;
    
    //1:获取对应的音频数据
     KKSearchResult *result = self.dataSourceArr[self.index];
    
    [[KKMusicTool sharedMusicTool] saveHistoryDeal:result];//播放历史！！！
    
    
    if (!result) return;
    
    if ([result isEqual:self.isPlayingResult]){//看看是不是同一首歌
        return;
    }
    else{
        self.isPlayingResult = result;
    }
    
    [self endPlay];
    
//    //重置进度
//    self.progress = 0;
//    self.slider.x = 0;
//    self.progressView.x = 0;
//    
    
    
    self.songTitleLabel.text = result.song_name;
    self.singerTitleLabel.text = result.singer_name;
    
    NSString *playingUrl;
    if (result.audition_list.count > 0) {
        KKAudition_list *list = [result.audition_list firstObject];
        playingUrl = list.url;
    }else if (result.url_list.count > 0){
        KKUrl_list *url_list = [result.url_list firstObject];
        playingUrl = url_list.url;
    }else{
        
        [MBProgressHUD showError:@"无法播放！"];
    }
    
    
    if (!playingUrl) return;
    
    //2:创建AVPlayerItem对象
    AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:playingUrl]];
    //3:替换播放器之前的Item
    if (!playItem) return;
    
    [self.player replaceCurrentItemWithPlayerItem:playItem];
    
    //4:开始播放
    [self.player play];
    
    //5:监听播放进度
    [self addObserverForProgress];
    //6:监听播放器的状态
    [self addObserverForState];
    //7.添加播放完成的监听事件--自动下一首
    [self addNotificationPlayerFinished];
    
    
    //8.切换歌词--传入模型，根据模型自己下载歌词加载
    self.lrcView.result = result;
    [self addLrcTimer];
    
    
    //9.给BottomView赋值
    self.bottomPlayView.result = result;
    self.bottomPlayView.playing = YES;

}
//监听播放进度
- (void)addObserverForProgress {
    //获取当前播放器的音频信息
    AVPlayerItem *playItem = self.player.currentItem;

//    float currentTime = CMTimeGetSeconds(playItem.currentTime);
//    float totleTime = CMTimeGetSeconds(playItem.duration);
    
    
    //开始监听播放器播放进度的变化
    __weak PlayMusicViewController *playV = self;
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 10.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //获取当前播放的进度 CMTimeMake()
        float currentTime = CMTimeGetSeconds(playItem.currentTime);
        //获取音频文件的总时间
        float totleTime = CMTimeGetSeconds(playItem.duration);
//        NSLog(@"%lf %lf",totleTime,currentTime);
        //设置进度条的总大小
//        playV.progress.maximumValue = totleTime;
        //改变进度条的进度
//        [playV.progress setValue:currentTime animated:YES];
        
        
        
#warning totleTime 一定要判断有没有值，因为要除。不然变成nan View的frame出错
        CGFloat progress;
        if (totleTime > 0) {
            progress = currentTime / totleTime;
        }
        
        playV.progress = progress;
        //当前时间
        int minite = currentTime / 60;
        int second = (int)currentTime % 60;
        playV.slider.titleLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",minite,second];
        playV.slider.title = [NSString stringWithFormat:@"%.2d:%.2d",minite,second];
        
        //总时间
        int minite1 = totleTime / 60;
        int second1 = (int)totleTime % 60;
        playV.totalTimeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",minite1,second1];
        
//        [playV updateCurrentTime];
        
        //计算滑块的位置
        CGFloat sliderMaxX = playV.view.width - playV.slider.width;
        if (playV.progress) {
            playV.slider.x = sliderMaxX * playV.progress;
        }
        
        
        //计算进度条的位置
        playV.progressView.width = playV.slider.centerX;
        
        
    }];
    
#warning timeObserve 一定要移除
   
    
}



//KVO监听当前播放器的播放状态- 准备播放进行响应状态调整
- (void)addObserverForState {
    //添加监听者
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    self.havingObserver = YES;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //获取当前的状态
    AVPlayerStatus statu = [change[@"new"] intValue];
//    NSLog(@"%ld", (long)statu);
    //如果状态是准备播放执行相应的操作
    if (statu == AVPlayerStatusReadyToPlay) {
        [self.playBtn setImage:[UIImage imageNamed:@"pause1"] forState:UIControlStateNormal];
        //旋转播放杆
//        [self handleNeedleRoation:NO];
        [self.timer invalidate];
        //创建计时器旋转标题
        self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(handleTitleLabelRotation) userInfo:nil repeats:YES];
    }
    
    
    if (statu == AVPlayerStatusFailed){
        
        [MBProgressHUD showError:@"网络好像有问题！"];
    }
}


//添加播放完成的监听事件
-(void)addNotificationPlayerFinished{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlayNextMusic) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupPlayingState) name:AVPlayerStatusReadyToPlay object:self.player.currentItem];
    
}
//移除观察者
-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//单独添加一个播放器是否播放通知
- (void)setupPlayingState{
    
    
    
}





#pragma mark Btn Click
//上一首
- (IBAction)previousMusic:(id)sender {
    [self endPlay];
    if (self.index > 0) {
        self.index--;
    }else {
        self.index = self.dataSourceArr.count - 1;
    }
    [self stop];
    [self playMusic];
}
//下一首
- (IBAction)nextMusic:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         [self startPlayNextMusic];
    });
   
}
//执行播放下一首操作
- (void)startPlayNextMusic {
    
    [self endPlay];
    if (self.index < self.dataSourceArr.count - 1) {
        self.index++;
    }else {
        self.index = 0;
    }
    
    
    
    [self stop];
    [self playMusic];
}
//播放按钮
- (IBAction)playMusic:(id)sender {
    
    //1:判断播放器的状态
    //播放状态
    if (self.player.rate == 1) {
        [self stop];
    }else {
        
        if (self.dataSourceArr[self.index]) {
            [self playing];
        }
        
    }
}
//定义方法将播放界面的控件恢复为未播放的状态
- (void)stop {
    
     self.bottomPlayView.playing = NO;
    if (!self.player) return;
    
    
    [self.player pause]; //暂停播放
    [self.playBtn setImage:[UIImage imageNamed:@"play1"] forState:UIControlStateNormal];//修改按钮显示的图片
    [self.timer invalidate]; //暂停计时器
//    [self handleNeedleRoation:YES];
    self.isPlaying = NO;
    
}
//定义方法将播放界面设置为播放状态
- (void)playing {
    
    self.isPlaying = YES;
    self.bottomPlayView.playing = YES;
    
    if (!self.player) return;
    
    [self.player play]; //启动播放器
    [self.playBtn setImage:[UIImage imageNamed:@"pause1"] forState:UIControlStateNormal];
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(handleTitleLabelRotation) userInfo:nil repeats:YES];
//    [self handleNeedleRoation:NO];
}
#pragma mark Roation
- (void)handleTitleLabelRotation {
//    self.titleLabel.transform = CGAffineTransformRotate(self.titleLabel.transform, M_PI / 50);
}
//定义方法实现播放杆的旋转


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Change Progress
- (IBAction)changeProgress:(UISlider *)sender {
    //改变播放器的进度
    [self.player seekToTime:CMTimeMake(sender.value, 1.0)];
}


#pragma mark - removeAllObservers 关系到时间判断 很重要
- (void)removeAllObservers{
    
    if (self.player == nil) return;
    
//    AVPlayerItem * songItem = self.player.currentItem;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.isHavingObserver) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
        self.havingObserver = NO;
    }
    
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
    
    
//    [songItem removeObserver:self forKeyPath:@"status"];
//    [songItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
    [self.player replaceCurrentItemWithPlayerItem:nil];
    
    
    
}
- (void)endPlay {
    if (self.player == nil) return;
    
    [self.player pause];
    
  
    
    //移除监控
    [self removeAllObservers];
    
   
    
//    //重置封面
//    self.coverImg = DefaultImg;
//    
//    SendNotify(SONGPLAYSTATUSCHANGE, nil)
}



#pragma mark - 时间滑块处理---手势
- (IBAction)panSlider:(UIPanGestureRecognizer *)sender {
    
    if (!self.player.currentItem) return;
        
        
    [self stop];
    
    
    CGPoint t = [sender translationInView:sender.view];//拖拽的距离
    [sender setTranslation:CGPointZero inView:sender.view];//清零
    CGFloat sliderMaxX = self.view.width - self.slider.width;
    
    //滑块的位置
    self.slider.x += t.x;
    if (self.slider.x < 0) {
        self.slider.x = 0;
    }else if (self.slider.x > sliderMaxX) {
        self.slider.x = sliderMaxX;
    }
   
    
    
    //计算进度条的位置
    self.progressView.width = self.slider.centerX;
    
    
    //设置时间值
    double progress = self.slider.x / sliderMaxX ;
    
    //获取当前播放的进度 CMTimeMake()
    AVPlayerItem *playItem = self.player.currentItem;
    //获取音频文件的总时间
    float totleTime = CMTimeGetSeconds(playItem.duration);
    NSTimeInterval currentTime = totleTime * progress;
    
    
   //设置播放器播放的起点
    CMTime dragedCMTime = CMTimeMake(currentTime, 1);
    [self.player seekToTime:dragedCMTime];
        
        
      
    //当前时间
    int minite = currentTime / 60;
    int second = (int)currentTime % 60;
    self.slider.titleLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",minite,second];
    self.slider.title = [NSString stringWithFormat:@"%.2d:%.2d",minite,second];
    
    //总时间
    int minite1 = totleTime / 60;
    int second1 = (int)totleTime % 60;
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",minite1,second1];
   
    
    //设置指示器时间值
    self.currentTimeView.titleLabel.text = self.slider.currentTitle;//两个方法都写 避免闪现
    [self.currentTimeView setTitle:self.slider.currentTitle forState:UIControlStateNormal];
    
    self.currentTimeView.centerX = self.slider.centerX;//指示器随着拖动移动
   
   
    
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        //设置指示器
        self.currentTimeView.hidden = NO;
    }else if (sender.state == UIGestureRecognizerStateEnded){
        
        self.currentTimeView.hidden = YES;
        
}
    
    
    [self playing];

}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    
    if (!self.player.currentItem) return;
     [self stop];
    
    CGPoint point = [sender locationInView:sender.view];
    CGFloat sliderMaxX = self.view.width - self.slider.width;
    
    //滑块的位置
    self.slider.centerX = point.x;
    
    
    if (self.slider.x < 0) {//后面和pan方法一模一样！
        self.slider.x = 0;
    }else if (self.slider.x > sliderMaxX) {
        self.slider.x = sliderMaxX;
    }
    
    
    
    //计算进度条的位置
    self.progressView.width = self.slider.centerX;
    
    
    //设置时间值
    double progress = self.slider.x / sliderMaxX ;
    
    //获取当前播放的进度 CMTimeMake()
    AVPlayerItem *playItem = self.player.currentItem;
    //获取音频文件的总时间
    float totleTime = CMTimeGetSeconds(playItem.duration);
    NSTimeInterval currentTime = totleTime * progress;
    
    
    //设置播放器播放的起点
    CMTime dragedCMTime = CMTimeMake(currentTime, 1);
    [self.player seekToTime:dragedCMTime];
    
    
    
    //当前时间
    int minite = currentTime / 60;
    int second = (int)currentTime % 60;
    self.slider.titleLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",minite,second];
    self.slider.title = [NSString stringWithFormat:@"%.2d:%.2d",minite,second];
    
    //总时间
    int minite1 = totleTime / 60;
    int second1 = (int)totleTime % 60;
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",minite1,second1];
    
    
    //设置指示器时间值
    self.currentTimeView.titleLabel.text = self.slider.currentTitle;//两个方法都写 避免闪现
    [self.currentTimeView setTitle:self.slider.currentTitle forState:UIControlStateNormal];
    
    self.currentTimeView.centerX = self.slider.centerX;//指示器随着拖动移动
    
    
    
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        //设置指示器
        self.currentTimeView.hidden = NO;
    }else if (sender.state == UIGestureRecognizerStateEnded){
        
        self.currentTimeView.hidden = YES;
        
    }

    
    
    
    
    
    [self playing];
}



#pragma mark - 歌词或者背景按钮处理

- (IBAction)lyricOrPic:(UIButton *)sender {
    
    if (self.lrcView.hidden) {//显示歌词,盖住图片
        self.lrcView.hidden = NO;
        sender.selected = YES;
        
        
        //8.切换歌词--传入模型，根据模型自己下载歌词加载
        KKSearchResult *result = self.dataSourceArr[self.index];
        self.lrcView.result = result;
        [self addLrcTimer];
        
        
    }else{//显示图片
        
        self.lrcView.hidden = YES;
        sender.selected = NO;
        [self removeLrcTimer];
    }
 
    
}

#pragma mark - 歌词定时器处理
- (void)addLrcTimer{
    
    if (self.isPlaying == NO || self.lrcView.hidden) return;
    
    
    [self removeLrcTimer];
    //避免滑块一开始显示空白
    [self updateLrcTime];
    //    self.slider.titleLabel.text = @"0:0";
    //    [self.slider setTitle:@"0:0" forState:UIControlStateNormal];
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcTime)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}


- (void)removeLrcTimer{
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
    
}

/**更新时间*/
- (void)updateLrcTime{
    AVPlayerItem *playItem = self.player.currentItem;
    
    float currentTime = CMTimeGetSeconds(playItem.currentTime);
    self.lrcView.currentTime = currentTime;
    
}



#pragma mark - 收藏

- (IBAction)collectBtn:(UIButton *)sender {
    
    if (self.dataSourceArr[self.index] == nil) return;
    
    KKSearchResult *result = self.dataSourceArr[self.index];
    
    [[KKMusicTool sharedMusicTool] saveCollectDeal:result];//收藏历史！！！
    
    
    [MBProgressHUD showSuccess:@"收藏成功!"];
    
}





@end
