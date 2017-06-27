//
//  CellDownSelection.m
//  JuanZen
//
//  Created by zhouMR on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "CellDownSelection.h"
#import "CWStarRateView.h"

@interface CellDownSelection()
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UILabel *lbText;
@property (nonatomic, strong) UITextField *tfText;
@property (nonatomic, strong) UIView *vTextBg;
@property (nonatomic, strong) UITextField *tfSecondText;
@property (nonatomic, strong) UIImageView *ivDown;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UIButton *btnAdd;
@property (strong, nonatomic) CWStarRateView *starRateView;
@property (nonatomic, strong) UITextView *textView;


@property (nonatomic, strong) UIButton *btnCheck;
@property (nonatomic, strong) UILabel *lbCheck;

@property (nonatomic, strong) UIImageView *ivPhoto;
@end
@implementation CellDownSelection

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14];
        _lbTitle.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lbTitle];
        
        _tfText = [[UITextField alloc]initWithFrame:CGRectZero];
        _tfText.font = [UIFont systemFontOfSize:14];
        _tfText.textColor = [UIColor grayColor];
        [self.contentView addSubview:_tfText];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont systemFontOfSize:14];
        _lbText.hidden = YES;
        _lbText.text = @"我是LB";
        _lbText.textColor = [UIColor grayColor];
        _lbText.userInteractionEnabled = YES;
        [self.contentView addSubview:_lbText];
        UITapGestureRecognizer *textTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClick)];
        [_lbText addGestureRecognizer:textTap];
        
        
        _vTextBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vTextBg.backgroundColor = RGB3(229);
        _vTextBg.layer.cornerRadius = 3;
        _vTextBg.layer.masksToBounds = YES;
        [self.contentView addSubview:_vTextBg];
        
        
        _tfSecondText = [[UITextField alloc]initWithFrame:CGRectZero];
        _tfSecondText.font = [UIFont systemFontOfSize:14];
        _tfSecondText.placeholder = @"请填写您的微信号码";
        [_vTextBg addSubview:_tfSecondText];
        
        _ivDown = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivDown.image = [UIImage imageNamed:@"down"];
        _ivDown.userInteractionEnabled = YES;
        [self.contentView addSubview:_ivDown];
        UITapGestureRecognizer *ivTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClick)];
        [_ivDown addGestureRecognizer:ivTap];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(241);
        [self.contentView addSubview:_vLine];
        
        _btnAdd = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnAdd setImage:[UIImage imageNamed:@"UploadImg"] forState:UIControlStateNormal];
        _btnAdd.layer.cornerRadius = 3;
        _btnAdd.layer.borderWidth = 0.5;
        _btnAdd.layer.borderColor = RGB3(230).CGColor;
        _btnAdd.hidden = YES;
        [_btnAdd addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnAdd];
        
        _starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(ScreenWidth - 130, 0, 120, 20) numberOfStars:5];
        _starRateView.hidden = YES;
        [self.contentView addSubview:_starRateView];
        
        _textView = [[UITextView alloc]initWithFrame:CGRectZero];
        _textView.backgroundColor = RGB3(241);
        _textView.layer.cornerRadius = 3;
        _textView.textColor = [UIColor grayColor];
        [self.contentView addSubview:_textView];
        
        _btnCheck = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnCheck setImage:[UIImage imageNamed:@"CheckNormal"] forState:UIControlStateNormal];
        [_btnCheck setImage:[UIImage imageNamed:@"CheckSelected"] forState:UIControlStateSelected];
        [_btnCheck addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnCheck];
    
        _lbCheck = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCheck.font = [UIFont systemFontOfSize:14];
        _lbCheck.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lbCheck];
        
        _ivPhoto = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivPhoto.layer.cornerRadius = 25.f;
        _ivPhoto.layer.masksToBounds = YES;
        _ivPhoto.layer.borderColor = RGB3(221).CGColor;
        _ivPhoto.layer.borderWidth = 4.f;
        _ivPhoto.clipsToBounds = YES;
        [_ivPhoto sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1074344932,2251510853&fm=26&gp=0.jpg"]];
        [self.contentView addSubview:_ivPhoto];
    }
    return self;
}

- (void)selectClick{
    if ([self.delegate respondsToSelector:@selector(selectCell:)]) {
        [self.delegate selectCell:0];
    }
}

- (void)uploadClick{
    if ([self.delegate respondsToSelector:@selector(selectCell:)]) {
        [self.delegate selectCell:1];
    }
}

- (void)checkClick:(UIButton*)sender{
    sender.selected = !sender.selected;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.lbTitle.text = _title;
    if (self.type == 6) {
        self.lbCheck.text = _title;
    }
}

- (void)setType:(NSInteger)type{
    _type = type;
    self.lbTitle.hidden = NO;
    self.ivDown.hidden = YES;
    self.lbText.hidden = YES;
    self.tfText.hidden = YES;
    self.vTextBg.hidden = YES;
    self.btnAdd.hidden = YES;
    self.starRateView.hidden = YES;
    self.textView.hidden = YES;
    
    
    self.btnCheck.hidden = YES;
    self.lbCheck.hidden = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    self.ivPhoto.hidden = YES;
    
    if (_type == 0) {
        self.lbText.hidden = NO;
        self.ivDown.hidden = NO;
    }else if(_type == 1){
        self.tfText.hidden = NO;
    }else if(_type == 2){
        self.lbText.hidden = NO;
        self.vTextBg.hidden = NO;
        self.ivDown.hidden = NO;
    }else if(_type == 3){
        self.btnAdd.hidden = NO;
    }else if(_type == 4){
        self.starRateView.hidden = NO;
    }else if(_type == 5){
        self.textView.hidden = NO;
    }else if(_type == 6){
        self.lbTitle.hidden = YES;
        self.btnCheck.hidden = NO;
        self.lbCheck.hidden = NO;
        self.backgroundColor = [UIColor clearColor];
    }else if(_type == 7){
        self.ivPhoto.hidden = NO;
    }
    
}

- (void)hiddenLine:(BOOL)hidden{
    self.vLine.hidden = hidden;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbTitle.frame;
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r.size.width = 80;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.lbTitle.frame = r;
    
    r = self.ivDown.frame;
    r.size.width = 5;
    r.size.height = 4;
    r.origin.x = ScreenWidth - r.size.width - 10;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.ivDown.frame = r;
    
    r = self.tfText.frame;
    r.size.height = self.mj_h - 20;
    r.origin.x = self.lbTitle.mj_w + self.lbTitle.mj_x + 40;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    r.size.width = ScreenWidth - (self.lbTitle.mj_w + self.lbTitle.mj_x) - 50;
    self.tfText.frame = r;
    
    
    
    r = self.vTextBg.frame;
    r.origin.x = self.tfText.mj_x;
    r.origin.y = self.tfText.mj_y + 5;
    r.size.width = ScreenWidth - self.tfText.mj_x - 10;
    r.size.height = self.tfText.mj_h;
    self.vTextBg.frame = r;
    
    r = self.tfSecondText.frame;
    r.origin.x = 5;
    r.origin.y = 0;
    r.size.width = self.vTextBg.mj_w - 10;
    r.size.height = self.vTextBg.mj_h;
    self.tfSecondText.frame = r;
    
    r = self.vLine.frame;
    r.size.width = ScreenWidth - 10;
    r.size.height = 0.5;
    r.origin.x = 10;
    r.origin.y = self.mj_h - r.size.height;
    self.vLine.frame = r;
    
    r = self.btnAdd.frame;
    r.size.width = 40;
    r.size.height = r.size.width;
    r.origin.x = self.tfText.mj_x;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.btnAdd.frame = r;
    
    if (self.type == 0) {
        self.tfText.mj_w = ScreenWidth - self.tfText.mj_x - 20;
        self.tfText.mj_h = [CellDownSelection calHeight:1] - 20;
        self.tfText.mj_y = (self.mj_h - self.tfText.mj_h)/2.0;
    }else if(self.type == 2){
        self.lbTitle.mj_y = ([CellDownSelection calHeight:1] - self.lbTitle.mj_h)/2.0;
        self.ivDown.mj_y = ([CellDownSelection calHeight:1] - self.ivDown.mj_h)/2.0;
        
        self.tfText.mj_w = ScreenWidth - self.tfText.mj_x - 20;
        self.tfText.mj_h = [CellDownSelection calHeight:1] - 20;
        self.tfText.mj_y = ([CellDownSelection calHeight:1] - self.tfText.mj_h)/2.0;
        
        self.vTextBg.mj_h = self.tfText.mj_h;
        self.vTextBg.mj_y = self.tfText.mj_y + self.tfText.mj_h + 5;
        self.tfSecondText.mj_h = self.vTextBg.mj_h;
    }else if(self.type == 3){
        self.lbTitle.mj_y = ([CellDownSelection calHeight:1] - self.lbTitle.mj_h)/2.0;
    }
    
    r = self.lbText.frame;
    r.size.height = self.tfText.mj_h;
    r.origin.x = self.tfText.mj_x;
    r.origin.y = self.tfText.mj_y;
    r.size.width = self.tfText.mj_w;
    self.lbText.frame = r;;
    self.starRateView.mj_y = (self.mj_h - self.starRateView.mj_h)/2.0;
    
    r = self.textView.frame;
    r.size.width = self.tfSecondText.mj_w;
    r.size.height = self.mj_h - 20;
    r.origin.x = self.tfSecondText.mj_x;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.textView.frame = r;
    
    r = self.btnCheck.frame;
    r.size.width = 15;
    r.size.height = r.size.width;
    r.origin.x = 10;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.btnCheck.frame = r;
    
    size = [self.lbCheck sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbCheck.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = (self.btnCheck.mj_x + self.btnCheck.mj_w + 7);
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.lbCheck.frame = r;
    
    r = self.ivPhoto.frame;
    r.size.width = 50;
    r.size.height = r.size.width;
    r.origin.x = self.tfText.mj_x;
    r.origin.y = (self.mj_h - r.size.height)/2.0;
    self.ivPhoto.frame = r;
}

+ (CGFloat)calHeight:(NSInteger)type{
    if (type == 1) {
        return 50;
    }else if(type == 2){
        return 85;
    }else if(type == 3){
        return 70;
    }else if(type == 4){
        return 40;
    }else if(type == 5){
        return 100;
    }else if(type == 6){
        return 40;
    }else if(type == 7){
        return 70;
    }
    return 40;
}

@end
