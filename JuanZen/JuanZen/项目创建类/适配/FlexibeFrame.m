//
//  FlexibeFrame.m
//  屏幕适配
//
//  Created by rimi on 15/6/11.
//  Copyright (c) 2015年 wanqian. All rights reserved.
//

#import "FlexibeFrame.h"
#import <UIKit/UIKit.h>

@implementation FlexibeFrame

+ (CGFloat)ratio
{
    return [UIScreen mainScreen].bounds.size.width/IPHONED_SCREEN.width;
}

+ (CGFloat)flexibleFloat:(CGFloat)aFloat//自适应的
{
    return aFloat * [self ratio];
}

+ (CGRect)frameFromIphone5Frame:(CGRect)iphone5Frame
{
    CGFloat x = [self flexibleFloat:iphone5Frame.origin.x];
    CGFloat y = [self flexibleFloat:iphone5Frame.origin.y];
    CGFloat w = [self flexibleFloat:iphone5Frame.size.width];
    CGFloat h = [self flexibleFloat:iphone5Frame.size.height];
    return CGRectMake(x, y, w, h);
}

@end
