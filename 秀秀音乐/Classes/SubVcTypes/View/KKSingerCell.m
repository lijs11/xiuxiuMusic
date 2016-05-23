//
//  KKSingerCell.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKSingerCell.h"

@interface KKSingerCell()
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *singer;

@end


@implementation KKSingerCell

- (void)setModel:(KKSingerModel *)model{
    _model = model;
    
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    self.singer.text = model.singer_name;
    
}




@end
