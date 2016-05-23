//
//  KKSongsListCell.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKSongsListCell.h"

@implementation KKSongsListCell


- (void)setModel:(KKMusicHotModel *)model {
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    self.title.text = model.name;
    self.subtitle.text = model.desc;
}


@end
