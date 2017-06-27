//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VCWantWish.h"
#import "CellDownSelection.h"
#import "CustomAlertView.h"
#import "RXJDAddressPickerView.h"
#import "JXAlertview.h"
#import "CustomDatePicker.h"

@interface VCWantWish ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate,CustomAlertDelegete,UITextViewDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;
@property (nonatomic, strong) NSArray *classList;
@property (nonatomic, strong) NSArray *cateList;
@property (nonatomic, strong) NSArray  *contactList;


@property (nonatomic, strong) NSString *donateType;//捐赠类别
@property (nonatomic, assign) NSInteger donateTypeId;
@property (nonatomic, strong) NSString *cateType;//捐赠类型
@property (nonatomic, assign) NSInteger cateTypeId;

@property (nonatomic, strong) NSString *contactType;//联系方式
@property (nonatomic, assign) NSInteger contactTypeId;
@property (nonatomic, strong) NSString *contactText;//联系方式
@property (nonatomic, strong) NSString *startDate;//希望时间-开始
@property (nonatomic, strong) NSString *endDate;//希望时间-结束
@property (nonatomic, strong) NSString *wishDate;//希望时间
@property (nonatomic, strong) NSString *remark;//备注

@property (nonatomic, strong)RXJDAddressPickerView *threePicker;
@property (nonatomic, strong) CustomDatePicker *Dpicker;
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, assign) BOOL selected;
@end

@implementation VCWantWish

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"我要许愿";
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
    
    CustomAlertView *action = [[CustomAlertView alloc]initWithActions:titleArray withTitle:@"选择心愿类别" withBlock:^(NSInteger btnIndex) {
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
    
    CustomAlertView *action = [[CustomAlertView alloc]initWithActions:titleArray withTitle:@"选择心愿类型" withBlock:^(NSInteger btnIndex) {
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
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        [cell updateData:[data objectForKey:@"type_title"] withType:2];
        cell.tfSecondText.userInteractionEnabled = YES;
        self.contactType = [data objectForKey:@"type_title"];
        self.contactTypeId = [[data objectForKey:@"type_id"]integerValue];
    }];
    [action show];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return [CellDownSelection calHeight:2];
    }else if(indexPath.row == 4){
        return [CellDownSelection calHeight:5];
    }else if(indexPath.row == 5){
        return [CellDownSelection calHeight:6];
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
    if (indexPath.row == 0) {
        cell.title = @"心愿类别";
        cell.type = 0;
        [cell updateData:self.donateType withType:0];
    }else if (indexPath.row == 1) {
        cell.title = @"心愿类型";
        cell.type = 0;
        [cell updateData:self.cateType withType:0];
    }else if (indexPath.row == 2) {
        cell.title = @"联系方式";
        cell.type = 2;
        [cell updateData:self.contactType withType:0];
        if (self.contactTypeId == 0) {
            cell.tfSecondText.userInteractionEnabled = NO;
        }else{
            cell.tfSecondText.userInteractionEnabled = YES;
        }
        cell.tfSecondText.text = self.contactText;
        [cell.tfSecondText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.tfSecondText.tag = 100;
    }else if (indexPath.row == 3) {
        cell.title = @"希望时间";
        cell.type = 9;
        [cell updateData:self.wishDate withType:9];
    }else if (indexPath.row == 4) {
        cell.title = @"备注";
        cell.type = 5;
        [cell updateData:self.remark withType:5];
        cell.textView.delegate = self;
    }else if (indexPath.row == 5) {
        cell.type = 6;
        cell.title = @"我要打上“万分感激”在地图上";
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
    if(type == 0 || type == 1){
        if (index.row == 0) {
            [self loadClassData];
        }else if(index.row == 1){
            if(self.donateTypeId == 0){
                Alert(@"请选择心愿类别");
                return;
            }
            [self loadCateData];
        }else if(index.row == 2){
            [self loadContacts];
        }else if(index.row == 3){
            [self showDate];
        }
        
    }else if(type == 3){
        self.selected = !self.selected;
    }
}

- (void)showDate{
    JXAlertview *alert = [[JXAlertview alloc] initWithFrame:CGRectMake(10, (ScreenHeight-260)/2, ScreenWidth-20, 260)];
    alert.delegate = self;
    [alert initwithtitle:@"请选择日期" andmessage:@"" andcancelbtn:@"取消" andotherbtn:@"确定"];
    alert.tag = 100;
    [alert addSubview:self.Dpicker];
    [alert show];
}

-(void)btnindex:(int)index :(int) tag{
    if (index == 2) {
        if (self.times == 0) {
            self.startDate =  [NSString stringWithFormat:@"%d-%2d-%2d",self.Dpicker.year,self.Dpicker.month,self.Dpicker.day];
            self.times = 1;
            self.wishDate = [NSString stringWithFormat:@"%@到",self.startDate];
        }else if(self.times == 1){
            self.endDate = [NSString stringWithFormat:@"%d-%2d-%2d",self.Dpicker.year,self.Dpicker.month,self.Dpicker.day];
            self.times = 0;
            self.wishDate = [NSString stringWithFormat:@"%@到%@",self.startDate,self.endDate];
        }
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        [cell updateData:self.wishDate withType:9];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField*)textField{
    if (textField.tag == 100) {
        self.contactText = textField.text;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.remark = textView.text;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)submitClick{
     [self.view endEditing:YES];
    
     if (self.donateTypeId == 0) {
         Alert(@"请选择心愿类别");
         return;
     }
     
     if (self.cateTypeId == 0) {
         Alert(@"请选择心愿类型");
         return;
     }
    
     if (self.contactText.length < 6) {
         Alert(@"请填写联系方式");
         return;
     }
     
     if (self.startDate.length < 1) {
         Alert(@"请填写希望开始时间");
         return;
     }
     if (self.endDate.length < 1) {
         Alert(@"请填写希望结束时间");
         return;
     }
     if (self.remark.length < 5) {
         Alert(@"请填写备注");
         return;
     }
    
     [self showHudInView:self.view hint:@"数据处理..."];
     
    
     NSDictionary *parmas = @{@"apikey":APIKEY,
                              @"type_id":@(self.donateTypeId),
                              @"c_type_id":@(self.cateTypeId),
                              @"contact_type":@(self.contactTypeId),
                              @"contact_number":self.contactText,
                              @"is_map":@(self.selected),
                              @"start_time":self.startDate,
                              @"end_time":self.endDate,
                              @"remarks":self.remark};
     NSString     *urlString = [NSString stringWithFormat:@"%@",@"/api.php/index/add_wish"];
    [[RequsetPostTool requestNewWorkWithBaseURL]POST:urlString parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"数据 ：%@",responseObject);
        [self hideHud];
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [self showHint:@"提交成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"%@",responseObject[@"msg"]);
            [self showHint:@"提交失败!"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
        [self showHint:@"提交失败!"];
        NSLog(@"error");
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
        [_btnSubmit setTitle:@"确定" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

@end
