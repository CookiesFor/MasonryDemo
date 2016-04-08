//
//  OfflineDemoMapViewController.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-22.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

@interface OfflineDemoMapViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService * _locService;
    BMKPointAnnotation *anno;
    BMKCoordinateRegion region;
    NSString *str;

    BMKMapView* _mapView;
}
@property (nonatomic, assign) int cityId;
@property (nonatomic, retain) BMKOfflineMap* offlineServiceOfMapview;
@end
