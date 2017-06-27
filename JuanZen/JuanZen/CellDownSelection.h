//
//  CellDownSelection.h
//  JuanZen
//
//  Created by zhouMR on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellDownSelectionDelegate;
@interface CellDownSelection : UITableViewCell
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger type;  //0 表示普通选择  1表示可直接输入   2 表示联系方式选择    3表示上传图片   4表示星级   5 表示备注内容较大     6 check    7 头像
@property (nonatomic, weak) id<CellDownSelectionDelegate> delegate;

+ (CGFloat)calHeight:(NSInteger)type;          //0 表示选择   1表示上传图片
- (void)hiddenLine:(BOOL)hidden;
@end

@protocol CellDownSelectionDelegate <NSObject>

- (void)selectCell:(NSInteger)type;

@end
