//
//  RXJDButton.m
//  RXExtenstion
//
//  Created by 龚洪 on 16/12/7.
//  Copyright © 2016年 赛联(武汉). All rights reserved.
//

#import "RXJDButton.h"
#import "RXHexColor.h"
#define UIColorHexStr(_color) [RXHexColor colorWithHexString:_color]

@implementation RXJDButton


- (CGFloat)width {
    return _width;
}

- (CGFloat)left {
    return _left;
}


- (void)setAddressName:(NSString *)addressName {
    _addressName = addressName;
    [self setTitle:addressName forState:UIControlStateNormal];

    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:UIColorHexStr(@"333333") forState:UIControlStateNormal];
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.backgroundColor = [UIColor clearColor];
    
    CGRect rect = self.frame;
    _left = rect.origin.x;

    [self sizeToFit];
    _width = self.bounds.size.width;
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, _width, rect.size.height);
    
}

@end
