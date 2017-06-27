//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VCWantWish.h"
#import "CellDownSelection.h"

@interface VCWantWish ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;

@end

@implementation VCWantWish

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"我要许愿";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return [CellDownSelection calHeight:2];
    }else if(indexPath.row == 4){
        return [CellDownSelection calHeight:5];
    }else if(indexPath.row == 5){
        return [CellDownSelection calHeight:6];
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
        cell.title = @"心愿类别";
        cell.type = 0;
    }else if (indexPath.row == 1) {
        cell.title = @"心愿类型";
        cell.type = 0;
    }else if (indexPath.row == 2) {
        cell.title = @"联系方式";
        cell.type = 2;
    }else if (indexPath.row == 3) {
        cell.title = @"希望时间";
        cell.type = 1;
    }else if (indexPath.row == 4) {
        cell.title = @"备注";
        cell.type = 5;
    }else if (indexPath.row == 5) {
        cell.type = 6;
        cell.title = @"我要打上“万分感激”在地图上";
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
        [_btnSubmit setTitle:@"确定" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btnSubmit;
}

@end
