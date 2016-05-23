//
//  HMLrcViewCell.h
//  音频和音效01
//
//  Created by Kenny.li on 16/3/26.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMLrcLine;
@interface HMLrcViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)HMLrcLine *line;

/**设置文字逐渐变颜色*/
@property(nonatomic,getter=isTextSeting) BOOL textSet;

@end
