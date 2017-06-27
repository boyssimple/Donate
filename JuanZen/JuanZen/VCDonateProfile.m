//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VCDonateProfile.h"
#import "CellDonateProfile.h"
#import "ViewHeaderDonate.h"

@interface VCDonateProfile ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;
@property (nonatomic, strong) ViewHeaderDonate  *header;

@end

@implementation VCDonateProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"捐赠者资料";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return [CellDonateProfile calHeight:0];
    }
    return [CellDonateProfile calHeight:1];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfiter = @"Cell";
    CellDonateProfile *cell = [tableView dequeueReusableCellWithIdentifier:identfiter];
    if (!cell) {
        cell = [[CellDonateProfile alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfiter];
    }
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.title = @"捐赠物";
            cell.type = 0;
        }
    }else{
        
        if(indexPath.row < 4){
            cell.title = @"食物类";
            cell.type = 1;
        }else{
            cell.title = @"优惠卷票类";
            cell.type = 2;
        }
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return 0.00001f;
    }
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
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
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

- (ViewHeaderDonate*)header{
    if(!_header){
        _header = [[ViewHeaderDonate alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, [ViewHeaderDonate calHeight])];
        [_header updateData];
    }
    
    return _header;
}
@end
