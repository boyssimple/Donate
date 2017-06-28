//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VipDataViewController.h"
#import "CellDownSelection.h"
#import "VCWantGet.h"
#import "CustomAlertView.h"
#import "BDImagePicker.h"
#import "CWStarRateView.h"
#import "RXJDAddressPickerView.h"
#import "JXAlertview.h"
#import "CustomDatePicker.h"
#import "AFHTTPSessionManager.h"
#import "VCGoodsDetail.h"
#import "MapViewController.h"

@interface VipDataViewController ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate,UITextFieldDelegate,CWStarRateViewDelegate,CustomAlertDelegete>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;
@property (nonatomic, strong) NSArray *classList;
@property (nonatomic, strong) NSArray *cateList;
@property (nonatomic, strong) NSArray *contactList;

//数据
@property (nonatomic, strong) NSString *donateType;//捐赠类别
@property (nonatomic, assign) NSInteger donateTypeId;
@property (nonatomic, strong) NSString *cateType;//捐赠类型
@property (nonatomic, assign) NSInteger cateTypeId;
@property (nonatomic, strong) NSString *donateName;//捐赠名称
@property (nonatomic, strong) NSString *companyName;//公司名称
@property (nonatomic, strong) NSString *contactType;//联系方式
@property (nonatomic, assign) NSInteger contactTypeId;
@property (nonatomic, strong) NSString *contactText;//联系方式
@property (nonatomic, strong) NSString *getTime;//拿取时间
@property (nonatomic, strong) NSString *resultTime;//结果时间
@property (nonatomic, strong) NSString *myAddress;//我的地址
@property (nonatomic, strong) NSString *detailAddress;//详细地址
@property (nonatomic, strong) UIImage *img;//上传图片


@property (nonatomic, assign) CGFloat oldLevel;
@property (nonatomic, assign) CGFloat useLevel;
@property (nonatomic, assign) CGFloat clearLevel;
@property (nonatomic, strong) NSString *pCode;
@property (nonatomic, strong) NSString *cCode;
@property (nonatomic, strong) NSString *aCode;
@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong)RXJDAddressPickerView *threePicker;
@property (nonatomic, strong) CustomDatePicker *Dpicker;

@end

@implementation VipDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"会员资料";
    self.contactType = @"请选择联系方式";
    
    self.threePicker = [[RXJDAddressPickerView alloc]init];
    [self.view addSubview:self.threePicker];
    __weak typeof(self) weakSelf = self;
    self.threePicker.completion = ^(NSString *province, NSString *city, NSString *area, NSString *provinceCode, NSString *cityCode, NSString *areaCode){
        weakSelf.pCode = provinceCode;
        weakSelf.cCode = cityCode;
        weakSelf.aCode = areaCode;
        weakSelf.myAddress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        CellDownSelection*cell = (CellDownSelection*)[weakSelf.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
        [cell updateData:weakSelf.myAddress withType:9];
    };
    
    
   self.Dpicker = [[CustomDatePicker alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width-20, 200)];
}

/**
 * 加载捐赠类别
 */
- (void)loadClassData{
    if (self.classList.count > 0) {
        [self showClassMenu];
        return;
    }
    [self showHudInView:self.view hint:@"数据加载..."];
    __weak typeof(self) weakself = self;
    NSString *urlstring = [NSString stringWithFormat:@"/api.php/index/getclass"];
    NSDictionary *parmas = @{@"apikey":APIKEY};
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:urlstring parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"数据 ：%@",responseObject);
        [self hideHud];
        if([[responseObject objectForKey:@"code"]intValue] == 200){
            weakself.classList = [responseObject objectForKey:@"list"];
            [weakself showClassMenu];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
        NSLog(@"error");
    }];
}

- (void)showClassMenu{
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:self.classList.count];
    for (NSDictionary *dic in self.classList) {
        [titleArray addObject:[dic objectForKey:@"type_title"]];
    }
    
    CustomAlertView *action = [[CustomAlertView alloc]initWithActions:titleArray withTitle:@"选择捐赠类别" withBlock:^(NSInteger btnIndex) {
        NSDictionary *data = [self.classList objectAtIndex:btnIndex];
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell updateData:[data objectForKey:@"type_title"] withType:0];
        self.donateType = [data objectForKey:@"type_title"];
        self.donateTypeId = [[data objectForKey:@"type_id"]integerValue];
    }];
    [action show];
}

/**
 * 加载捐赠类型
 */
- (void)loadCateData{
    [self showHudInView:self.view hint:@"数据加载..."];
    __weak typeof(self) weakself = self;
    NSString *urlstring = [NSString stringWithFormat:@"/api.php/index/getclass"];
    NSDictionary *parmas = @{@"apikey":APIKEY,@"type_id":@(self.donateTypeId)};
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:urlstring parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"数据 ：%@",responseObject);
        [self hideHud];
        if([[responseObject objectForKey:@"code"]intValue] == 200){
            weakself.cateList = [responseObject objectForKey:@"list"];
            [weakself showCateMenu];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
        NSLog(@"error");
    }];
}

- (void)showCateMenu{
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:self.cateList.count];
    for (NSDictionary *dic in self.cateList) {
        [titleArray addObject:[dic objectForKey:@"type_title"]];
    }
    
    CustomAlertView *action = [[CustomAlertView alloc]initWithActions:titleArray withTitle:@"选择捐赠类型" withBlock:^(NSInteger btnIndex) {
        NSDictionary *data = [self.cateList objectAtIndex:btnIndex];
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [cell updateData:[data objectForKey:@"type_title"] withType:0];
        self.cateType = [data objectForKey:@"type_title"];
        self.cateTypeId = [[data objectForKey:@"type_id"]integerValue];
    }];
    [action show];
}

- (void)loadContacts{
    self.contactList = @[@{@"type_id":@"1",@"type_title":@"微信"},@{@"type_id":@"2",@"type_title":@"QQ"},@{@"type_id":@"3",@"type_title":@"手机"}];
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:self.contactList.count];
    for (NSDictionary *dic in self.contactList) {
        [titleArray addObject:[dic objectForKey:@"type_title"]];
    }
    
    CustomAlertView *action = [[CustomAlertView alloc]initWithActions:titleArray withTitle:@"选择联系方式" withBlock:^(NSInteger btnIndex) {
        NSDictionary *data = [self.contactList objectAtIndex:btnIndex];
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        [cell updateData:[data objectForKey:@"type_title"] withType:2];
        cell.tfSecondText.userInteractionEnabled = YES;
        self.contactType = [data objectForKey:@"type_title"];
        self.contactTypeId = [[data objectForKey:@"type_id"]integerValue];
    }];
    [action show];
}

- (void)selectImg{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            self.img = image;
            [self.table reloadData];
        }
    }];
}

#pragma mark -- 地址选择器

- (void)getProvince{
    
    NSString *urlstring = [NSString stringWithFormat:@"http://www.youpai365.com/api/provincial_city"];
    NSDictionary *parmas = @{@"appkey":APIKEY};
    __weak typeof(self) weakself = self;

    [[RequsetPostTool requestNewWorkWithBaseURL]POST:urlstring parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"结果：%@",responseObject);
        NSArray *listArray = responseObject[@"list"];
        [weakself reloadPickerProvince:listArray];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error：%@",error);
        NSLog(@"error");
    }];
}

- (void)reloadPickerProvince:(NSArray*)provinces{
    [self.threePicker loadProvinceDatas:provinces];
    [self.threePicker showAddress];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 10;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            return [CellDownSelection calHeight:2];
        }else if(indexPath.row == 9){
            return [CellDownSelection calHeight:3];
        }else if(indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7){
            return [CellDownSelection calHeight:9];
        }
    }else if(indexPath.section == 1){
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
        
        [cell.tfText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if (indexPath.row == 0) {
            cell.title = @"捐赠类别";
            cell.type = 0;
            [cell updateData:self.donateType withType:0];
        }else if (indexPath.row == 1) {
            cell.title = @"捐赠类型";
            cell.type = 0;
            [cell updateData:self.cateType withType:0];
        }else if (indexPath.row == 2) {
            cell.title = @"捐赠名称";
            cell.type = 1;
            [cell updateData:self.donateName withType:0];
            cell.tfText.tag = 100;
        }else if (indexPath.row == 3) {
            cell.title = @"公司名称";
            cell.type = 1;
            [cell updateData:self.companyName withType:0];
            cell.tfText.tag = 101;
        }else if (indexPath.row == 4) {
            cell.title = @"联系方式";
            cell.type = 2;
            [cell updateData:self.contactType withType:0];
            if (self.contactTypeId == 0) {
                cell.tfSecondText.userInteractionEnabled = NO;
            }else{
                cell.tfSecondText.userInteractionEnabled = YES;
            }
            [cell.tfSecondText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            cell.tfSecondText.tag = 102;
        }else if (indexPath.row == 5) {
            cell.title = @"拿取时间";
            cell.type = 9;
            [cell updateData:self.getTime withType:0];
            cell.tfText.tag = 103;
        }else if (indexPath.row == 6) {
            cell.title = @"结果时间";
            cell.type = 9;
            [cell updateData:self.resultTime withType:0];
            cell.tfText.tag = 104;
        }else if (indexPath.row == 7) {
            cell.title = @"我的地址";
            cell.type = 9;
            [cell updateData:self.myAddress withType:0];
        }else if (indexPath.row == 8) {
            cell.title = @"详细地址";
            cell.type = 1;
            [cell updateData:self.detailAddress withType:0];
            cell.tfText.tag = 106;
        }else if (indexPath.row == 9) {
            cell.title = @"上传图片";
            if (self.img) {
                cell.type = 8;
                cell.ivImage.image = self.img;
            }else{
                cell.type = 3;
            }
        }
        [cell hiddenLine:NO];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.title = @"新旧程度";
            cell.type = 4;
            cell.starRateView.tag = 200;
        }else if (indexPath.row == 1) {
            cell.title = @"使用频率";
            cell.type = 4;
            cell.starRateView.tag = 201;
        }else if (indexPath.row == 2) {
            cell.title = @"干净程度";
            cell.type = 4;
            cell.starRateView.tag = 202;
        }
        [cell hiddenLine:YES];
        cell.starRateView.delegate = self;
    }
    cell.index = indexPath;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

- (void)submitClick{
    /*
    [self.view endEditing:YES];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas setValue:APIKEY forKey:@"apikey"];
    NSLog(@"拿取时间:%@",self.getTime);
    if (self.donateTypeId == 0) {
        Alert(@"请选择捐赠类别");
        return;
    }
    
    if (self.cateTypeId == 0) {
        Alert(@"请选择捐赠类型");
        return;
    }
    
    if (self.donateName.length < 3) {
        Alert(@"请填写捐赠名称");
        return;
    }
    
    if (self.companyName.length < 2) {
        Alert(@"请填写公司/名字");
        return;
    }
    
    if (self.contactText.length < 6) {
        Alert(@"请填写联系方式");
        return;
    }
    
    if (self.getTime.length < 1) {
        Alert(@"请填写拿取时间");
        return;
    }
    if (self.resultTime.length < 1) {
        Alert(@"请填写结束时间");
        return;
    }
    if (self.aCode == nil ||  [NSString stringWithFormat:@"%@",self.aCode].length == 0) {
        Alert(@"请填写我的地址");
        return;
    }
    if (self.detailAddress.length < 5) {
        Alert(@"请填写详细地址");
        return;
    }
    
    if (!self.img) {
        Alert(@"请选择上传图片");
        return;
    }
    
    if (self.oldLevel <= 0) {
        Alert(@"请选择新旧程度");
        return;
    }
    if (self.useLevel <= 0) {
        Alert(@"请选择使用频率");
        return;
    }
    if (self.clearLevel <= 0) {
        Alert(@"请选择干净程度");
        return;
    }
    
    
    [self showHudInView:self.view hint:@"数据处理..."];
    
    
    NSData *data = UIImagePNGRepresentation(self.img);
    NSDictionary *dict = @{@"apikey":APIKEY,
                           @"type_id":@(self.donateTypeId),
                           @"c_type_id":@(self.cateTypeId),
                           @"goods_name":self.donateName,
                           @"user_name":self.companyName,
                           @"contact_type":@(self.contactTypeId),
                           @"contact_number":self.contactText,
                           @"take_time":self.getTime,
                           @"end_time":self.resultTime,
                           @"u_province":self.pCode,
                           @"u_city":self.cCode,
                           @"u_area":self.aCode,
                           @"address":self.detailAddress,
                           @"old_new":@(self.oldLevel),
                           @"fre_use":@(self.useLevel),
                           @"cle_lin":@(self.clearLevel)};
    NSString     *urlString = [NSString stringWithFormat:@"%@",@"/api.php/index/user_add"];
    
    [[RequsetPostTool requestNewWorkWithBaseURL] POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"graphic" fileName:@"headImage.png" mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            self.userId = [responseObject objectForKey:@"user_id"];
            
            
            [self showHint:@"提交成功!"];
            
            
            
            MapViewController *vc = [[MapViewController alloc]init];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = vc;
        }else {
            NSLog(@"%@",responseObject[@"msg"]);
            [self showHint:@"提交失败!"];
        }
        [self hideHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"提交失败!"];
        [self hideHud];
    }];
     */
    
    
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        
//        
//        VCMap *vc = [[VCMap alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        window.rootViewController = nav;
//    });
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        
        UIViewController *vc = [[UIViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = nav;
    });
     
     
}

- (void)selectCell:(NSInteger)type with:(NSIndexPath *)index{
    NSLog(@"%zi",type);
    if(type == 0 || type == 1){
        if (index.row == 0) {
            [self loadClassData];
        }else if(index.row == 1){
            if(self.donateTypeId == 0){
                Alert(@"请选择捐赠类别");
                return;
            }
            [self loadCateData];
        }else if(index.row == 4){
            [self loadContacts];
        }else if(index.row == 9){
            [self selectImg];
        }else if(index.row == 7){
            [self getProvince];
        }else if(index.row == 5){
            [self showDate:300];
        }else if(index.row == 6){
            [self showDate:301];
        }
        
    }else if(type == 2){
        if (index.row == 9) {
            self.img = nil;
            [self.table reloadData];
        }
    }
    
}

- (void)showDate:(NSInteger)tag{
    JXAlertview *alert = [[JXAlertview alloc] initWithFrame:CGRectMake(10, (ScreenHeight-260)/2, ScreenWidth-20, 260)];
    //alert.image = [UIImage imageNamed:@"dikuang"];
    alert.delegate = self;
    alert.tag = tag;
    [alert initwithtitle:@"请选择日期" andmessage:@"" andcancelbtn:@"取消" andotherbtn:@"确定"];
    
    //我把Dpicker添加到一个弹出框上展现出来 当然大家还是可以以任何其他动画形式展现
    [alert addSubview:self.Dpicker];
    [alert show];
}

-(void)btnindex:(int)index :(int) tag{
    if (tag == 300 && index == 2) {
        self.getTime = [NSString stringWithFormat:@"%d-%2d-%2d",self.Dpicker.year,self.Dpicker.month,self.Dpicker.day];
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        [cell updateData:self.getTime withType:9];
    }else if(tag == 301 && index == 2){
        self.resultTime = [NSString stringWithFormat:@"%d-%2d-%2d",self.Dpicker.year,self.Dpicker.month,self.Dpicker.day];
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
        [cell updateData:self.resultTime withType:9];
    }
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    if (starRateView.tag == 200) {
        self.oldLevel = newScorePercent;
    }else if (starRateView.tag == 201) {
        self.useLevel = newScorePercent;
    }else if (starRateView.tag == 202) {
        self.clearLevel = newScorePercent;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{

}

- (void)textFieldDidChange:(UITextField*)textField{
    if (textField.tag == 100) {
        self.donateName = textField.text;
    }else if (textField.tag == 101) {
        self.companyName = textField.text;
    }else if (textField.tag == 102) {
        self.contactText = textField.text;
    }else if (textField.tag == 103) {
        self.getTime = textField.text;
    }else if (textField.tag == 104) {
        self.resultTime = textField.text;
    }else if (textField.tag == 105) {
        self.myAddress = textField.text;
    }else if (textField.tag == 106) {
        self.detailAddress = textField.text;
    }
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
        [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

@end
