//
//  RXJDAddressPickerView.h
//  RXExtenstion
//
//  Created by 龚洪 on 16/12/7.
//  Copyright © 2016年 赛联(武汉). All rights reserved.
//


#import <UIKit/UIKit.h>


typedef void(^JDPickerShowOrHidden)(NSString *province, NSString *city, NSString *area, NSString *provinceCode, NSString *cityCode, NSString *areaCode);

@interface RXJDAddressPickerView : UIView

//block回传
@property (nonatomic, copy) JDPickerShowOrHidden completion;

- (void)showAddress;

- (void)loadProvinceDatas:(NSArray*)datas;

@end


/**
    目前 city.json 里的收货地址是3级的
 
    如果想要做出更多级数的地址，就把此.m文件 中的 _addressScrollView变成UICollectionView 里面还是 UITableView。【注意:tableView里面的注册cell信息】
 */



