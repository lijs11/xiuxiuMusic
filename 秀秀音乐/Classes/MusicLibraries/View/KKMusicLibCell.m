//
//  KKMusicLibCell.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMusicLibCell.h"


@interface KKMusicLibCell()
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end


@implementation KKMusicLibCell


- (void)setModel:(KKMusicLibModel *)model{
    
    _model = model;
    
    self.Image.image = [UIImage imageNamed:model.typeImageName];
    self.title.text = model.typeName;
    
}



@end
