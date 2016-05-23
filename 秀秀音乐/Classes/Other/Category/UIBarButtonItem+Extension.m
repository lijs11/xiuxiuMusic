//
//  UIBarButtonItem+Extension.m
//  网易新闻瀑布流
//
//  Created by Kenny.li on 16/3/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    if (highImageName) {
        [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    }
    
    //设置尺寸
    button.size = button.currentImage.size;
    //添加方法
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
