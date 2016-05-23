//
//  KKHeaderView.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/10.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKHeaderView.h"

@interface KKHeaderView()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *lineView;
@end

@implementation KKHeaderView

+ (id)shareHeaderView:(UITableView *)tableView{
    
   NSString *ID = @"headerViewID";
    
    KKHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:ID];
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]){
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.titleLabel];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor redColor];
        [self addSubview:self.lineView];
        
    }
    return  self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(16, 2, self.frame.size.width, 20);
 
    self.lineView.frame = CGRectMake(8, 5, 2, 13);
    
}

- (void)setSectionTitle:(NSString *)sectionTitle{
    
    _sectionTitle = sectionTitle;
    
    self.titleLabel.text = sectionTitle;
    
    
}




@end
