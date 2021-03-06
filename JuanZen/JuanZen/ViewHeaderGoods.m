//
//  ViewHeaderGoods.m
//  JuanZen
//
//  Created by simple on 17/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "ViewHeaderGoods.h"
#import "CWStarRateView.h"
#import "SDCycleScrollView.h"

@interface ViewHeaderGoods()
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIImageView *ivPhoto;
@property (nonatomic, strong) UILabel *lbName;
@property (nonatomic, strong) UILabel *lbComment;
@property (strong, nonatomic) CWStarRateView *starRateView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

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

        
        _ivPhoto = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivPhoto.layer.cornerRadius = 20.f;
        _ivPhoto.layer.masksToBounds = YES;
        _ivPhoto.layer.borderColor = RGB3(221).CGColor;
        _ivPhoto.layer.borderWidth = 4.f;
        _ivPhoto.clipsToBounds = YES;
        _ivPhoto.userInteractionEnabled = YES;
        [self addSubview:_ivPhoto];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClick)];
        [_ivPhoto addGestureRecognizer:tap];
        
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
        _starRateView.scorePercent = 0;
        [self addSubview:_starRateView];
        
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self addSubview:self.cycleScrollView];
    }
    return self;
}

- (void)imgClick{
    if ([self.delegate respondsToSelector:@selector(imageClick)]) {
        [self.delegate imageClick];
    }
}

- (void)updateData:(NSDictionary*)data{
    self.lbTitle.text = [[data objectForKey:@"info"] objectForKey:@"goods_name"];
    self.lbName.text = [[data objectForKey:@"u_info"] objectForKey:@"user_name"];
    NSString *url = [[data objectForKey:@"u_info"] objectForKey:@"head_graphic"];
    if(url && ![url isKindOfClass:[NSNull class]]){
        [self.ivPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,url]]];
    }
    NSMutableArray *images = [NSMutableArray array];
    NSArray *imagesURLStrings = [data objectForKey:@"imglist"];
    for (NSDictionary *dic in imagesURLStrings) {
        [images addObject:[NSString stringWithFormat:@"%@%@",IMAGEURL,[dic objectForKey:@"graphic"]]];
    }
    
    self.cycleScrollView.imageURLStringsGroup = images;
    
    
    self.starRateView.scorePercent = [[[data objectForKey:@"u_info"] objectForKey:@"evaluate"]floatValue];
    [self setNeedsLayout];
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
    
    r = self.cycleScrollView.frame;
    r.size.width = ScreenWidth - 20;
    r.size.height = r.size.width / 2.3;
    r.origin.x = 10;
    r.origin.y = self.lbTitle.mj_y + self.lbTitle.mj_h + 10;
    self.cycleScrollView.frame = r;
    
    r = self.ivPhoto.frame;
    r.size.width = 40;
    r.size.height = r.size.width;
    r.origin.x = self.lbTitle.mj_x;
    r.origin.y = self.cycleScrollView.mj_y + self.cycleScrollView.mj_h + 10;
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
