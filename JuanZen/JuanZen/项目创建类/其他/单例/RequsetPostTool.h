//
//  RequsetPostTool.h
//  iCell
//
//  Created by 龚洪 on 2017/4/12.
//  Copyright © 2017年 赛联(武汉). All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface RequsetPostTool : AFHTTPSessionManager


//带有基础URL（协议+域名）
+(instancetype)requestNewWorkWithBaseURL;
//网络监视
+ (void)canConnectNetworkWithVC:(UIViewController *)vc completion:(void(^)(BOOL ok))completion;
@end
