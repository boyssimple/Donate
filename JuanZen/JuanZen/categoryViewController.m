//
//  categoryViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/23.
//  Copyright © 2017年 yibyi. All rights reserved.
//

//controller
#import "categoryViewController.h"
//model
#import "MainModel.h"
//cell
#import "categoryCollectionViewCell.h"

#import "VipDataViewController.h"

@interface categoryViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource
>
{
    NSMutableArray      *_dataSource;
    NSString            *_pageString;
    NSString            *_artIdString;
    NSString            *_classString;
}

@property (strong, nonatomic) UICollectionView *collectionView;

@end

static NSString*collectionIdentifier = @"categoryCollectionViewCell";

@implementation categoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self initializeDataSourceWithMyDynamic];
    
    [self.view addSubview: self.collectionView];
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = 1;
        //上下间距
        flowlayout.minimumLineSpacing = 1;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 , 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor lightGrayColor]];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:collectionIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:collectionIdentifier];
    }
    return _collectionView;
}

- (void)setUpUI {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
    NSDictionary *parmars = [ReaveImformation parmars:@{@"apikey":APIKEY,@"type_id":self.type_id }];
    NSString *url = [NSString stringWithFormat:@"%@%@",DEFAULTURL,@"/api.php/index/getclass"];
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:url parameters:parmars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideHud];
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
            MainModel *model = [[MainModel alloc] initWithDic:dic];
            [_dataSource addObject:model];
        }
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
    }];
}




#pragma mark - <UICollectionViewDataSource>/<UICollectionViewDelegateFlowLayout>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    categoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:collectionIdentifier owner:nil options:nil]lastObject];
    }
    cell.model = (MainModel*)_dataSource[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth -1)/2,(ScreenWidth/2 -1) );
}


//MARK -click
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VipDataViewController *vc = [[VipDataViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
