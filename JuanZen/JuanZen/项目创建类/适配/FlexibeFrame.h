//
//  FlexibeFrame.h
//  屏幕适配
//
//  Created by rimi on 15/6/11.
//  Copyright (c) 2015年 wanqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlexibeFrame : NSObject

+ (CGFloat)ratio;
+ (CGFloat)flexibleFloat:(CGFloat)aFloat;
+ (CGRect)frameFromIphone5Frame:(CGRect)iphone5Frame;

@end
