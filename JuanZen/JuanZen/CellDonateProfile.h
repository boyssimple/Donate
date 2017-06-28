//
//  CellDownSelection.h
//  JuanZen
//
//  Created by zhouMR on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CellDonateProfile : UITableViewCell
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger type;  //0 表示普通选择  1
@property (nonatomic, strong) UILabel *lbText;

+ (CGFloat)calHeight:(NSInteger)type;
@end

