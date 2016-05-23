//
//  HMLrcView.m
//  音频和音效01
//
//  Created by Kenny.li on 16/3/26.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "HMLrcView.h"
#import "HMLrcLine.h"
#import "HMLrcViewCell.h"
#import "KKNetWorkTool.h"

static NSString *ID = @"lrc";

@interface HMLrcView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *lrcLines;
@property (nonatomic,assign) int currentIndex;

@property (nonatomic,strong) NSString *lrcStr;



@end

@implementation HMLrcView


- (NSMutableArray *)lrcLines{
    
    if (_lrcLines == nil) {
        self.lrcLines = [NSMutableArray array];
    }
    return _lrcLines;
}


#pragma mark - 初始化方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupTableView];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTableView];
    }
    return self;
}

#pragma mark - 真机不行，模拟器可以
- (void)setupTableView{
    
//    UITableView *tableView = [[UITableView alloc] init];
//    tableView.backgroundColor = [UIColor clearColor];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    self.tableView = tableView;
//    [self addSubview:tableView];
    
}

#pragma mark - 真机这里才可以
- (void)awakeFromNib {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self addSubview:tableView];
}


#pragma mark - 公共方法

/**
 [ti:]
 [ar:]
 [al:]
 
 [00:00.89]传奇
 
 [ti:简单爱]
 [ar:周杰伦]
 [al:范特西]
 [00:-0.91]简单爱
 */
- (void)setResult:(KKSearchResult *)result{
    
    if (_result == result) {//重复返回
        return;
    }
        
    _result = result;
    
    [self.lrcLines removeAllObjects];
    
    __block HMLrcView *lrcV = self;
 
    NSDictionary *parameDict = [NSDictionary dictionaryWithObjects:@[@0, result.singer_name, result.song_name,result.song_id] forKeys:@[@"lrcid=", @"artist",@"title", @"song_id"]];
    
        
        [KKNetWorkTool JsonDataWithUrl:kLyricSearchApi success:^(id data) {
            
            NSDictionary *dict = data[@"data"];
            NSString *lrc = [NSString stringWithFormat:@"%@",dict[@"lrc"]];
//            NSLog(@"%@",lrc);
            if (lrc) {
             self.lrcStr = lrc;
            [lrcV setupLrcWithLrcStr:lrc];
            }
        } fail:^{
            
            [MBProgressHUD showError:@"网络异常，请稍后重试!"];
            
        } view:self parameters:parameDict];
        
   
    
}


- (void)setupLrcWithLrcStr:(NSString *)lrc{
    
        
//            NSLog(@"%@",[lrc class]);
//        lrcStr = @"[01:02.38]想你时你在天边\n [01:17.44]想你时你在脑海 [01:24.98]想你时你在心田";
        NSArray *lrcCmps = [lrc componentsSeparatedByString:@"\n"];
//        NSLog(@"lrc is --%@  lrcCmps--  %@",lrc,lrcCmps);
        //    NSLog(@"%@",lrcCmps);
        //    //加载歌词
        //    NSURL *url = [[NSBundle mainBundle] URLForResource:lrcname withExtension:nil];
        //    NSString *lrc = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        //    NSArray *lrcCmps = [lrc componentsSeparatedByString:@"\n"];
        
        //输出每一行
        for (NSString *lrcCmp in lrcCmps) {
//            NSLogg(@"for lrcCmp---%@",lrcCmp);
            HMLrcLine *line = [[HMLrcLine alloc] init];
            [self.lrcLines addObject:line];
            
            if (![lrcCmp hasPrefix:@"["]) continue;//如果是空行，已经存进去，继续下一行
            
            if ([lrcCmp hasPrefix:@"[ti:"]||[lrcCmp hasPrefix:@"[ar:"]||[lrcCmp hasPrefix:@"[al:"]) {//头部信息，没有时间
                
                NSString *word = [[lrcCmp componentsSeparatedByString:@":"] lastObject];
                line.word = [word substringToIndex:word.length - 1];
            }else{//非头部信息，带时间
                
                NSArray *lrcArray = [lrcCmp componentsSeparatedByString:@"]"] ;
                line.time = [[lrcArray firstObject] substringFromIndex:1];
                line.word = [lrcArray lastObject];
            }
            
            //        NSLog(@"%@---%@",line.time,line.word);
        }
        
    
   
    
        [self.tableView reloadData];
        
   
    if (self.lrcLines.count <= 1) {
        [MBProgressHUD showError:@"好像没有歌词哦~"];
    }
    
}






- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.tableView.frame = CGRectMake(0, self.height*0.1, self.width, self.height*0.7);
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.height * 0.4, 0, self.tableView.height * 0.6, 0);
    
}

- (void)setCurrentTime:(NSTimeInterval)currentTime{
    
    if (currentTime < _currentTime) {
        self.currentIndex = -1;
    }
    
    _currentTime = currentTime;//是整秒数-->字符串变成 00：00.00
    
    int minute = currentTime / 60;
    int second = (int)currentTime % 60;
    int msecond = (currentTime - (int)currentTime) * 100;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d",minute,second,msecond];
    
    
    NSUInteger count = self.lrcLines.count;
    for (int idx = self.currentIndex + 1; idx < count; idx++) {
        
        HMLrcLine *currentLine = self.lrcLines[idx];
        //当前时间
        NSString *currentLineTime = currentLine.time;
        NSString *nextLineTime = nil;
        
        if (idx+1 < count) {
            HMLrcLine *nextLine = self.lrcLines[idx+1];
            nextLineTime = nextLine.time;
        }
    
    if (([currentTimeStr compare:currentLineTime] != NSOrderedAscending)&&([currentTimeStr compare:nextLineTime] == NSOrderedAscending)&&(self.currentIndex !=idx)) {
        
        //刷新tableview
        
        NSArray *reloadRows = @[
                                [NSIndexPath indexPathForRow:self.currentIndex inSection:0],//实际上行的
                                [NSIndexPath indexPathForRow:idx inSection:0]//现在的
                                ];
        self.currentIndex = idx;
        [self.tableView reloadRowsAtIndexPaths:reloadRows withRowAnimation:UITableViewRowAnimationNone];
        //滚动到对应的行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
}

}





#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.lrcLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HMLrcViewCell *cell = [HMLrcViewCell cellWithTableView:tableView];
    
    if (self.lrcLines[indexPath.row]) {
        
    cell.line = self.lrcLines[indexPath.row];
    if (self.currentIndex == indexPath.row) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
//        cell.textSet = YES;
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:15];
//        cell.textSet = NO;
    }
        
    }
        
        
    return cell;
}


#pragma mark - 代理方法


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}


@end
