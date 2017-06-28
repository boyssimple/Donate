//
//  CellDownSelection.m
//  JuanZen
//
//  Created by zhouMR on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "CellDonateProfile.h"

@interface CellDonateProfile()
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UIButton *btnAdd;
@end
@implementation CellDonateProfile

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14];
        _lbTitle.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lbTitle];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(241);
        [self.contentView addSubview:_vLine];
        
        _btnAdd = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnAdd.layer.cornerRadius = 3;
        _btnAdd.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnAdd addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnAdd];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont systemFontOfSize:14];
        _lbText.hidden = YES;
        _lbText.text = @"累计捐赠10件";
        _lbText.userInteractionEnabled = YES;
        _lbText.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lbText];
    }
    return self;
}

- (void)uploadClick{
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.lbTitle.text = _title;
}

- (void)setType:(NSInteger)type{
    _type = type;
    
    self.lbTitle.hidden = YES;
    self.lbText.hidden = YES;
    self.btnAdd.hidden = YES;
    self.vLine.hidden = YES;
    if (_type == 0) {
        self.lbTitle.hidden = NO;
        self.vLine.hidden = NO;
    }else if(_type == 1){
        self.btnAdd.hidden = NO;
        self.lbText.hidden = NO;
        self.btnAdd.backgroundColor = RGB(64, 65, 70);
        self.btnAdd.layer.borderWidth = 0;
        [self.btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.btnAdd.hidden = NO;
        self.lbText.hidden = NO;
        self.btnAdd.backgroundColor = [UIColor clearColor];
        self.btnAdd.layer.borderWidth = 0.5;
        self.btnAdd.layer.borderColor = RGB(64,65,70).CGColor;
        [self.btnAdd setTitleColor:RGB(64, 65, 70) forState:UIControlStateNormal];
    }
    
    
    if (_type != 0) {
        [self.btnAdd setTitle:self.title forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbTitle.frame;
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.lbTitle.frame = r;
    
    r = self.vLine.frame;
    r.size.width = ScreenWidth - 10;
    r.size.height = 0.5;
    r.origin.x = 10;
    r.origin.y = self.mj_h - r.size.height;
    self.vLine.frame = r;
    
    r = self.btnAdd.frame;
    r.size.width = 90;
    r.size.height = 40;
    r.origin.x = self.lbTitle.mj_x;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.btnAdd.frame = r;
    
    size = [self.lbText sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbText.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = self.btnAdd.mj_x + self.btnAdd.mj_w + 30;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.lbText.frame = r;
}

+ (CGFloat)calHeight:(NSInteger)type{
    if (type == 0) {
        return 40;
    }
    return 60;
}

@end
