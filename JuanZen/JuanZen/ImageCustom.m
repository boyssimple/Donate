//
//  ImageCustom.m
//  JuanZen
//
//  Created by zhouMR on 2017/6/29.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "ImageCustom.h"

@implementation ImageCustom

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.layer.cornerRadius = 3;
        _ivImg.layer.borderWidth = 0.5;
        _ivImg.layer.borderColor = RGB3(230).CGColor;
        _ivImg.clipsToBounds = YES;
        _ivImg.layer.masksToBounds = YES;
        [self addSubview:_ivImg];
        
        _btnDelete = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnDelete setImage:[UIImage imageNamed:@"ImgDelete"] forState:UIControlStateNormal];
        [_btnDelete addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnDelete];
    }
    return self;
}

- (void)deleteClick{
    if ([self.delegate respondsToSelector:@selector(imageDeleteClick:)]) {
        [self.delegate imageDeleteClick:self.index];
    }
}

- (void)layoutSubviews{
    CGRect r = self.ivImg.frame;
    r.origin.x = 0;
    r.origin.y = 7;
    r.size.width = self.mj_w - 7;
    r.size.height = self.mj_h - 7;
    self.ivImg.frame = r;
    
    r = self.btnDelete.frame;
    r.size.width = 15;
    r.size.height = r.size.width;
    r.origin.x = self.ivImg.mj_x + self.ivImg.mj_w - (r.size.width - 7);
    r.origin.y = self.ivImg.mj_y - 7;
    self.btnDelete.frame = r;
}

@end
