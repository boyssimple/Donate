//
//  baseViewController.m
//  YouPai
//
//  Created by 大洋人 on 2017/5/18.
//  Copyright © 2017年 Deception. All rights reserved.
//

#import "baseViewController.h"

@interface baseViewController ()
@property(nonatomic,strong)UIButton*leftButton;
@end

@implementation baseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置视图背景
    self.view.backgroundColor = [UIColor whiteColor];
    //设置返回按钮
    _leftButton= [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(0, 0, 25, 20);
    [_leftButton setImage:[UIImage imageNamed:@"navigationBarBackImage"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
    //导航栏颜色设置
    self.navigationController.navigationBar.barTintColor =[UIColor redColor];
}

- (void)leftClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
