//
//  KKNewCDViewCell.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKNewCDViewCell.h"
#import "UIImageView+WebCache.h"
@interface KKNewCDViewCell()
@property (weak, nonatomic) IBOutlet UILabel *song;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UIImageView *pic;

@end

@implementation KKNewCDViewCell

- (void)setModel:(KKNewCDModel *)model{
    
    _model = model;
    
    //网落图片太大， 在这里为了防止内存警告，每次请求清除一下内存
    [[SDImageCache sharedImageCache] clearMemory];
    
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"default.jpg"]];

    self.song.text = [model.desc componentsSeparatedByString:@"-"][1];
    self.singer.text = [model.desc componentsSeparatedByString:@"-"][0];
    
}

@end
