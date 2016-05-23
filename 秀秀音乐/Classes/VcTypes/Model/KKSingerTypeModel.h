//
//  KKSingerTypeModel.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKSingerTypeModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *title, *details;
@property (nonatomic, copy) NSString *pic_url, *time;
@property (nonatomic, strong) NSNumber *count;
@end
