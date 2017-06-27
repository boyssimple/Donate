//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VipDataViewController.h"
#import "CellDownSelection.h"
#import "VCWantGet.h"

@interface VipDataViewController ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;

@end

@implementation VipDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"会员资料";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 10;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            return [CellDownSelection calHeight:2];
        }else if(indexPath.row == 9){
            return [CellDownSelection calHeight:3];
        }
    }else if(indexPath.section == 1){
        return [CellDownSelection calHeight:4];
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
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.title = @"捐赠类别";
            cell.type = 0;
        }else if (indexPath.row == 1) {
            cell.title = @"捐赠类型";
            cell.type = 0;
        }else if (indexPath.row == 2) {
            cell.title = @"捐赠名称";
            cell.type = 1;
        }else if (indexPath.row == 3) {
            cell.title = @"公司名称";
            cell.type = 1;
        }else if (indexPath.row == 4) {
            cell.title = @"联系方式";
            cell.type = 2;
        }else if (indexPath.row == 5) {
            cell.title = @"拿取时间";
            cell.type = 1;
        }else if (indexPath.row == 6) {
            cell.title = @"结果时间";
            cell.type = 1;
        }else if (indexPath.row == 7) {
            cell.title = @"我的地址";
            cell.type = 1;
        }else if (indexPath.row == 8) {
            cell.title = @"详细地址";
            cell.type = 1;
        }else if (indexPath.row == 9) {
            cell.title = @"上传图片";
            cell.type = 3;
        }
        [cell hiddenLine:NO];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.title = @"新旧程度";
            cell.type = 4;
        }else if (indexPath.row == 1) {
            cell.title = @"使用频率";
            cell.type = 4;
        }else if (indexPath.row == 2) {
            cell.title = @"干净程度";
            cell.type = 4;
        }
        [cell hiddenLine:YES];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

- (void)submitClick{
    VCWantGet *vc = [[VCWantGet alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
        _table.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.showsVerticalScrollIndicator = NO;
    }
    return _table;
}

- (UIButton*)btnSubmit{
    if(!_btnSubmit){
        _btnSubmit = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWidth, 40)];
        _btnSubmit.backgroundColor = RGB(254, 0, 0);
        [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

@end
