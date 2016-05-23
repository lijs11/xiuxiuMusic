//
//  KKResultCell.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/4.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKResultCell.h"
#import "KKSearchResult.h"
#import "KKMusicListSongModel.h"
@interface KKResultCell()


@end

@implementation KKResultCell

- (void)setResult:(KKSearchResult *)result{
    _result = result;
    
    
    self.singgername.text = result.singer_name;
    self.inLove.text = [self translateNumb:result.pick_count];
    
    
}










- (NSString *)translateNumb:(NSUInteger)numb{
    
    NSString *str;
    if (numb > 10000) {
        numb = numb / 1000;
        str = [NSString stringWithFormat:@"%ld万",(long)numb];
    }else{
        
        str = [NSString stringWithFormat:@"%ld",(long)numb];
    }
    
    return str;
}


@end
