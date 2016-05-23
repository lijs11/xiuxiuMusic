//
//  JokeModel.h
//  FMLesson
//
//  Created by caizheyong on 16/2/24.
//  Copyright (c) 2016年 xiaocaicai111. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokeModel : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *duration;
@property (nonatomic, copy)NSString *play_num;
@property (nonatomic, copy)NSString *audio_64_url;
@property (nonatomic)NSInteger totleLength; //存储文件的总大小
@end
