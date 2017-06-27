//
//  ActionSheet.m
//  AtChat
//
//  Created by zhouMR on 2017/3/10.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "CustomAlertView.h"
#define BUTTON_HEIGHT 44.f
#define RATIO_WIDHT320 [UIScreen mainScreen].bounds.size.width/320.0
@implementation CustomAlertView

- (id)init
{
    self = [super initWithFrame:(CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size}];
    if (self) {
        [self installView];
    }
    
    return self;
}

- (id)initWithActions:(NSArray*)actions withTitle:(NSString*)title withBlock:(CallBackBlock)block
{
    self = [super initWithFrame:(CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size}];
    if (self) {
        _title = title;
        self.dataSource = actions;
        myBlock = block;
        [self installView];
    }
    
    return self;
}

-(void)installView{
    self.windowLevel = UIWindowLevelAlert;
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    actionWindow = self;
    self.alpha = 0;
    [self addSubview:view];
    
    blackBg = [[UIView alloc] initWithFrame:self.frame];
    [blackBg setBackgroundColor:[UIColor blackColor]];
    blackBg.alpha = 0.3;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//    [blackBg addGestureRecognizer:tap];
    [view addSubview:blackBg];
    
    mainBg = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 240*RATIO_WIDHT320)/2.0, ([UIScreen mainScreen].bounds.size.height - 300*RATIO_WIDHT320)/2.0,240*RATIO_WIDHT320, 300*RATIO_WIDHT320)];
    [mainBg setBackgroundColor:[UIColor whiteColor]];
    mainBg.layer.cornerRadius = 10;
    mainBg.layer.masksToBounds = YES;
    
    UILabel *lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, mainBg.frame.size.width, 30)];
    lbTitle.text = _title;
    lbTitle.font = [UIFont boldSystemFontOfSize:16];
    lbTitle.textAlignment = NSTextAlignmentCenter;
    [mainBg addSubview:lbTitle];
    
    
    
    CGFloat height = self.dataSource.count * BUTTON_HEIGHT + 60 + BUTTON_HEIGHT + 5;
    if (height > 300*RATIO_WIDHT320) {
        height = 300*RATIO_WIDHT320;
    }
    CGRect r = mainBg.frame;
    r.size.height = height;
    r.origin.y = ([UIScreen mainScreen].bounds.size.height - height)/2.0;
    mainBg.frame = r;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 59.5, mainBg.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:228/255.0 green:227/255.0 blue:230/255.0 alpha:1];
    [mainBg addSubview:line];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, mainBg.frame.size.width, mainBg.frame.size.height - 60 - BUTTON_HEIGHT - 5) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [table setSeparatorInset:UIEdgeInsetsZero];
    [table setLayoutMargins:UIEdgeInsetsZero];
    [mainBg addSubview:table];
    
    if (height < 300*RATIO_WIDHT320) {
        table.scrollEnabled = NO;
    }
    
    //取消
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, mainBg.frame.size.height - BUTTON_HEIGHT,mainBg.frame.size.width , BUTTON_HEIGHT)];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitleColor:[UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1] forState:UIControlStateNormal];
    [mainBg addSubview:cancelBtn];
    
    
    [view addSubview:mainBg];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BUTTON_HEIGHT;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithRed:72/255.0 green:118/255.0 blue:255/255.0 alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    myBlock(indexPath.row);
    [self dismiss];
}

- (void)show {
    [self makeKeyAndVisible];
    [UIView animateWithDuration:0.3 animations:^{
        blackBg.alpha = 0.3;
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        mainBg.alpha = 1;
        actionWindow.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        blackBg.alpha = 0;
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        mainBg.alpha = 0;
    } completion:^(BOOL finished) {
        NSArray *arr = [self subviews];
        for (UIView *v in arr) {
            [v removeFromSuperview];
        }
        actionWindow.hidden = true;
        actionWindow = nil;
        [self resignKeyWindow];
    }];
}

@end
