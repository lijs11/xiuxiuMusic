//
//  HMLrcViewCell.m
//  音频和音效01
//
//  Created by Kenny.li on 16/3/26.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "HMLrcViewCell.h"
#import "HMLrcLine.h"

@interface HMLrcViewCell()
//@property (nonatomic,strong)UIView *cover;
@end

@implementation HMLrcViewCell
//
//- (UIView *)cover{
//    if (_cover == nil) {
//        self.cover = [[UIView alloc] init];
//        self.cover.backgroundColor = [UIColor redColor];
//        self.cover.alpha = 0.5;
//        self.cover.frame = self.bounds;
//        self.cover.hidden = YES;
//        [self addSubview:self.cover];
//    }
//    return _cover;
//}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"lrc";
    HMLrcViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[HMLrcViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.numberOfLines = 0;
        self.textLabel.textColor = [UIColor pinkLipstickColor];
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}


- (void)setLine:(HMLrcLine *)line{
    _line = line;
    self.textLabel.text = line.word;
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.textLabel.frame = self.bounds;
    
//    if (self.textSet ==YES) {
//        
//        self.cover.hidden = NO;
//        self.cover.x = - self.width;
//        [UIView animateWithDuration:1.5 animations:^{
//             self.cover.x = 0;
//            
//        }];
//        
//    }else {
//        
//         [self.cover removeFromSuperview];
//    }
    
}



@end
