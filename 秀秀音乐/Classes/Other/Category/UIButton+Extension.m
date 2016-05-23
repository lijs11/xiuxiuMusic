//
//  UIButton+Extension.m
//  团购HD-KK
//
//  Created by Kenny.li on 16/4/12.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)


#pragma mark - image

- (void)setImage:(NSString *)image{
    
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

- (NSString *)image{
    
    return nil;
}

- (void)setHighlightedImage:(NSString *)highlightedImage{
    
    [self setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
}

- (NSString *)highlightedImage{
    
    return nil;
}


- (void)setSelectedImage:(NSString *)selectedImage{
    
    [self setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
}

- (NSString *)selectedImage{
    
    return nil;
}

#pragma mark - bgImage
- (void)setBgImage:(NSString *)bgImage{
    
    [self setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
}

- (NSString *)bgImage{
    
    return nil;
}

- (void)setHighlightedbgImage:(NSString *)highlightedbgImage{
    
    [self setBackgroundImage:[UIImage imageNamed:highlightedbgImage] forState:UIControlStateHighlighted];
}

- (NSString *)highlightedbgImage{
    
    return nil;
}


- (void)setSelectedbgImage:(NSString *)selectedbgImage{
    
    [self setBackgroundImage:[UIImage imageNamed:selectedbgImage] forState:UIControlStateSelected];
}

- (NSString *)selectedbgImage{
    
    return nil;
}

#pragma mark - title
- (void)setTitle:(NSString *)title{
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)title{
    
    return nil;
}

- (void)setHighlightedTitle:(NSString *)highlightedTitle{
    
    [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString *)highlightedTitle{
    
    return nil;
}


- (void)setSelectedTitle:(NSString *)selectedTitle{
    
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

- (NSString *)selectedTitle{
    
    return nil;
}

#pragma mark - titleColor
- (void)setTitleColor:(UIColor *)titleColor{
    
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (UIColor *)titleColor{
    
    return nil;
}

- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor{
    
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)highlightedTitleColor{
    
    return nil;
}


- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (UIColor *)selectedTitleColor{
    
    return nil;
}


@end
