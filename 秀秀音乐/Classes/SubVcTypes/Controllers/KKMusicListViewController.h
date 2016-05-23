//
//  KKMusicListViewController.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKBaseViewController.h"

@interface KKMusicListViewController : KKBaseViewController

@property (nonatomic, copy) NSString *msg_id;

@property (nonatomic, copy) NSString *from; //标识从哪个界面push来的
@property (nonatomic, copy) NSString *pic_url;//用来接收从排行传过来的图片

@end
