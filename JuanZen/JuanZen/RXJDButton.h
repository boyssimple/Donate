//
//  RXJDButton.h
//  RXExtenstion
//
//  Created by 龚洪 on 16/12/7.
//  Copyright © 2016年 赛联(武汉). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RXJDButton : UIButton

@property (nonatomic, assign) NSInteger  tagJD;
@property (nonatomic, copy)   NSString * addressName;

@property (nonatomic, assign) CGFloat    width;
@property (nonatomic, assign) CGFloat    left;
@end

/*
        外部不掉用此文件
 */
