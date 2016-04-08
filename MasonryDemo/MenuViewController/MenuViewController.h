//
//  MenuViewController.h
//  MasonryDemo
//
//  Created by SIMPLE PLAN on 16/3/24.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface MenuViewController : BaseViewController<BMKOfflineMapDelegate,BMKMapViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _mapTableView;
    BMKOfflineMap* _offlineMap;
    BMKMapView *_mapView;
    NSMutableArray * _arraylocalDownLoadMapInfo;
}
@end
