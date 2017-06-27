//
//  MKMapView+ZoomLevel.h
//  YouPai
//
//  Created by 龚洪 on 2017/6/5.
//  Copyright © 2017年 Deception. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)


- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
@end
