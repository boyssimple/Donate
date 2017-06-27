//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VCMyProfile.h"
#import "CellDownSelection.h"
#import "CustomAlertView.h"
#import "BDImagePicker.h"
#import "RXJDAddressPickerView.h"
#import "JXAlertview.h"

@interface VCMyProfile ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;
@property (nonatomic, strong) NSArray *contactList;

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *contactType;//联系方式
@property (nonatomic, assign) NSInteger contactTypeId;
@property (nonatomic, strong) NSString *contactText;//联系方式
@property (nonatomic, strong) NSString *myAddress;//我的地址
@property (nonatomic, strong) NSString *detailAddress;//详细地址
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSString *pCode;
@property (nonatomic, strong) NSString *cCode;
@property (nonatomic, strong) NSString *aCode;
@property (nonatomic, strong) RXJDAddressPickerView *threePicker;
@end

@implementation VCMyProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"我的资料";
    
    
    self.threePicker = [[RXJDAddressPickerView alloc]init];
    [self.view addSubview:self.threePicker];
    __weak typeof(self) weakSelf = self;
    self.threePicker.completion = ^(NSString *province, NSString *city, NSString *area, NSString *provinceCode, NSString *cityCode, NSString *areaCode){
        weakSelf.pCode = provinceCode;
        weakSelf.cCode = cityCode;
        weakSelf.aCode = areaCode;
        weakSelf.myAddress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        CellDownSelection*cell = (CellDownSelection*)[weakSelf.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        [cell updateData:weakSelf.myAddress withType:9];
    };
}

- (void)loadContacts{
    self.contactList = @[@{@"type_id":@"1",@"type_title":@"微信"},@{@"type_id":@"2",@"type_title":@"QQ"},@{@"type_id":@"3",@"type_title":@"手机"}];
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:self.contactList.count];
    for (NSDictionary *dic in self.contactList) {
        [titleArray addObject:[dic objectForKey:@"type_title"]];
    }
    
    CustomAlertView *action = [[CustomAlertView alloc]initWithActions:titleArray withTitle:@"选择联系方式" withBlock:^(NSInteger btnIndex) {
        NSDictionary *data = [self.contactList objectAtIndex:btnIndex];
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        [cell updateData:[data objectForKey:@"type_title"] withType:2];
        cell.tfSecondText.userInteractionEnabled = YES;
        self.contactType = [data objectForKey:@"type_title"];
        self.contactTypeId = [[data objectForKey:@"type_id"]integerValue];
    }];
    [action show];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return [CellDownSelection calHeight:2];
    }else if(indexPath.row == 6){
        return [CellDownSelection calHeight:6];
    }else if(indexPath.row == 0){
        return [CellDownSelection calHeight:7];
    }else if(indexPath.row == 4){
        return [CellDownSelection calHeight:9];
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
    [cell.tfText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row == 0) {
        cell.title = @"头像";
        cell.type = 7;
        if (self.img) {
            cell.ivPhoto.image = self.img;
        }
    }else if (indexPath.row == 1) {
        cell.title = @"公司名称";
        cell.type = 1;
        cell.tfText.tag = 100;
        [cell updateData:self.companyName withType:1];
    }else if (indexPath.row == 2) {
        cell.title = @"电话号码";
        cell.type = 1;
        cell.tfText.tag = 101;
        [cell updateData:self.companyName withType:1];
    }else if (indexPath.row == 3) {
        cell.title = @"联系方式";
        cell.type = 2;
        [cell.tfSecondText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.tfSecondText.tag = 102;
        [cell updateData:self.contactType withType:0];
        cell.tfSecondText.text = self.contactText;
    }else if (indexPath.row == 4) {
        cell.title = @"我的地址";
        cell.type = 9;
        cell.tfText.tag = 104;
        [cell updateData:self.myAddress withType:9];
    }else if (indexPath.row == 5) {
        cell.type = 1;
        cell.title = @"详细地址";
        cell.tfText.tag = 105;
        [cell updateData:self.detailAddress withType:1];
    }else if (indexPath.row == 6) {
        cell.type = 6;
        cell.title = @"推荐这款APP给身边的人一起来帮助需要帮助的人！";
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

- (void)selectCell:(NSInteger)type with:(NSIndexPath *)index{
    NSLog(@"%zi",type);
    [self.view endEditing:YES];
    if (type == 0) {
        if (index.row == 3) {
            [self loadContacts];
        }else if(index.row == 4){
            [self getProvince];
        }
    }else if(type == 3){
        self.selected = !self.selected;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (indexPath.row == 0) {
        [self selectImg];
    }
}

- (void)selectImg{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            self.img = image;
            [self.table reloadData];
        }
    }];
}

- (void)textFieldDidChange:(UITextField*)textField{
    if (textField.tag == 100) {
        self.companyName = textField.text;
    }else if (textField.tag == 101) {
        self.phone = textField.text;
    }else if (textField.tag == 102) {
        self.contactText = textField.text;
    }else if (textField.tag == 103) {
        self.contactText = textField.text;
    }else if (textField.tag == 104) {
        self.myAddress = textField.text;
    }else if (textField.tag == 105) {
        self.detailAddress = textField.text;
    }
}

- (void)submitClick{
    [self.view endEditing:YES];
    [self showHudInView:self.view hint:@"数据处理..."];
    
    
    NSData *data = UIImagePNGRepresentation(self.img);
    NSDictionary *dict = @{@"apikey":APIKEY,
                           @"user_id":@"378",
                           @"user_name":self.companyName,
                           @"user_phone":self.phone,
                           @"contact_type":@(self.contactTypeId),
                           @"contact_number":self.contactText,
                           @"u_province":self.pCode,
                           @"u_city":self.cCode,
                           @"u_area":self.aCode,
                           @"address":self.detailAddress,
                           @"is_reco":@(self.selected)};
    NSString     *urlString = [NSString stringWithFormat:@"%@",@"/api.php/index/u_info"];
    
    [[RequsetPostTool requestNewWorkWithBaseURL] POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"graphic" fileName:@"headImage.png" mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [self showHint:@"提交成功!"];
        }else {
            NSLog(@"%@",responseObject[@"msg"]);
            [self showHint:@"提交失败!"];
        }
        [self hideHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"提交失败!"];
        [self hideHud];
    }];
}

- (UITableView*)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 40) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = RGB3(241);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _table.showsVerticalScrollIndicator = NO;
    }
    return _table;
}

- (UIButton*)btnSubmit{
    if(!_btnSubmit){
        _btnSubmit = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWidth, 40)];
        _btnSubmit.backgroundColor = RGB(254, 0, 0);
        [_btnSubmit setTitle:@"保存" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

@end
