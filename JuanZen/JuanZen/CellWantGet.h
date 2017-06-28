//
//  CellWantGet.h
//  JuanZen
//
//  Created by simple on 17/6/27.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWantGet : UITableViewCell
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger type;  //0 表示普通文字一行   1 表示捐赠者联系方式
- (void)updateData:(NSDictionary*)data;
+ (CGFloat)calHeight:(NSInteger)type;       
@end
