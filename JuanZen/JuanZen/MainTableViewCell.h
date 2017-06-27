//
//  MainTableViewCell.h
//  Donate
//
//  Created by yibyi on 2017/6/23.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainModel;

@interface MainTableViewCell : UITableViewCell
@property (nonatomic, strong) MainModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *leftimgView;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

@end
