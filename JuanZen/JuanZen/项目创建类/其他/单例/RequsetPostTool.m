
//
//  RequsetPostTool.m
//  iCell
//
//  Created by 龚洪 on 2017/4/12.
//  Copyright © 2017年 赛联(武汉). All rights reserved.
//

#import "RequsetPostTool.h"

@implementation RequsetPostTool

//带有基础URL

+(instancetype)requestNewWorkWithBaseURL {
    static RequsetPostTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //创建一个baseURL
        NSURL *baseURL1 = [NSURL URLWithString:DEFAULTURL];
        //设置配置信息
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance = [[RequsetPostTool alloc] initWithBaseURL:baseURL1 sessionConfiguration:configuration];
        instance.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions :NSJSONReadingMutableLeaves];
        [instance.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        instance.requestSerializer.timeoutInterval = 8.0f;
        [instance.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        //设置响应的数据类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json", @"text/javascript", @"application/json", @"application/xml", @"text/plain", nil];
        
    });
    return instance;
}


+ (void)canConnectNetworkWithVC:(UIViewController *)vc completion:(void (^)(BOOL))completion
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status==-1 || status==0) {
             completion(NO);
 
             
         }else {
             completion(YES);
         }
     }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
