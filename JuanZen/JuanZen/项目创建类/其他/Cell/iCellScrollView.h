//
//  iCellScrollView.h
//  iCell
//
//  Created by 龚洪 on 2017/3/9.
//  Copyright © 2017年 赛联(武汉). All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,iCellScrollViewPageControlPosition){
    iCellScrollViewPageControlPositionLeft,
    iCellScrollViewPageControlPositionCenter,
    iCellScrollViewPageControlPositionRight
};

@class iCellScrollView;

@protocol iCellScrollViewDataSource <NSObject>

@required

-(NSInteger)numberOfItemInScrollView:(iCellScrollView *)scrollView;

@optional

-(NSURL*)scrollView:(iCellScrollView *)scrollView urlForItemAtIndex:(NSInteger)index;
-(UIImage*)scrollView:(iCellScrollView *)scrollView imageForItemAtIndex:(NSInteger)index;
-(UIImage*)scrollView:(iCellScrollView *)scrollView placeholderImageForIndex:(NSInteger)index;

@end

@protocol iCellScrollViewDelegate <NSObject>

@optional

-(void)scrollView:(iCellScrollView *)scrollView didClickAtIndex:(NSInteger)index;

@end
@interface iCellScrollView : UIView


@property (nonatomic, assign) BOOL hideIndicator;//设置隐藏加载菊花，默认显示
@property (nonatomic, assign) double timeInterval;//设置播放时间间隔,默认3s
@property (nonatomic, strong) UIColor *pageControlTintColor;//pageControl的颜色
@property (nonatomic, strong) UIColor *pageIndicatorSelectedTintColor;//pageControl选中颜色
@property (nonatomic, assign) iCellScrollViewPageControlPosition pageControlPosition;//pageControl的位置
@property (nonatomic, weak) id <iCellScrollViewDataSource> dataSource;
@property (nonatomic, weak) id <iCellScrollViewDelegate> delegate;

-(void)start;
-(void)onlyShowImgaeAndDontAddTimer;
@end
