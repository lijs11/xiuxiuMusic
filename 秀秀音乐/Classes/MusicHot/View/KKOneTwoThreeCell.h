//
//  KKOneTwoThreeCell.h
//  秀秀音乐
//
//  Created by Kenny.li on 16/5/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKOneTwoThreeCell;
@protocol KKOneTwoThreeCellDelegate <NSObject>

@optional

- (void)oneTwoThreeCell:(KKOneTwoThreeCell *)oneTwoThreeCell TapWithImageNum:(NSInteger)row;


@end





@interface KKOneTwoThreeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UILabel *label3;




- (void)configureCell:(NSMutableArray *)dataArr;

@property (nonatomic,assign) NSInteger indexPath;//接收此View所在cell的行

@property (nonatomic,assign) id <KKOneTwoThreeCellDelegate> delegate;

@end
