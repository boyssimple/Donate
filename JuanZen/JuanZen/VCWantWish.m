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

@interface VCWantWish ()<UITableViewDelegate,UITableViewDataSource,CellDownSelectionDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIButton  *btnSubmit;
@property (nonatomic, strong) NSArray  *contactList;


@property (nonatomic, strong) NSString *contactType;//联系方式
@property (nonatomic, assign) NSInteger contactTypeId;
@property (nonatomic, strong) NSString *contactText;//联系方式

@end

@implementation VCWantWish

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnSubmit];
    self.title = @"我要许愿";
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
    }else if (indexPath.row == 1) {
        cell.title = @"心愿类型";
        cell.type = 0;
    }else if (indexPath.row == 2) {
        cell.title = @"联系方式";
        cell.type = 2;
        [cell updateData:self.contactType withType:0];
        if (self.contactTypeId == 0) {
            cell.tfSecondText.userInteractionEnabled = NO;
        }else{
            cell.tfSecondText.userInteractionEnabled = YES;
        }
        [cell.tfSecondText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.tfSecondText.tag = 100;
    }else if (indexPath.row == 3) {
        cell.title = @"希望时间";
        cell.type = 1;
    }else if (indexPath.row == 4) {
        cell.title = @"备注";
        cell.type = 5;
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
            
        }else if(index.row == 1){
            
        }else if(index.row == 2){
            [self loadContacts];
        }
        
    }
}


- (void)textFieldDidChange:(UITextField*)textField{
    if (textField.tag == 100) {
        self.contactText = textField.text;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
    }
    return _btnSubmit;
}

@end