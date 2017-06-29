//
//  ImageCustom.h
//  JuanZen
//
//  Created by zhouMR on 2017/6/29.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageCustomDelegate;
@interface ImageCustom : UIView
@property (nonatomic, strong) UIImageView *ivImg;
@property (nonatomic, strong) UIButton *btnDelete;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic,weak)   id<ImageCustomDelegate> delegate;
@end

@protocol ImageCustomDelegate <NSObject>

- (void)imageDeleteClick:(NSInteger)index;

@end
