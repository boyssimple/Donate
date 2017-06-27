//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VCMyProfile.h"
#import "CellDownSelection.h"

@interface VCMyProfile ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;

@end

@implementation VCMyProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"我的资料";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return [CellDownSelection calHeight:2];
    }else if(indexPath.row == 6){
        return [CellDownSelection calHeight:6];
    }else if(indexPath.row == 0){
        return [CellDownSelection calHeight:7];
    }
    return [CellDownSelection calHeight:1];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfiter = @"Cell";
    CellDownSelection *cell = [tableView dequeueReusableCellWithIdentifier:identfiter];
    if (!cell) {
        cell = [[CellDownSelection alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfiter];
        cell.delegate = self;
    }
    if (indexPath.row == 0) {
        cell.title = @"头像";
        cell.type = 7;
    }else if (indexPath.row == 1) {
        cell.title = @"公司名称";
        cell.type = 1;
    }else if (indexPath.row == 2) {
        cell.title = @"电话号码";
        cell.type = 1;
    }else if (indexPath.row == 3) {
        cell.title = @"联系方式";
        cell.type = 2;
    }else if (indexPath.row == 4) {
        cell.title = @"我的地址";
        cell.type = 1;
    }else if (indexPath.row == 5) {
        cell.type = 1;
        cell.title = @"详细地址";
    }else if (indexPath.row == 6) {
        cell.type = 6;
        cell.title = @"推荐这款APP给身边的人一起来帮助需要帮助的人！";
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

- (void)selectCell:(NSInteger)type{
    NSLog(@"%zi",type);
}

- (UITableView*)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 40) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = RGB3(241);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _table.showsVerticalScrollIndicator = NO;
    }
    return _table;
}

- (UIButton*)btnSubmit{
    if(!_btnSubmit){
        _btnSubmit = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWidth, 40)];
        _btnSubmit.backgroundColor = RGB(254, 0, 0);
        [_btnSubmit setTitle:@"保存" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btnSubmit;
}

@end
