//
//  ViewHeaderGoods.m
//  JuanZen
//
//  Created by simple on 17/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "ViewHeaderDonate.h"
#import "CWStarRateView.h"

@interface ViewHeaderDonate()
@property (nonatomic, strong) UIImageView *ivPhoto;
@property (nonatomic, strong) UILabel *lbName;
@property (nonatomic, strong) UILabel *lbAddress;
@property (nonatomic, strong) UILabel *lbComment;
@property (strong, nonatomic) CWStarRateView *starRateView;
@property (nonatomic, strong) UIView   *vLine;

@end
@implementation ViewHeaderDonate

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _ivPhoto = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivPhoto.layer.cornerRadius = 30.f;
        _ivPhoto.layer.masksToBounds = YES;
        _ivPhoto.layer.borderColor = RGB3(221).CGColor;
        _ivPhoto.layer.borderWidth = 4.f;
        _ivPhoto.clipsToBounds = YES;
        [_ivPhoto sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1074344932,2251510853&fm=26&gp=0.jpg"]];
        [self addSubview:_ivPhoto];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:14];
        _lbName.textAlignment = NSTextAlignmentCenter;
        _lbName.textColor = [UIColor grayColor];
        [self addSubview:_lbName];
        
        _lbAddress = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAddress.font = [UIFont systemFontOfSize:11];
        _lbAddress.numberOfLines = 0;
        _lbAddress.textAlignment = NSTextAlignmentCenter;
        _lbAddress.textColor = [UIColor grayColor];
        [self addSubview:_lbAddress];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(241);
        [self addSubview:_vLine];
        
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

- (void)updateData:(NSDictionary*)data{
    self.lbAddress.text = [[data objectForKey:@"info"] objectForKey:@"address"];
    self.lbName.text = [[data objectForKey:@"info"] objectForKey:@"user_name"];
    NSString *url = [[data objectForKey:@"info"] objectForKey:@"head_graphic"];
    if(url && ![url isKindOfClass:[NSNull class]]){
        [self.ivPhoto sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    self.starRateView.scorePercent = [[[data objectForKey:@"info"] objectForKey:@"evaluate"]floatValue];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect r = self.ivPhoto.frame;
    r.size.width = 60;
    r.size.height = r.size.width;
    r.origin.x = (ScreenWidth - r.size.width )/2.0;
    r.origin.y = 15;
    self.ivPhoto.frame = r;
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    r = self.lbName.frame;
    r.size.width = ScreenWidth - 20;
    r.size.height = size.height;
    r.origin.x = (ScreenWidth - r.size.width )/2.0;
    r.origin.y = self.ivPhoto.mj_y + self.ivPhoto.mj_h + 3;
    self.lbName.frame = r;
    
    size = [self.lbAddress sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    r = self.lbAddress.frame;
    r.size.width = ScreenWidth - 20;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = self.lbName.mj_y + self.lbName.mj_h + 10;
    self.lbAddress.frame = r;
    
    r = self.vLine.frame;
    r.size.width = ScreenWidth;
    r.size.height = 10;
    r.origin.x = 0;
    r.origin.y = self.lbAddress.mj_y + self.lbAddress.mj_h + 20;
    self.vLine.frame = r;
    
    
    r = self.starRateView.frame;
    r.origin.y = self.vLine.mj_y + self.vLine.mj_h + 10;
    self.starRateView.frame = r;
    
    size = [self.lbComment sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbComment.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = self.starRateView.mj_y;
    self.lbComment.frame = r;
}

+ (CGFloat)calHeight{
    CGFloat height = 158;
    UILabel *lb = [[UILabel alloc]init];
    lb.font = [UIFont systemFontOfSize:11];
    lb.text = @"重庆市渝中区大坪长江二路156号";
    lb.numberOfLines = 0;
    CGSize size = [lb sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    
    height += size.height;
    
    UILabel *lbName = [[UILabel alloc]init];
    lbName.font = [UIFont systemFontOfSize:14];
    lbName.text = @"茶宝儿";
    lbName.numberOfLines = 0;
    size = [lbName sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    height += size.height;
    
    return height;
}
@end
