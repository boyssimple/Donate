//
//  categoryCollectionViewCell.h
//  Donate
//
//  Created by yibyi on 2017/6/23.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainModel;

@interface categoryCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) MainModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
