//
//  CellDownSelection.m
//  JuanZen
//
//  Created by zhouMR on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "CellWantGet.h"

@interface CellWantGet()
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIView *vBg;
@property (nonatomic, strong) UILabel *lbDonate;
@property (nonatomic, strong) UILabel *lbDonateText;
@property (nonatomic, strong) UILabel *lbContact;
@property (nonatomic, strong) UILabel *lbContactText;
@property (nonatomic, strong) UILabel *lbAddress;
@property (nonatomic, strong) UILabel *lbAddressText;
@end
@implementation CellWantGet

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14];
        _lbTitle.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lbTitle];
        
        _vBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vBg.backgroundColor = [UIColor whiteColor];
        _vBg.layer.borderColor = RGB3(229).CGColor;
        _vBg.layer.borderWidth = 1;
        _vBg.layer.cornerRadius = 3;
        _vBg.layer.masksToBounds = YES;
        [self.contentView addSubview:_vBg];
        
        _lbDonate = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbDonate.font = [UIFont systemFontOfSize:14];
        _lbDonate.text = @"捐赠者：";
        _lbDonate.textColor = [UIColor grayColor];
        [_vBg addSubview:_lbDonate];
        
        _lbDonateText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbDonateText.font = [UIFont systemFontOfSize:14];
        _lbDonateText.textColor = [UIColor grayColor];
        [_vBg addSubview:_lbDonateText];
        
        _lbContact = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbContact.font = [UIFont systemFontOfSize:14];
        _lbContact.text = @"联系电话：";
        _lbContact.textColor = [UIColor grayColor];
        [_vBg addSubview:_lbContact];
        
        _lbContactText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbContactText.font = [UIFont systemFontOfSize:14];
        _lbContactText.textColor = [UIColor grayColor];
        [_vBg addSubview:_lbContactText];
        
        _lbAddress = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAddress.font = [UIFont systemFontOfSize:14];
        _lbAddress.text = @"联系地址：";
        _lbAddress.textColor = [UIColor grayColor];
        [_vBg addSubview:_lbAddress];
        
        _lbAddressText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAddressText.font = [UIFont systemFontOfSize:14];
        _lbAddressText.textColor = [UIColor grayColor];
        [_vBg addSubview:_lbAddressText];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.lbTitle.text = _title;
}

- (void)updateData{
    self.lbDonateText.text = @"茶宝儿";
    self.lbContactText.text = @"15890298192";
    self.lbAddressText.text = @"重庆市渝中区大坪长江二路159号";
}

- (void)setType:(NSInteger)type{
    _type = type;
    
    self.lbTitle.hidden = YES;
    self.vBg.hidden = YES;
    self.lbDonate.hidden = YES;
    self.lbDonateText.hidden = YES;
    self.lbContact.hidden = YES;
    self.lbContactText.hidden = YES;
    self.lbAddress.hidden = YES;
    self.lbAddressText.hidden = YES;
    
    if (_type == 0) {
        self.lbTitle.hidden = NO;
    }else if(_type == 1){
        self.vBg.hidden = NO;
        self.lbDonate.hidden = NO;
        self.lbDonateText.hidden = NO;
        self.lbContact.hidden = NO;
        self.lbContactText.hidden = NO;
        self.lbAddress.hidden = NO;
        self.lbAddressText.hidden = NO;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    CGRect r = self.lbTitle.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.lbTitle.frame = r;
    
    
    size = [self.lbDonate sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbDonate.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = 15;
    self.lbDonate.frame = r;
    
    size = [self.lbDonateText sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbDonateText.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = self.lbDonate.mj_x + self.lbDonate.mj_w;
    r.origin.y = self.lbDonate.mj_y;
    self.lbDonateText.frame = r;
    

    size = [self.lbContact sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbContact.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = self.lbDonate.mj_x;
    r.origin.y = self.lbDonate.mj_y + self.lbDonate.mj_h + 10;
    self.lbContact.frame = r;
    
    size = [self.lbContactText sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbContactText.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = self.lbContact.mj_x + self.lbContact.mj_w;
    r.origin.y = self.lbContact.mj_y;
    self.lbContactText.frame = r;
    
    
    size = [self.lbAddress sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbAddress.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = self.lbDonate.mj_x;
    r.origin.y = self.lbContact.mj_y + self.lbContact.mj_h + 10;
    self.lbAddress.frame = r;
    
    size = [self.lbAddressText sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbAddressText.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x =  self.lbAddress.mj_x + self.lbAddress.mj_w;
    r.origin.y = self.lbAddress.mj_y;
    self.lbAddressText.frame = r;
    
    r = self.vBg.frame;
    r.size.width = ScreenWidth - 20;
    r.size.height = self.lbAddressText.mj_y + self.lbAddressText.mj_h + self.lbDonate.mj_y;
    r.origin.x = 10;
    r.origin.y = 0;
    self.vBg.frame = r;
}

+ (CGFloat)calHeight:(NSInteger)type{
    if (type == 0) {
        return 40;
    }
    return 107;
}

@end
