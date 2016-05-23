//
//  KKSearchParam.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/3.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKSearchParam : NSObject


/**要搜索的文字*/
@property (nonatomic,copy) NSString *q;
/**要返回的页码？*/
@property (nonatomic,strong) NSNumber *page;
/**要返回的该页个数？*/
@property (nonatomic,strong) NSNumber *size;

@end
