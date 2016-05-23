//
//  KKNetWorkTool.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/3.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKNetWorkTool.h"
#import "AFNetworking.h"

@implementation KKNetWorkTool

+ (void)JsonDataWithUrl:(NSString *)url success:(void(^)(id data))success fail:(void(^)())fail view:(UIView *)view  parameters:(NSDictionary *)parameters{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <= 0) {
            MBProgressHUD *mb1 = [MBProgressHUD showHUDAddedTo:view animated:YES];
            mb1.mode = MBProgressHUDModeText;
            mb1.labelText = @"网络你要去哪儿？";
            [mb1 hide:YES afterDelay:1];
            
        } else {
            MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
            mb.mode = MBProgressHUDModeIndeterminate;
            mb.labelText = @"拼命请求中";
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject) {
                    [mb removeFromSuperview];
                    if (success) {
                        success(responseObject);
                    }
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [mb removeFromSuperview];
                if (fail) {
                    fail(error);
                }
            }];
        }
    }];
    
}


#pragma mark - 默认只返回一个
static id _instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

/**单例*/
+ (instancetype)sharedNetWorkTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
    
}

//拷贝默认只返回一个。Zone是内存空间
- (id)copyWithZone:(NSZone *)zone{
    
    return _instance;//instance之前肯定创建好的，有对象才能拷贝，所以返回单例。要准守NSCopying
}




@end
