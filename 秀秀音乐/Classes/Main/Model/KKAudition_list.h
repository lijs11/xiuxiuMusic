//
//  KKAudition_list.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/3.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKAudition_list: NSObject
@property (nonatomic,strong)NSNumber *bitRate;
@property (nonatomic,copy) NSString *duration;
@property (nonatomic,copy) NSString *size;
@property (nonatomic,copy)NSString *suffix;
@property (nonatomic,strong)NSNumber *type;
@property (nonatomic,copy) NSString *typeDescription;
@property (nonatomic,copy) NSString *url;
@end
