//
//  ActionSheet.h
//  AtChat
//
//  Created by zhouMR on 2017/3/10.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

static UIWindow *actionWindow = nil;
typedef void (^CallBackBlock)(NSInteger btnIndex);

@interface CustomAlertView : UIWindow<UITableViewDelegate,UITableViewDataSource>{
    UIView *blackBg;
    UIView *mainBg;
    NSString *_title;
    CallBackBlock myBlock;
}
@property (nonatomic, strong)NSArray *dataSource;//菜单数组;
@property(nonatomic,strong)NSDictionary *data;
- (void)show;
- (void)dismiss;
- (id)initWithActions:(NSArray*)actions withTitle:(NSString*)title withBlock:(CallBackBlock)block;
@end
