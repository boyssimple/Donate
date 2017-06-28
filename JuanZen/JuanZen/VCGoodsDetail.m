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
#import "VCWantGet.h"

@interface VCGoodsDetail ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;
@property (nonatomic, strong) ViewHeaderGoods  *header;


@property (nonatomic, strong) NSString *getAddress;//拿取地址
@property (nonatomic, strong) NSString *startTime;//拿取时间
@property (nonatomic, strong) NSString *endTime;//结束时间


@property (nonatomic, assign) CGFloat oldLevel;
@property (nonatomic, assign) CGFloat useLevel;
@property (nonatomic, assign) CGFloat clearLevel;
@property (nonatomic, strong) NSDictionary *data;
@end

@implementation VCGoodsDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"物品详情";
    [self loadData];
}


- (void)loadData{
    [self showHudInView:self.view hint:@"加载数据..."];
    NSString *urlstring = [NSString stringWithFormat:@"/api.php/index/g_info"];
    NSDictionary *parmas = @{@"apikey":APIKEY,@"goods_id":@(366)};
    __weak typeof(self) weakself = self;
    
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:urlstring parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"结果：%@",responseObject);
        [self hideHud];
        if([[responseObject objectForKey:@"code"]integerValue] == 200){
            weakself.data = responseObject;
            [weakself handleData:responseObject];
        }else{
            [self showHint:@"加载失败!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"加载失败!"];
        [self hideHud];
        NSLog(@"error：%@",error);
    }];
}

- (void)handleData:(NSDictionary*)data{
    [self.header updateData:data];
    
    self.oldLevel = [[[data objectForKey:@"info"] objectForKey:@"old_new"]floatValue];
    self.useLevel = [[[data objectForKey:@"info"] objectForKey:@"fre_use"]floatValue];
    self.clearLevel = [[[data objectForKey:@"info"] objectForKey:@"cle_lin"]floatValue];
    self.getAddress = [[data objectForKey:@"u_info"] objectForKey:@"address"];
    self.startTime = [[data objectForKey:@"info"] objectForKey:@"take_time"];
    self.endTime = [[data objectForKey:@"info"] objectForKey:@"end_time"];
    [self.table reloadData];
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
    return [CellDownSelection calHeight:9];
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
            [cell updateData:[NSString stringWithFormat:@"%f",self.oldLevel] withType:4];
        }else if (indexPath.row == 1) {
            cell.title = @"使用频率";
            cell.type = 4;
            [cell updateData:[NSString stringWithFormat:@"%f",self.useLevel] withType:4];
        }else if (indexPath.row == 2) {
            cell.title = @"干净程度";
            cell.type = 4;
            [cell updateData:[NSString stringWithFormat:@"%f",self.clearLevel] withType:4];
        }
        [cell hiddenLine:YES];
    }else{
        
        if (indexPath.row == 0) {
            cell.title = @"拿取地址";
            cell.type = 9;
            [cell updateData:self.getAddress withType:9];
        }else if (indexPath.row == 1) {
            cell.title = @"拿取时间";
            cell.type = 9;
            [cell updateData:self.startTime withType:9];
        }else if (indexPath.row == 2) {
            cell.title = @"结束时间";
            cell.type = 9;
            [cell updateData:self.endTime withType:9];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (void)selectCell:(NSInteger)type with:(NSIndexPath *)index{
    NSLog(@"%zi",type);
}

- (void)submitClick{
    VCWantGet *vc = [[VCWantGet alloc]init];
    vc.data = self.data;
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.view endEditing:YES];
    /*
    if (self.data) {
        [self showHudInView:self.view hint:@"数据处理..."];
        
        
        NSDictionary *dict = @{@"apikey":APIKEY,
                               @"user_id":[[self.data objectForKey:@"info"] objectForKey:@"user_id"],
                               @"start_time":self.startTime,
                               @"end_time":self.endTime,
                               @"evaluate":[[self.data objectForKey:@"u_info"] objectForKey:@"evaluate"],
                               @"contact_number":[[self.data objectForKey:@"u_info"] objectForKey:@"contact_number"],
                               @"contact_type":[[self.data objectForKey:@"u_info"] objectForKey:@"contact_type"],
                               @"full_name":[[self.data objectForKey:@"info"] objectForKey:@"goods_name"],
                               @"goods_id":[[self.data objectForKey:@"info"] objectForKey:@"goods_id"]};
        NSString     *urlString = [NSString stringWithFormat:@"%@",@"/api.php/index/add_order"];
        
        [[RequsetPostTool requestNewWorkWithBaseURL]POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"数据 ：%@",responseObject);
            [self hideHud];
            if ([responseObject[@"code"] isEqualToString:@"200"]) {
                [self showHint:@"提交成功!"];
            }else{
                [self showHint:@"提交失败!"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self hideHud];
            [self showHint:@"提交失败!"];
            NSLog(@"error");
        }];
    }else{
        [self showHint:@"提交失败!"];
    }
    */
     
}

- (UITableView*)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 40 - 64) style:UITableViewStyleGrouped];
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
        _btnSubmit = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - 40 - 64, ScreenWidth, 40)];
        _btnSubmit.backgroundColor = RGB(254, 0, 0);
        [_btnSubmit setTitle:@"我要拿取这件东西" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

- (ViewHeaderGoods*)header{
    if(!_header){
        _header = [[ViewHeaderGoods alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, [ViewHeaderGoods calHeight])];
    }
    
    return _header;
}
@end
