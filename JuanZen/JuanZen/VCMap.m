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


@interface VCMap ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate>
{
    
    NSArray *array;
    
    UIView                       *_bottomView;
    NSMutableArray               *_mapAnnotationArray;
    NSMutableArray               *_listArray;
    BMKMapView                   *_mapView;//地图对象
    BMKLocationService           *_locationService;//定位
    BMKPoiSearch                 *_poiSearch;//检索
    BMKGeoCodeSearch             *_citySearchOption;
    NSString *longitude;//经度
    NSString *latitude;//纬度
    
    
}
@property (nonatomic, strong) UILabel *lbInfo;
@property (nonatomic, strong) UIButton *btnWish;
@property (nonatomic, strong) UIButton *btnDonate;
@end

@implementation VCMap

- (void)viewWillAppear:(BOOL)animated
{
    if (_locationService != nil) {
        [_locationService startUserLocationService];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_locationService stopUserLocationService];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"共享免费资源";
    [self.view addSubview:self.lbInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    _mapAnnotationArray=[[ NSMutableArray alloc] init];
    _listArray=[[ NSMutableArray alloc] init];
    [self initMapView];//初始化地图
    [self initlocationService];
    
    [self.view addSubview:self.btnWish];
    [self.view addSubview:self.btnDonate];
}



-(void)SetBasicLocation:(BMKUserLocation *)location{
    
    NSString * latitudes = [NSString stringWithFormat:@"%f",location.location.coordinate.latitude];
    NSString * longitudes = [NSString stringWithFormat:@"%f",location.location.coordinate.longitude];
    NSDictionary *dic = @{@"apikey":APIKEY,@"longitude":longitudes,@"latitude":latitudes};
    NSString *url = [NSString stringWithFormat:@"/api.php/index/g_list"];
    //    NSDictionary *dic = @{@"appkey":APIKEY,@"longitude":@"106.530721",@"latitude":@"29.533453"};
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
}

#pragma mark --private Method--定位
-(void)initlocationService{
    
    _locationService=[[BMKLocationService alloc] init];
    _locationService.desiredAccuracy=kCLLocationAccuracyBest;
    _locationService.delegate=self;
    _locationService.distanceFilter=1000;
    [_locationService startUserLocationService];
    
}
#pragma mark --private Method--初始化地图
-(void)initMapView{
    
    BMKMapView  *mapView=[[ BMKMapView alloc] initWithFrame:CGRectMake(10, 75 + 44,ScreenWidth-20, 300)];
    mapView.mapType=BMKMapTypeStandard;
    mapView.userTrackingMode=BMKUserTrackingModeFollow;
    mapView.zoomLevel=14;
    mapView.minZoomLevel=10;
    mapView.delegate=self;
    _mapView=mapView;
    [self.view addSubview:mapView];
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

- (void)wishClick{
    VCWantWish *vc = [[VCWantWish alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)donateClick{
    VCWantDonate *vc = [[VCWantDonate alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UILabel*)lbInfo{
    if (!_lbInfo) {
        _lbInfo = [[UILabel alloc]initWithFrame:CGRectMake(10, 20+64, ScreenWidth - 20, 15)];
        _lbInfo.text = @"今天我附近有什么是可以免费拿取的？";
        _lbInfo.font = [UIFont systemFontOfSize:14];
    }
    return _lbInfo;
}

- (UIButton*)btnWish{
    if (!_btnWish) {
        _btnWish = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - 50, ScreenWidth/2.0, 50)];
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
@end
