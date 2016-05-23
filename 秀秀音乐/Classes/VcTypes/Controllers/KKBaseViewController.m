//
//  KKBaseViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/8.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKBaseViewController.h"

@interface KKBaseViewController ()

@end

@implementation KKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = self.NvTitle;
    
    UIBarButtonItem *leftBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack:)];
    
    self.navigationItem.leftBarButtonItem = leftBack;
    
}

#pragma mark action
- (void)handleBack:(UIBarButtonItem *)item {
    [self.navigationCC popViewControllerAnimated:YES];
}



@end
