//
//  KKResultCell.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/4.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKSearchResult;

@interface KKResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *songname;
@property (weak, nonatomic) IBOutlet UILabel *singgername;
@property (weak, nonatomic) IBOutlet UILabel *inLove;


@property (nonatomic, strong) KKSearchResult *result;


@end
