//
//  CellDownSelection.h
//  JuanZen
//
//  Created by zhouMR on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@protocol CellDownSelectionDelegate;
@interface CellDownSelection : UITableViewCell
@property (nonatomic, strong) UITextField *tfText;
@property (nonatomic, strong) UITextField *tfSecondText;
@property (nonatomic, strong) UIImageView *ivImage; //unsed
@property (strong, nonatomic) CWStarRateView *starRateView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIImageView *ivPhoto;
@property (nonatomic, strong) NSArray *images;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger type;  //0 表示普通选择  1表示可直接输入   2 表示联系方式选择    3表示上传图片   4表示星级   5 表示备注内容较大     6 check    7 头像    8 上传后显示的图片    9时间或地址
@property (nonatomic, weak) id<CellDownSelectionDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *index;
+ (CGFloat)calHeight:(NSInteger)type;          //0 表示选择   1表示上传图片
- (void)hiddenLine:(BOOL)hidden;

- (void)updateData:(NSString*)text withType:(NSInteger)type;
- (void)updataImages:(NSArray *)images;
@end

@protocol CellDownSelectionDelegate <NSObject>

- (void)selectCell:(NSInteger)type with:(NSIndexPath*)index;//  0表示选择    1表示           2 表示图片删除
@optional
- (void)deleteImg:(NSInteger)curIndex with:(NSIndexPath*)index;// 图片删除

@end
