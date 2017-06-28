//
//  MainViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/23.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "MainModel.h"
#import "categoryViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

{

    NSMutableArray      *_dataSource;
    NSString            *_pageString;
    NSString            *_artIdString;
    NSString            *_classString;


}
@property (nonatomic, strong) UIImageView *ivBg;
@property (nonatomic, strong) UILabel *lbInfo;
@property (nonatomic, strong) UITableView *table;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的捐赠如下选项";
    [self setUpUI];
    [self initializeDataSourceWithMyDynamic];
    
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.ivBg];
    [self.view addSubview:self.lbInfo];
    [self.view addSubview:self.table];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataSource = [[NSMutableArray alloc] init];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}




#pragma mark -首页
- (void)initializeDataSourceWithMyDynamic {
    __weak typeof(self) weakself = self;
    [self showHudInView:self.view hint:@"数据加载..."];
    NSDictionary *parmars = [ReaveImformation parmars:@{@"apikey":APIKEY}];
    NSString *url = [NSString stringWithFormat:@"%@%@",DEFAULTURL,@"/api.php/index/getclass"];
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:url parameters:parmars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakself hideHud];
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
            MainModel *model = [[MainModel alloc] initWithDic:dic];
            [_dataSource addObject:model];
        }
        [weakself.table reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself hideHud];
    }];
}


#pragma mark - <UITableViewDelegate>/<UITableViewDataSource>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     self.table.scrollEnabled =NO; //设置tableview 不能滚动
    self.table.backgroundColor=[UIColor clearColor];
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identfy = @"MainTableViewCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfy];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:self options:nil][0];
    }
    MainModel *model = _dataSource[indexPath.row];
    cell.model = model;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MainModel *model = _dataSource[indexPath.row];
    categoryViewController *categoryVC = [[categoryViewController alloc]init];
    categoryVC.type_id = model.type_id;
    [self.navigationController pushViewController:categoryVC animated:YES];
    
}

- (UIImageView*)ivBg{
    if (!_ivBg) {
        _ivBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _ivBg.image = [UIImage imageNamed:@"syfl"];
    }
    return _ivBg;
}

- (UILabel*)lbInfo{
    if (!_lbInfo) {
        _lbInfo = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth - 20, 15)];
        _lbInfo.text = @"感谢你的捐赠帮助了很多人，你超棒的，我们很感谢你";
        _lbInfo.font = [UIFont systemFontOfSize:14];
        _lbInfo.textAlignment = NSTextAlignmentCenter;
    }
    return _lbInfo;
}

- (UITableView*)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.lbInfo.mj_y+ self.lbInfo.mj_h + 30, ScreenWidth, ScreenHeight-(self.lbInfo.mj_y+ self.lbInfo.mj_h + 30)) style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.showsVerticalScrollIndicator = NO;
    }
    return _table;
}
@end
