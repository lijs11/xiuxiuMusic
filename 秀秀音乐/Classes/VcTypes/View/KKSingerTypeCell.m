//
//  KKSingerTypeCell.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKSingerTypeCell.h"
#import "UIImageView+WebCache.h"
@interface KKSingerTypeCell()
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *singer;

@end

@implementation KKSingerTypeCell

- (void)setModel:(KKSingerTypeModel *)model{
    
    _model = model;
    
    self.singer.text = model.title;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
}


- (void)setSongModel:(KKSongModel *)songModel{
    
    _songModel = songModel;
    
    self.singer.text = songModel.songlist_name;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:songModel.pic_url_240_200] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
}




@end
