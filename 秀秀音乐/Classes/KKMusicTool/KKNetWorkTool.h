//
//  KKNetWorkTool.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/3.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKNetWorkTool : NSObject
+ (instancetype)sharedNetWorkTool;

+ (void)JsonDataWithUrl:(NSString *)url success:(void(^)(id data))success fail:(void(^)())fail view:(UIView *)view  parameters:(NSDictionary *)parameters;

@end
