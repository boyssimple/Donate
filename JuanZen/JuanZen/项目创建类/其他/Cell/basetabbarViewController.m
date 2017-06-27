//
//  basetabbarViewController.m
//  YouPai
//
//  Created by 大洋人 on 2017/5/15.
//  Copyright © 2017年 Deception. All rights reserved.
//

#import "basetabbarViewController.h"

@interface basetabbarViewController ()

@end

@implementation basetabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self modifyRenderingSelectedImage];
}

//修改tabbarItem的selectedImage的显示模式
- (void)modifyRenderingSelectedImage {
    for (UINavigationController *nav in self.viewControllers) {
        UIImage *image = nav.tabBarItem.selectedImage;
        [nav.tabBarItem setSelectedImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    // 字体颜色 选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0F], NSForegroundColorAttributeName :[UIColor redColor]} forState:UIControlStateSelected];
    
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
