//
//  HMLrcView.h
//  音频和音效01
//
//  Created by Kenny.li on 16/3/26.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "DRNRealTimeBlurView.h"
#import "KKSearchResult.h"
@interface HMLrcView : DRNRealTimeBlurView

@property (nonatomic,copy) NSString *lrcname;
@property (nonatomic,assign) NSTimeInterval currentTime;
@property (nonatomic,strong)KKSearchResult *result;
@end
