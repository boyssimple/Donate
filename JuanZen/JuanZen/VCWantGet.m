//
//  VipDataViewController.m
//  Donate
//
//  Created by yibyi on 2017/6/26.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "VCWantGet.h"
#import "CellDownSelection.h"
#import "CellWantGet.h"
#import "VCGoodsDetail.h"
#import "CustomAlertView.h"

#import "CWStarRateView.h"
#import "RXJDAddressPickerView.h"
#import "JXAlertview.h"
#import "CustomDatePicker.h"

@interface VCWantGet ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate,CWStarRateViewDelegate,CustomAlertDelegete>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;
@property (nonatomic, strong) NSArray *contactList;

@property (nonatomic, assign) BOOL isContact;
@property (nonatomic, assign) BOOL isWoContact;
@property (nonatomic, assign) BOOL isThanks;
@property (nonatomic, strong) NSString *name;//名称
@property (nonatomic, strong) NSString *contactType;//联系方式
@property (nonatomic, assign) NSInteger contactTypeId;
@property (nonatomic, strong) NSString *contactText;//联系方式
@property (nonatomic, strong) NSString *startTime;//拿取时间
@property (nonatomic, strong) NSString *endTime;//结果时间
@property (nonatomic, assign) CGFloat evaluate;//评论
@property (nonatomic, strong) CustomDatePicker *Dpicker;

@end

@implementation VCWantGet

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"我要拿取";
    self.Dpicker = [[CustomDatePicker alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width-20, 200)];
}

- (void)loadContacts{
    self.contactList = @[@{@"type_id":@"1",@"type_title":@"微信"},@{@"type_id":@"2",@"type_title":@"QQ"},@{@"type_id":@"3",@"type_title":@"手机"}];
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:self.contactList.count];
    for (NSDictionary *dic in self.contactList) {
        [titleArray addObject:[dic objectForKey:@"type_title"]];
    }
    
    CustomAlertView *action = [[CustomAlertView alloc]initWithActions:titleArray withTitle:@"选择联系方式" withBlock:^(NSInteger btnIndex) {
        NSDictionary *data = [self.contactList objectAtIndex:btnIndex];
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        [cell updateData:[data objectForKey:@"type_title"] withType:2];
        cell.tfSecondText.userInteractionEnabled = YES;
        self.contactType = [data objectForKey:@"type_title"];
        self.contactTypeId = [[data objectForKey:@"type_id"]integerValue];
    }];
    [action show];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 11;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 6) {
        return [CellWantGet calHeight:0];
    }else if(indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 9){
        return [CellDownSelection calHeight:6];
    }else if(indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 8){
        return [CellDownSelection calHeight:1];
    }else if(indexPath.row == 5){
        return [CellDownSelection calHeight:2];
    }else if(indexPath.row == 2){
        return [CellWantGet calHeight:1];
    }
    return [CellDownSelection calHeight:4];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 6 || indexPath.row == 2) {
        
        static NSString *identfiter = @"Cell";
        CellWantGet *cell = [tableView dequeueReusableCellWithIdentifier:identfiter];
        if (!cell) {
            cell = [[CellWantGet alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfiter];
        }
        if (indexPath.row == 0) {
            cell.type = 0;
            cell.title = @"您选择了拿免费的捐赠物，请跟着以下步骤：";
            
        }else if(indexPath.row == 2){
            cell.type = 1;
            [cell updateData:[self.data objectForKey:@"u_info"]];
        }else if(indexPath.row == 6){
            cell.type = 0;
            cell.title = @"我可以在这个时间里拿取";
        }
        return cell;
    } else{
        
        static NSString *identfiter = @"CellDownSelection";
        CellDownSelection *cell = [tableView dequeueReusableCellWithIdentifier:identfiter];
        if (!cell) {
            cell = [[CellDownSelection alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfiter];
            cell.delegate = self;
        }
        if (indexPath.row == 1) {
            cell.type = 6;
            cell.title = @"现在联系捐赠者";
            [cell updateData:[NSString stringWithFormat:@"%d",self.isContact] withType:6];
        }else if(indexPath.row == 3){
            cell.type = 6;
            cell.title = @"留下我的联系方式给捐赠者";
            [cell updateData:[NSString stringWithFormat:@"%d",self.isWoContact] withType:6];
        }else if(indexPath.row == 4){
            cell.type = 1;
            cell.title = @"姓名";
            [cell.tfText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [cell updateData:self.name withType:1];
            cell.tfText.tag = 100;
        }else if(indexPath.row == 5){
            cell.type = 2;
            cell.title = @"联系方式";
            [cell updateData:self.contactType withType:0];
            if (self.contactTypeId == 0) {
                cell.tfSecondText.userInteractionEnabled = NO;
            }else{
                cell.tfSecondText.userInteractionEnabled = YES;
            }
            [cell.tfSecondText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            cell.tfSecondText.tag = 101;
        }else if(indexPath.row == 7){
            cell.type = 9;
            cell.title = @"开始时间";
            [cell updateData:self.startTime withType:0];
        }else if(indexPath.row == 8){
            cell.type = 9;
            cell.title = @"结束时间";
            [cell updateData:self.endTime withType:0];
        }else if(indexPath.row == 9){
            cell.type = 6;
            cell.title = @"我要传达“谢谢”给捐赠者";
            [cell updateData:[NSString stringWithFormat:@"%d",self.isThanks] withType:6];
        }else if(indexPath.row == 10){
            cell.type = 4;
            cell.title = @"评价";
            [cell updateData:[NSString stringWithFormat:@"%f",self.evaluate] withType:4];
            cell.starRateView.delegate = self;
            cell.starRateView.tag = 200;
        }
        cell.index = indexPath;
        return cell;
    }
    return nil;
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

- (void)submitClick{
    [self.view endEditing:YES];
    if (self.data) {
        
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        [parmas setValue:[[self.data objectForKey:@"info"] objectForKey:@"user_id"] forKey:@"user_id"];
        [parmas setValue:APIKEY forKey:@"apikey"];
        
        [parmas setValue:@(self.isContact) forKey:@"is_contact"];
        if(self.isWoContact){
            
            if (self.name.length == 0) {
                Alert(@"请填写姓名");
                return;
            }
            [parmas setValue:self.name forKey:@"full_name"];
            if (self.contactText.length == 0) {
                Alert(@"请填写联系方式");
                return;
            }
            [parmas setValue:self.contactText forKey:@"contact_numbder"];
            [parmas setValue:@(self.contactTypeId) forKey:@"contact_type"];
        }
        [parmas setValue:@(self.isWoContact) forKey:@"is_wo_contact"];
        if (self.startTime.length == 0) {
            Alert(@"请选择开始时间");
            return;
        }
        [parmas setValue:self.startTime forKey:@"start_time"];
        if (self.endTime.length == 0) {
            Alert(@"请选择结束时间");
            return;
        }
        [parmas setValue:self.endTime forKey:@"end_time"];
        [parmas setValue:@(self.isThanks) forKey:@"is_thanks"];
        [parmas setValue:@(self.evaluate) forKey:@"evaluate"];
        [parmas setValue:[[self.data objectForKey:@"info"] objectForKey:@"goods_id"] forKey:@"goods_id"];
        
        [self showHudInView:self.view hint:@"数据处理..."];
        
        
        
        NSString     *urlString = [NSString stringWithFormat:@"%@",@"/api.php/index/add_order"];
        
        [[RequsetPostTool requestNewWorkWithBaseURL]POST:urlString parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"数据 ：%@",responseObject);
            [self hideHud];
            if ([responseObject[@"code"] isEqualToString:@"200"]) {
                [self showHint:@"提交成功!"];
                [self.navigationController popViewControllerAnimated:YES];
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
}


- (void)textFieldDidChange:(UITextField*)textField{
    if (textField.tag == 100) {
        self.name = textField.text;
    }else if (textField.tag == 101) {
        self.contactText = textField.text;
    }
}

- (void)selectCell:(NSInteger)type with:(NSIndexPath *)index{
    NSLog(@"%zi",type);
    if (type == 3) {
        if(index.row == 1){
            self.isContact = !self.isContact;
        }else if(index.row == 3){
            self.isWoContact = !self.isWoContact;
        }else if(index.row == 9){
            self.isThanks = !self.isThanks;
        }
    }if(type == 0 || type == 1){
        if(index.row == 7){
            [self showDate:300];
        }else if(index.row == 8){
            [self showDate:301];
        }else if(index.row == 5){
            [self loadContacts];
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
        self.startTime = [NSString stringWithFormat:@"%d-%2d-%2d",self.Dpicker.year,self.Dpicker.month,self.Dpicker.day];
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
        [cell updateData:self.startTime withType:9];
    }else if(tag == 301 && index == 2){
        self.endTime = [NSString stringWithFormat:@"%d-%2d-%2d",self.Dpicker.year,self.Dpicker.month,self.Dpicker.day];
        CellDownSelection*cell = (CellDownSelection*)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
        [cell updateData:self.endTime withType:9];
    }
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    if (starRateView.tag == 200) {
        self.evaluate = newScorePercent;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (UITableView*)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 40 - 64) style:UITableViewStyleGrouped];
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
        _btnSubmit = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - 40 - 64, ScreenWidth, 40)];
        _btnSubmit.backgroundColor = RGB(254, 0, 0);
        [_btnSubmit setTitle:@"确定" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

@end
