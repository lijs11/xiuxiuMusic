//
//  BottomPlayView.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/5.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKSearchResult.h"
@interface BottomPlayView : UIViewController

+ (BottomPlayView *)shareBottomPlayView;

@property (nonatomic,strong)UINavigationController *navigationVc;

@property (nonatomic,assign,getter=isPlaying) BOOL playing;

@property (nonatomic,strong)KKSearchResult *result;

@end
