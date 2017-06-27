//
//  ViewHeaderGoods.m
//  JuanZen
//
//  Created by simple on 17/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "ViewHeaderGoods.h"
#import "CWStarRateView.h"

@interface ViewHeaderGoods()
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIImageView *ivImg;
@property (nonatomic, strong) UIImageView *ivPhoto;
@property (nonatomic, strong) UILabel *lbName;
@property (nonatomic, strong) UILabel *lbComment;
@property (strong, nonatomic) CWStarRateView *starRateView;

@end
@implementation ViewHeaderGoods

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14];
        _lbTitle.numberOfLines = 0;
        _lbTitle.textColor = [UIColor grayColor];
        [self addSubview:_lbTitle];

        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.userInteractionEnabled = YES;
        [_ivImg sd_setImageWithURL:[NSURL URLWithString:@"http://image.elegantliving.ceconline.com/320000/320100/20110815_03_52.jpg"]];
        [self addSubview:_ivImg];
        
        _ivPhoto = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivPhoto.layer.cornerRadius = 20.f;
        _ivPhoto.layer.masksToBounds = YES;
        _ivPhoto.layer.borderColor = RGB3(221).CGColor;
        _ivPhoto.layer.borderWidth = 4.f;
        _ivPhoto.clipsToBounds = YES;
        [_ivPhoto sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1074344932,2251510853&fm=26&gp=0.jpg"]];
        [self addSubview:_ivPhoto];
        
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:14];
        _lbName.textColor = [UIColor grayColor];
        [self addSubview:_lbName];
        
        _lbComment = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.text = @"评价";
        _lbComment.textColor = [UIColor grayColor];
        [self addSubview:_lbComment];
        
        _starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(ScreenWidth - 130, 0, 120, 20) numberOfStars:5];
        [self addSubview:_starRateView];
    }
    return self;
}

- (void)updateData{
    self.lbTitle.text = @"小孩子衣服九成新";
    self.lbName.text = @"茶宝儿";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    CGRect r = self.lbTitle.frame;
    r.size.width = ScreenWidth - 20;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = 15;
    self.lbTitle.frame = r;
    
    r = self.ivImg.frame;
    r.size.width = ScreenWidth - 20;
    r.size.height = r.size.width / 2.3;
    r.origin.x = 10;
    r.origin.y = self.lbTitle.mj_y + self.lbTitle.mj_h + 10;
    self.ivImg.frame = r;
    
    r = self.ivPhoto.frame;
    r.size.width = 40;
    r.size.height = r.size.width;
    r.origin.x = self.lbTitle.mj_x;
    r.origin.y = self.ivImg.mj_y + self.ivImg.mj_h + 10;
    self.ivPhoto.frame = r;
    
    size = [self.lbName sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbName.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = self.ivPhoto.mj_x + self.ivPhoto.mj_w + 5;
    r.origin.y = self.ivPhoto.mj_y + (self.ivPhoto.mj_h - r.size.height)/2.0;
    self.lbName.frame = r;
    
    r = self.starRateView.frame;
    r.origin.y = self.ivPhoto.mj_y + (self.ivPhoto.mj_h - r.size.height)/2.0;
    self.starRateView.frame = r;
    
    size = [self.lbComment sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbComment.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = self.starRateView.mj_x - r.size.width - 10;
    r.origin.y = self.ivPhoto.mj_y + (self.ivPhoto.mj_h - r.size.height)/2.0;
    self.lbComment.frame = r;
}

+ (CGFloat)calHeight{
    CGFloat height = 85;
    UILabel *lb = [[UILabel alloc]init];
    lb.font = [UIFont systemFontOfSize:14];
    lb.text = @"小孩子衣服九成新";
    lb.numberOfLines = 0;
    CGSize size = [lb sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    
    height += size.height;
    height += (ScreenWidth - 20)/2.3;
    
    
    return height;
}
@end
