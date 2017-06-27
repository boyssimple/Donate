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
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self initializeDataSourceWithMyDynamic];
    
}

- (void)setUpUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

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
    [self showHudInView:self.view hint:@"数据加载..."];
    NSDictionary *parmars = [ReaveImformation parmars:@{@"apikey":APIKEY}];
    NSString *url = [NSString stringWithFormat:@"%@%@",DEFAULTURL,@"/api.php/index/getclass"];
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:url parameters:parmars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideHud];
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
            MainModel *model = [[MainModel alloc] initWithDic:dic];
            [_dataSource addObject:model];
        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
    }];
}


#pragma mark - <UITableViewDelegate>/<UITableViewDataSource>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     self.tableView.scrollEnabled =NO; //设置tableview 不能滚动
    self.tableView.backgroundColor=[UIColor clearColor];
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

@end
