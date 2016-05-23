//
//  KKSingerTypeCell.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKSingerTypeModel.h"
#import "KKSongModel.h"
@interface KKSingerTypeCell : UICollectionViewCell
@property (nonatomic, strong) KKSingerTypeModel *model;
@property (nonatomic, strong) KKSongModel *songModel;


@end
