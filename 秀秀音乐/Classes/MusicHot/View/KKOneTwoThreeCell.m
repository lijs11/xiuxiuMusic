//
//  KKOneTwoThreeCell.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKOneTwoThreeCell.h"
#import "KKMusicHotModel.h"
#import "KKMusicListViewController.h"

@interface KKOneTwoThreeCell()
- (IBAction)imageBtn1:(UIButton *)sender;

- (IBAction)imageBtn2:(UIButton *)sender;
- (IBAction)imageBtn3:(UIButton *)sender;

@end



@implementation KKOneTwoThreeCell


- (void)configureCell:(NSMutableArray *)dataArr{
    
    self.label1.text = ((KKMusicHotModel *)dataArr[0]).desc;
    self.label2.text = ((KKMusicHotModel *)dataArr[1]).desc;
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:((KKMusicHotModel *)dataArr[0]).pic_url] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    [self.image2 sd_setImageWithURL:[NSURL URLWithString:((KKMusicHotModel *)dataArr[1]).pic_url] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    
        
    self.label3.text = ((KKMusicHotModel *)dataArr[2]).desc;    
    
    [self.image3 sd_setImageWithURL:[NSURL URLWithString:((KKMusicHotModel *)dataArr[2]).pic_url] placeholderImage:[UIImage imageNamed:@"default.jpg"]];

    
}



- (IBAction)imageBtn1:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(oneTwoThreeCell:TapWithImageNum:)]) {
        [self.delegate oneTwoThreeCell:self TapWithImageNum:0];
    }
    
}

- (IBAction)imageBtn2:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(oneTwoThreeCell:TapWithImageNum:)]) {
        [self.delegate oneTwoThreeCell:self TapWithImageNum:1];
    }
    
}

- (IBAction)imageBtn3:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(oneTwoThreeCell:TapWithImageNum:)]) {
        [self.delegate oneTwoThreeCell:self TapWithImageNum:2];
    }
    
}




@end
