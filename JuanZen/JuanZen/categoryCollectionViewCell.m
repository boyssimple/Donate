//
//  categoryCollectionViewCell.m
//  Donate
//
//  Created by yibyi on 2017/6/23.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "categoryCollectionViewCell.h"
#import "MainModel.h"
@implementation categoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setModel:(MainModel *)model {
    _model = model;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:[IMAGEURL stringByAppendingString:model.type_img]]];
    self.nameLabel.text = model.type_title;
    
}

@end
