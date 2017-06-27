//
//  MyAnnotationModel.h
//  06-添加大头针
//
//  Created by dream on 15/12/11.
//  Copyright © 2015年 dream. All rights reserved.
//

/**
 1. 导入框架 MapKit
 2. 遵守协议 MKAnnotation
 3. 设置属性 直接去协议中拷贝-->删掉readonly
 */

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotationModel : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;
@property (nonatomic, copy, nullable) NSString *goods_id;

@end
