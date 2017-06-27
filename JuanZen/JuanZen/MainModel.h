//
//  MainModel.h
//  Donate
//
//  Created by yibyi on 2017/6/23.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

@property(nonatomic,strong)NSString*type_id;
@property(nonatomic,strong)NSString*type_roue_id;
@property(nonatomic,strong)NSString*type_title;
@property(nonatomic,strong)NSString*type_sort;
@property(nonatomic,strong)NSString*type_img;
@property(nonatomic,strong)NSString*bg_img;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
