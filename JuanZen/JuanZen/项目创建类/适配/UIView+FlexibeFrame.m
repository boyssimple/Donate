//
//  UIView+FlexibeFrame.m
//  痕记APP
//
//  Created by rimi on 15/6/11.
//  Copyright (c) 2015年 wanqian. All rights reserved.
//

#import "UIView+FlexibeFrame.h"
#import "FlexibeFrame.h"

@implementation UIView (FlexibeFrame)

- (instancetype)initWithFlexibleFrame:(CGRect)flexibleFrame
{
    self = [self initWithFrame:[FlexibeFrame frameFromIphone5Frame:flexibleFrame]];
    return self;
}

@end
