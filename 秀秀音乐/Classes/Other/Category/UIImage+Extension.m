//
//  UIImage+Extension.m
//  网易新闻瀑布流
//
//  Created by Kenny.li on 16/3/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color{
    
    CGFloat imageW = 100;
    CGFloat imageH = 100;
    //1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    //2.画半圆
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    //3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}
@end
