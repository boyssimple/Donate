//
//  ReaveImformation.h
//  syss
//
//  Created by yibiyi on 16/8/10.
//  Copyright © 2016年 yibiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReaveImformation : NSObject

@property (nonatomic, strong)NSString       *userPhone;
@property (nonatomic, strong)NSString       *userId;
@property (nonatomic, strong)NSString       *userName; // 昵称 user_name
@property (nonatomic, strong)UIImage        *headGraphic;// 头像 head_graphic
@property (nonatomic, strong)NSString       *gender;// 电话 user_phone
@property (nonatomic, strong)NSString       *birthday;// 邮箱 user_email
@property (nonatomic, strong)NSString       *city;// 真实名字 real_name
@property (nonatomic, strong)NSDictionary   *infor;


+ (ReaveImformation *)reseaveInformation;

+ (NSString *)getUserKey;
+ (NSString *)getUserId;
+ (NSString *)getUserName;
+ (NSString *)getUserPhone;
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
+ (NSDictionary *)parmars:(NSDictionary *)dic;
+ (BOOL)isLogin;

@end
