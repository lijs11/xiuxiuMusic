//
//  KKMusicHotCell.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface KKMusicHotCell : UITableViewCell<SDCycleScrollViewDelegate>

- (void)configureCycleImage:(NSMutableArray *)imageArr;
@property (nonatomic, copy) void(^currentIndex)(NSInteger index);

@end
