//
//  KKCollectionHeaderView.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKCollectionHeaderView.h"

@implementation KKCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.sectionTitle];
    }
    return self;
}
- (UILabel *)sectionTitle {
    if (!_sectionTitle) {
        self.sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width, 35)];
        _sectionTitle.font = [UIFont systemFontOfSize:18];
    }
    return _sectionTitle;
}

@end
