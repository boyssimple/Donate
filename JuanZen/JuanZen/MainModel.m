//
//  MainModel.m
//  Donate
//
//  Created by yibyi on 2017/6/23.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel
- (instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        self.type_id = [dic objectForKey:@"type_id"];
        self.type_roue_id = [dic objectForKey:@"type_roue_id"];
        self.type_title = [dic objectForKey:@"type_title"];
        self.type_sort = [dic objectForKey:@"type_sort"];
        self.type_img = [dic objectForKey:@"type_img"];
        self.bg_img = [dic objectForKey:@"bg_img"];
    }
    return self;
}



@end
