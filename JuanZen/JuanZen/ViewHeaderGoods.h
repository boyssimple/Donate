//
//  ViewHeaderGoods.h
//  JuanZen
//
//  Created by simple on 17/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewHeaderGoodsDelegate;
@interface ViewHeaderGoods : UIView
@property (nonatomic,weak)   id<ViewHeaderGoodsDelegate> delegate;
- (void)updateData:(NSDictionary*)data;
+ (CGFloat)calHeight;

@end

@protocol ViewHeaderGoodsDelegate <NSObject>

- (void)imageClick;

@end
