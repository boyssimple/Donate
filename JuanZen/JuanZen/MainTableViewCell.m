//
//  MainTableViewCell.m
//  Donate
//
//  Created by yibyi on 2017/6/23.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "MainTableViewCell.h"
#import "MainModel.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MainModel *)model {
    _model = model;
    [self.leftimgView sd_setImageWithURL:[NSURL URLWithString:[IMAGEURL stringByAppendingString:model.type_img]]];
    self.rightLabel.text = model.type_title;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
