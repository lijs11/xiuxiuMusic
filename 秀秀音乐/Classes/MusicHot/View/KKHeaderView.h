//
//  KKHeaderView.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/10.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKHeaderView : UITableViewHeaderFooterView

@property (nonatomic,copy) NSString *sectionTitle;

+ (id)shareHeaderView:(UITableView *)tableView;

@end
