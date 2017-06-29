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
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation VCDonateProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"捐赠者资料";
    [self loadData];
}


- (void)loadData{
    [self showHudInView:self.view hint:@"加载数据..."];
    NSString *urlstring = [NSString stringWithFormat:@"/api.php/index/u_info"];
    NSDictionary *parmas = @{@"apikey":APIKEY,@"user_id":self.userId};
    __weak typeof(self) weakself = self;
    
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:urlstring parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"结果：%@",responseObject);
        [self hideHud];
        if([[responseObject objectForKey:@"code"]integerValue] == 200){
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
    self.dataSource = [data objectForKey:@"list"];
    [self.table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    return self.dataSource.count;
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
        NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
        NSString *type = [data objectForKey:@"type_title"];
        if([type isKindOfClass:[NSNull class]]){
            type = @"";
        }
        NSInteger sum = [[data objectForKey:@"sum"]integerValue];
        cell.title = type;
        if (sum > 0) {
            cell.type = 1;
        }else{
            cell.type = 2;
        }
        cell.lbText.text = [NSString stringWithFormat:@"累计捐赠%zi件",sum];
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

- (void)selectCell:(NSInteger)type with:(NSIndexPath *)index{
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
    }
    
    return _header;
}
@end
