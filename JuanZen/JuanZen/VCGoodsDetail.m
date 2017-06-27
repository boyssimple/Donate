//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VCGoodsDetail.h"
#import "CellDownSelection.h"
#import "ViewHeaderGoods.h"

@interface VCGoodsDetail ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;
@property (nonatomic, strong) ViewHeaderGoods  *header;

@end

@implementation VCGoodsDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"物品详情";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
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
    }else{
        
        if (indexPath.row == 0) {
            cell.title = @"拿取地址";
            cell.type = 1;
        }else if (indexPath.row == 1) {
            cell.title = @"拿取时间";
            cell.type = 1;
        }else if (indexPath.row == 2) {
            cell.title = @"结束时间";
            cell.type = 1;
        }
        [cell hiddenLine:NO];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

- (void)selectCell:(NSInteger)type with:(NSIndexPath *)index{
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
        _table.tableHeaderView = self.header;
        _table.showsVerticalScrollIndicator = NO;
    }
    return _table;
}

- (UIButton*)btnSubmit{
    if(!_btnSubmit){
        _btnSubmit = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWidth, 40)];
        _btnSubmit.backgroundColor = RGB(254, 0, 0);
        [_btnSubmit setTitle:@"我要拿取这件东西" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btnSubmit;
}

- (ViewHeaderGoods*)header{
    if(!_header){
        _header = [[ViewHeaderGoods alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, [ViewHeaderGoods calHeight])];
        [_header updateData];
    }
    
    return _header;
}
@end
