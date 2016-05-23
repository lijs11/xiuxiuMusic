//
//  UIButton+Extension.h
//  团购HD-KK
//
//  Created by Kenny.li on 16/4/12.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *highlightedImage;
@property (nonatomic,copy) NSString *selectedImage;


@property (nonatomic,copy) NSString *bgImage;
@property (nonatomic,copy) NSString *highlightedbgImage;
@property (nonatomic,copy) NSString *selectedbgImage;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *highlightedTitle;
@property (nonatomic,copy) NSString *selectedTitle;

@property (nonatomic,copy) UIColor *titleColor;
@property (nonatomic,copy) UIColor *highlightedTitleColor;
@property (nonatomic,copy) UIColor *selectedTitleColor;

@end
