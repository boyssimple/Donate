//
//  CollectionViewCell.m
//  JuanZen
//
//  Created by zhouMR on 2017/6/28.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _ivBg = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_ivBg];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont systemFontOfSize:14];
        _lbText.textColor = [UIColor whiteColor];
        _lbText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lbText];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect  r = self.ivBg.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = self.mj_w;
    r.size.height = self.mj_h;
    self.ivBg.frame = r;
    
    r = self.lbText.frame;
    r.size.width = self.mj_w;
    r.size.height = 15;
    r.origin.x = 0;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.lbText.frame = r;
}
@end
