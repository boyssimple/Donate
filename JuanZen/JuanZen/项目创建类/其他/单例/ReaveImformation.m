//
//  ReaveImformation.m
//  syss
//
//  Created by yibiyi on 16/8/10.
//  Copyright © 2016年 yibiyi. All rights reserved.
//

#import "ReaveImformation.h"



@implementation ReaveImformation

+ (ReaveImformation *)reseaveInformation
{
    static ReaveImformation *information = nil;
    if (!information) {
        information = [[ReaveImformation alloc] init];
    }
    return information;
}

+ (NSString *)getUserKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"user_key : %@",[defaults objectForKey:@"user_key"]);
    return [defaults objectForKey:@"user_key"];
}


+ (NSString *)getUserName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"user_name : %@",[defaults objectForKey:@"user_name"]);
    return [defaults objectForKey:@"user_name"];
}


+ (NSString *)getUserPhone
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"user_phone : %@",[defaults objectForKey:@"user_phone"]);
    return [defaults objectForKey:@"user_phone"];
}


+ (NSString *)getUserId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"user_id : %@",[defaults objectForKey:@"user_id"]);
    return [defaults objectForKey:@"user_id"];
}

+ (BOOL)isLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"login"] isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
    
}

+ (NSDictionary *)parmars:(NSDictionary *)dic
{
    NSMutableDictionary *returnDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [returnDic setObject:VERSION forKey:@"version"];
    [returnDic setObject:APIKEY forKey:@"appkey"];
    [returnDic setObject:TERMINAL forKey:@"terminal"];
    
    return returnDic;
}

#pragma mark - 改变图片大小
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

@end
