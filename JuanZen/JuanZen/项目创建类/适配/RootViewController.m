//
//  RootViewController.m
//  YouPai
//
//  Created by yibyi on 2017/4/30.
//  Copyright © 2017年 Deception. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()



@end
@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationBarBackImage"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemPressed:)];
        
        item;
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self hideHud];
}

#pragma mark - leftBarButtonItemPressed
- (void)leftBarButtonItemPressed:(UIBarButtonItem *)item
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
