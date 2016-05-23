//
//  KKMusicWeekCell.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMusicWeekCell.h"
#import "KKMusicWeekSongListModel.h"
#import "UIImageView+WebCache.h"

@interface KKMusicWeekCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel2;
@property (weak, nonatomic) IBOutlet UILabel *subLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *pic;

@end


@implementation KKMusicWeekCell



- (void)setModel:(KKMusicWeekModel *)model{
    
    _model = model;
    
    self.title.text = model.title;
    self.subLabel.text = model.songlist[0][@"songName"];
    self.subLabel2.text = model.songlist[1][@"songName"];
    self.subLabel3.text = model.songlist[2][@"songName"];

    [[SDImageCache sharedImageCache] cleanDisk];
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    
   
    
}



@end
