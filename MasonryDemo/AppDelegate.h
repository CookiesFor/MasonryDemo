//
//  AppDelegate.h
//  MasonryDemo
//
//  Created by SIMPLE PLAN on 16/3/24.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

