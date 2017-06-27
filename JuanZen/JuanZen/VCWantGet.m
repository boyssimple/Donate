//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VCWantGet.h"
#import "CellDownSelection.h"
#import "CellWantGet.h"
#import "VCGoodsDetail.h"

@interface VCWantGet ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;

@end

@implementation VCWantGet

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"我要拿取";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 11;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 6) {
        return [CellWantGet calHeight:0];
    }else if(indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 9){
        return [CellDownSelection calHeight:6];
    }else if(indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 8){
        return [CellDownSelection calHeight:1];
    }else if(indexPath.row == 5){
        return [CellDownSelection calHeight:2];
    }else if(indexPath.row == 2){
        return [CellWantGet calHeight:1];
    }
    return [CellDownSelection calHeight:4];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 6 || indexPath.row == 2) {
        
        static NSString *identfiter = @"Cell";
        CellWantGet *cell = [tableView dequeueReusableCellWithIdentifier:identfiter];
        if (!cell) {
            cell = [[CellWantGet alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfiter];
        }
        if (indexPath.row == 0) {
            cell.type = 0;
            cell.title = @"您选择了拿免费的捐赠物，请跟着以下步骤：";
            
        }else if(indexPath.row == 2){
            cell.type = 1;
            [cell updateData];
        }else if(indexPath.row == 6){
            cell.type = 0;
            cell.title = @"我可以在这个时间里拿取";
        }
        return cell;
    } else{
        
        static NSString *identfiter = @"CellDownSelection";
        CellDownSelection *cell = [tableView dequeueReusableCellWithIdentifier:identfiter];
        if (!cell) {
            cell = [[CellDownSelection alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfiter];
        }
        if (indexPath.row == 1) {
            cell.type = 6;
            cell.title = @"现在联系捐赠者";
        }else if(indexPath.row == 3){
            cell.type = 6;
            cell.title = @"留下我的联系方式给捐赠者";
        }else if(indexPath.row == 4){
            cell.type = 1;
            cell.title = @"姓名";
        }else if(indexPath.row == 5){
            cell.type = 2;
            cell.title = @"联系方式";
        }else if(indexPath.row == 7){
            cell.type = 1;
            cell.title = @"开始时间";
        }else if(indexPath.row == 8){
            cell.type = 1;
            cell.title = @"结束时间";
        }else if(indexPath.row == 9){
            cell.type = 6;
            cell.title = @"我要传达“谢谢”给捐赠者";
        }else if(indexPath.row == 10){
            cell.type = 4;
            cell.title = @"给捐赠者评价";
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

- (void)submitClick{
    VCGoodsDetail *vc = [[VCGoodsDetail alloc]init];
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
        [_btnSubmit setTitle:@"确定" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

@end
