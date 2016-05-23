//
//  KKWebPageViewController.m
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKWebPageViewController.h"
#import "BottomPlayView.h"
@interface KKWebPageViewController ()

@property (nonatomic, strong) UIWebView *webView;



@end

@implementation KKWebPageViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    BottomPlayView *bottomPV = [BottomPlayView shareBottomPlayView];
    [self.view addSubview:bottomPV.view];
    
    
}



- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    
    self.navigationItem.title = self.NVTitle;
    
    UIBarButtonItem *leftBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack:)];
    
    self.navigationItem.leftBarButtonItem = leftBack;
    
    
    [self setWebView];
    
    
    
}

- (void)setWebView{
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    
    if (self.urlString) {
        NSURL *url = [[NSURL alloc] initWithString:self.urlString];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
    
    
}





- (void)handleBack:(UIBarButtonItem *)item {
    [self.NavigationCC popViewControllerAnimated:YES];
}

@end
