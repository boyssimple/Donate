//
//  VCMap.m
//  JuanZen
//
//  Created by zhouMR on 2017/6/28.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VCMap.h"
#import <MapKit/MapKit.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import "YWRoundAnnotationView.h"
#import "YWPointAnnotation.h"

#import "VCWantDonate.h"
#import "VCWantWish.h"

#import "CollectionViewCell.h"


@interface VCMap ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,UITextFieldDelegate,UICollectionViewDelegate,
    UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *array;
    
    UIView                       *_bottomView;
    NSMutableArray               *_mapAnnotationArray;
    NSMutableArray               *_listArray;
    BMKLocationService           *_locationService;//定位
    BMKPoiSearch                 *_poiSearch;//检索
    BMKGeoCodeSearch             *_citySearchOption;
    NSString *longitudeStr;//经度
    NSString *latitudeStr;//纬度
    
    
}
@property (nonatomic, strong) UIView *vInfoBg;
@property (nonatomic, strong) UILabel *lbInfo;
@property (nonatomic, strong) UIButton *btnWish;
@property (nonatomic, strong) UIButton *btnDonate;
@property (nonatomic, strong) UIView *vBg;
@property (nonatomic, strong) UITextField *tfSearch;
@property (nonatomic, strong) UIView *vCollBg;
@property (nonatomic, strong) UICollectionView *collView;
@property (nonatomic, strong) NSMutableArray *classList;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIView *vMapBg;
@property (nonatomic, strong) BMKMapView  *mapView;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) NSInteger typeId;
@end

@implementation VCMap

- (void)viewWillAppear:(BOOL)animated
{
    if (_locationService != nil) {
        [_locationService startUserLocationService];
    }
    [self.navigationController.navigationBar addSubview:self.vBg];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_locationService stopUserLocationService];
    [self.vBg removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.classList = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    _mapAnnotationArray=[[ NSMutableArray alloc] init];
    _listArray=[[ NSMutableArray alloc] init];
    [self initlocationService];
    
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnWish];
    [self.view addSubview:self.btnDonate];
    [self loadClassData];
    
    
    
    UIButton  *leftBtn = [[UIButton alloc]  initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftBtn setImage:[UIImage imageNamed:@"SearchBtn"] forState:UIControlStateNormal];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftBtn ];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton  *rightBtn = [[UIButton alloc]  initWithFrame:CGRectMake(0 , 0, 25, 25)];
    [rightBtn setImage:[UIImage imageNamed:@"PeopleBtn"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;

}

- (void)leftClick{
    [self.view endEditing:YES];
    [self search:0 with:self.tfSearch.text];
}

- (void)rightClick{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

-(void)SetBasicLocation:(BMKUserLocation *)location{
    
    latitudeStr = [NSString stringWithFormat:@"%f",location.location.coordinate.latitude];
    longitudeStr = [NSString stringWithFormat:@"%f",location.location.coordinate.longitude];
//    NSDictionary *dic = @{@"apikey":APIKEY,@"longitude":longitudeStr,@"latitude":latitudeStr};
//    NSString *url = [NSString stringWithFormat:@"/api.php/index/g_list"];
    //    NSDictionary *dic = @{@"appkey":APIKEY,@"longitude":@"106.530721",@"latitude":@"29.533453"};
    /*
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        array =responseObject[@"list"];
        
        for (int i=0; i<array.count; i++) {
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            NSDictionary *dic = array[i];
            CGFloat longitude = [dic[@"longitude"] floatValue];
            CGFloat latitude = [dic[@"latitude"] floatValue];
            NSString *goodsname = dic[@"goods_name"];
            NSString *ho_number = dic[@"ho_number"];
            NSString *goods_id = dic[@"goods_id"];
            annotation.coordinate = CLLocationCoordinate2DMake(latitude,longitude);
            annotation.title = ho_number;
            annotation.subtitle = goodsname;
            //            [_mapView  setCenterCoordinate:annotationModel.coordinate zoomLevel:13 animated:NO];
            [_mapView setCenterCoordinate:annotation.coordinate animated:YES];
            [_mapView addAnnotation:annotation];
            [_mapView mapForceRefresh];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
     */
    
    [self search:self.typeId with:self.tfSearch.text];
}

- (void)search:(NSInteger)typeId with:(NSString*)keywords{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];//@{@"apikey":APIKEY,@"longitude":longitudes,@"latitude":latitudes};
    [dic setObject:APIKEY forKey:@"apikey"];
    if (typeId != 0) {
        [dic setObject:@(typeId) forKey:@"type_id"];
    }
    if (keywords && ![keywords isEqualToString:@""]) {
        [dic setObject:keywords forKey:@"goods_name"];
    }
    
    if(latitudeStr && ![latitudeStr isEqualToString:@""]){
        [dic setObject:latitudeStr forKey:@"latitude"];
    }
    if(longitudeStr && ![longitudeStr isEqualToString:@""]){
        [dic setObject:longitudeStr forKey:@"longitude"];
    }
    
    NSString *url = [NSString stringWithFormat:@"/api.php/index/g_list"];
    
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        array =responseObject[@"list"];
        
        for (int i=0; i<array.count; i++) {
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            NSDictionary *dic = array[i];
            CGFloat longitudeValue = [dic[@"longitude"] floatValue];
            CGFloat latitudeValue = [dic[@"latitude"] floatValue];
            NSString *goodsname = dic[@"goods_name"];
            NSString *ho_number = dic[@"ho_number"];
//            NSString *goods_id = dic[@"goods_id"];
            annotation.coordinate = CLLocationCoordinate2DMake(latitudeValue,longitudeValue);
            annotation.title = ho_number;
            annotation.subtitle = goodsname;
            //            [_mapView  setCenterCoordinate:annotationModel.coordinate zoomLevel:13 animated:NO];
            [_mapView setCenterCoordinate:annotation.coordinate animated:YES];
            [_mapView addAnnotation:annotation];
            [_mapView mapForceRefresh];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"加载失败!"];
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark --private Method--定位
-(void)initlocationService{
    
    _locationService=[[BMKLocationService alloc] init];
    _locationService.desiredAccuracy=kCLLocationAccuracyBest;
    _locationService.delegate=self;
    _locationService.distanceFilter=1000;
    [_locationService startUserLocationService];
    
}

#pragma mark --private Method--添加标注数据
-(void)mapViewAddANNotations{
    
    for (NSInteger indexM=0; indexM<_listArray.count; indexM++)
    {
        BMKPoiInfo* poi=_listArray[ indexM];
        YWPointAnnotation* annotation = [[YWPointAnnotation alloc]initWithCoordinate:poi.pt];
        annotation.titlelable=poi.name;
        [_mapAnnotationArray addObject:annotation];//用于记录
        [_mapView addAnnotation:annotation];
        
    }
    
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[YWPointAnnotation class]])
    {
        YWRectAnnotationView *newAnnotationView =(YWRectAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation"];
        if (newAnnotationView==nil)
        {
            newAnnotationView=[[ YWRectAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        }
        
        YWPointAnnotation* Newannotation=(YWPointAnnotation*)annotation;
        newAnnotationView.titleText=[ NSString stringWithFormat:@"%@20",Newannotation.titlelable];
        newAnnotationView.canShowCallout = NO;
        newAnnotationView.draggable = NO;
        
        return newAnnotationView;
        
    }else if ([ annotation  isKindOfClass:[ BMKPointAnnotation class]]){
        
        YWRectAnnotationView *newAnnotationView =(YWRectAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"RoundmyAnnotation"];
        if (newAnnotationView==nil)
        {
            newAnnotationView=[[ YWRectAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"RoundmyAnnotation"];
        }
        BMKPointAnnotation* Newannotation=(BMKPointAnnotation*)annotation;
        newAnnotationView.titleText= [ NSString stringWithFormat:@"%@",Newannotation.subtitle ];
        
        newAnnotationView.canShowCallout = NO;
        newAnnotationView.draggable = NO;
        
        
        return newAnnotationView;
        
    }
    return nil;
}
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState
{
    
    
    
}
#pragma mark --private Method--当点击大头针时
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    //    NSLog(@"%@", view.annotation.title);
    //    DetailsViewController *news = [[DetailsViewController alloc] init];
    //    for (NSDictionary *dic in array) {
    //        if ([[dic valueForKey:@"ho_number"] isEqualToString:view.annotation.title]) {
    //            news.goods_id = [dic valueForKey:@"goods_id"];
    //        }
    //    }
    //    [self.navigationController pushViewController:news animated:YES];
    
}
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    
    
    
}

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    _mapView.showsUserLocation=YES;
    [_mapView updateLocationData:userLocation];
    [_mapView setCenterCoordinate:userLocation.location.coordinate];
    [_locationService stopUserLocationService];
    [self SetBasicLocation:userLocation];
    
}
/******************************************定位成功 *****************************************/
#pragma mark --private Method--定位成功
- (void)didFailToLocateUserWithError:(NSError *)error
{
    // [[[ UIAlertView alloc] initWithTitle:@"" message:@"定位失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil]show];
}

- (void)loadClassData{
    [self showHudInView:self.view hint:@"数据加载..."];
    __weak typeof(self) weakself = self;
    NSString *urlstring = [NSString stringWithFormat:@"/api.php/index/getclass"];
    NSDictionary *parmas = @{@"apikey":APIKEY};
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:urlstring parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"数据 ：%@",responseObject);
        [self hideHud];
        if([[responseObject objectForKey:@"code"]intValue] == 200){
            
            weakself.classList = [[responseObject objectForKey:@"list"] mutableCopy];
            NSDictionary *dic1 = @{@"type":@"1",@"bg_img":@"Wish",@"type_title":@"附近许愿"};
            NSDictionary *dic2 = @{@"type":@"1",@"bg_img":@"AllSelected",@"type_title":@"全部免费"};
            [weakself.classList addObject:dic1];
            [weakself.classList addObject:dic2];
            NSInteger num = weakself.classList.count/3;
            if (weakself.classList.count%3 != 0) {
                num ++;
            }
            weakself.collView.mj_h = num * 40 + (num - 1)*5;
            weakself.height = num * 40 + (num - 1)*5;
            [weakself.table reloadData];
            [weakself.collView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
        NSLog(@"error");
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }else if(section == 1){
        return 300;
    }
    return self.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 1){
        return 30;
    }
    return 0.0001f;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.vInfoBg;
    }else if(section == 1){
        return self.vMapBg;
    }else{
        return self.vCollBg;
    }
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.classList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *data = [self.classList objectAtIndex:indexPath.row];
    
    NSString *ret = [data objectForKey:@"type"];
    if (ret && ![ret isKindOfClass:[NSNull class]]){
        if([ret integerValue] == 1){
            cell.ivBg.image = [UIImage imageNamed:[data objectForKey:@"bg_img"]];
        }
    }else{
        NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEURL,[data objectForKey:@"bg_img"]];
        [cell.ivBg sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    cell.lbText.text = [data objectForKey:@"type_title"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = (ScreenWidth - 20 - 10)/3.0;
    return CGSizeMake(w, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.classList.count >= 2 && indexPath.row == self.classList.count-2) {
        //附近
        NSLog(@"附近");
        [self loadnearby];
    }else if(self.classList.count >= 2 &&  indexPath.row == self.classList.count-1){
        //全部
        NSLog(@"全部");
        [self search:0 with:nil];
        self.tfSearch.text = @"";
    }else{
        NSDictionary *data = [self.classList objectAtIndex:indexPath.row];
        [self search:[[data objectForKey:@"type_id"]integerValue] with:nil];
    }
}


- (void)loadnearby{
    [self showHudInView:self.view hint:@"数据加载..."];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];//@{@"apikey":APIKEY,@"longitude":longitudes,@"latitude":latitudes};
    [dic setObject:APIKEY forKey:@"apikey"];
    NSString *keywords = self.tfSearch.text;
    if (keywords && ![keywords isEqualToString:@""]) {
        [dic setObject:keywords forKey:@"goods_name"];
    }
    
    if(latitudeStr && ![latitudeStr isEqualToString:@""]){
        [dic setObject:latitudeStr forKey:@"latitude"];
    }
    if(longitudeStr && ![longitudeStr isEqualToString:@""]){
        [dic setObject:longitudeStr forKey:@"longitude"];
    }
    
    NSString *url = [NSString stringWithFormat:@"/api.php/index/wish_list"];
    
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideHud];
        array = responseObject[@"list"];
        
        for (int i=0; i<array.count; i++) {
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            NSDictionary *dic = array[i];
            CGFloat longitudeValue = [dic[@"longitude"] floatValue];
            CGFloat latitudeValue = [dic[@"latitude"] floatValue];
            NSString *goodsname = dic[@"goods_name"];
            NSString *ho_number = dic[@"ho_number"];
            //            NSString *goods_id = dic[@"goods_id"];
            annotation.coordinate = CLLocationCoordinate2DMake(latitudeValue,longitudeValue);
            annotation.title = ho_number;
            annotation.subtitle = goodsname;
            //            [_mapView  setCenterCoordinate:annotationModel.coordinate zoomLevel:13 animated:NO];
            [_mapView setCenterCoordinate:annotation.coordinate animated:YES];
            [_mapView addAnnotation:annotation];
            [_mapView mapForceRefresh];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
        [self showHint:@"加载失败!"];
        
    }];
}

- (void)wishClick{
    VCWantWish *vc = [[VCWantWish alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)donateClick{
    VCWantDonate *vc = [[VCWantDonate alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UIView*)vInfoBg{
    if(!_vInfoBg){
        _vInfoBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 34)];
        _vInfoBg.backgroundColor = [UIColor whiteColor];
        [_vInfoBg addSubview:self.lbInfo];
    }
    return _vInfoBg;
}


- (UILabel*)lbInfo{
    if (!_lbInfo) {
        _lbInfo = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth - 20, 15)];
        _lbInfo.text = @"今天我附近有什么是可以免费拿取的？";
        _lbInfo.font = [UIFont systemFontOfSize:14];
    }
    return _lbInfo;
}

- (UIButton*)btnWish{
    if (!_btnWish) {
        _btnWish = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - 50 - 64, ScreenWidth/2.0, 50)];
        [_btnWish setTitle:@"我要许愿" forState:UIControlStateNormal];
        _btnWish.backgroundColor = RGB(254, 0, 0);
        [_btnWish addTarget:self action:@selector(wishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnWish;
}


- (UIButton*)btnDonate{
    if (!_btnDonate) {
        _btnDonate = [[UIButton alloc]initWithFrame:CGRectMake(self.btnWish.mj_w, self.btnWish.mj_y, self.btnWish.mj_w, self.btnWish.mj_h)];
        [_btnDonate setTitle:@"我要捐赠" forState:UIControlStateNormal];
        [_btnDonate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnDonate.backgroundColor = [UIColor yellowColor];
        [_btnDonate addTarget:self action:@selector(donateClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDonate;
}

- (UIView*)vBg{
    if(!_vBg){
        _vBg = [[UIView alloc]initWithFrame:CGRectMake(60, 5, ScreenWidth - 120, 34)];
        _vBg.layer.cornerRadius = 17.f;
        _vBg.layer.masksToBounds = YES;
        _vBg.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        [_vBg addSubview:self.tfSearch];
    }
    return _vBg;
}

- (UITextField*)tfSearch{
    if (!_tfSearch) {
        _tfSearch = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, self.vBg.mj_w - 20, self.vBg.mj_h)];
        _tfSearch.placeholder = @"请输入赠品名称";
        _tfSearch.delegate = self;
    }
    return _tfSearch;
}

- (UITableView*)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 50) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = [UIColor whiteColor];
        _table.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.showsVerticalScrollIndicator = NO;
    }
    return _table;
}

- (UIView*)vMapBg{
    if(!_vMapBg){
        _vMapBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 34)];
        _vMapBg.backgroundColor = [UIColor whiteColor];
        [_vMapBg addSubview:self.mapView];
    }
    return _vMapBg;
}

- (BMKMapView*)mapView{
    
    if (!_mapView) {
        _mapView =[[ BMKMapView alloc] initWithFrame:CGRectMake(10, 0,ScreenWidth-20, 300)];
        _mapView.mapType=BMKMapTypeStandard;
        _mapView.userTrackingMode=BMKUserTrackingModeFollow;
        _mapView.zoomLevel = 14;
        _mapView.minZoomLevel = 10;
        _mapView.delegate=self;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}


- (UIView*)vCollBg{
    if(!_vCollBg){
        _vCollBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 34)];
        _vCollBg.backgroundColor = [UIColor whiteColor];
        [_vCollBg addSubview:self.collView];
    }
    return _vCollBg;
}


- (UICollectionView*)collView{
    if (!_collView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        CGRect r = CGRectMake(10, 0, ScreenWidth-20, 100);
        _collView = [[UICollectionView alloc]initWithFrame:r collectionViewLayout:layout];
        _collView.delegate = self;
        _collView.dataSource = self;
        _collView.backgroundColor = [UIColor clearColor];
        [_collView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    return _collView;
}

@end
