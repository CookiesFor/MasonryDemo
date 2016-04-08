//
//  HomeTabBarViewController.m
//  MasonryDemo
//
//  Created by SIMPLE PLAN on 16/3/24.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import "HomeTabBarViewController.h"
#import "BaseViewController.h"

@interface HomeTabBarViewController ()

@end

@implementation HomeTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createTabBarViewController];
    
    
}

#pragma mark - 创建子视图
-(void)createTabBarViewController
{
    NSArray *title = @[@"第一页",@"第二页",@"第三页",@"第四页"];
    NSArray *vcNames = @[@"MenuViewController",@"SecondViewController",@"ThirdViewController",@"VideoViewController"];
    
    NSMutableArray *mAry = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<title.count; i++) {
        
        Class vcClass = NSClassFromString(vcNames[i]);
        BaseViewController *vc = [[vcClass alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        nav.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
        nav.tabBarItem.title = title[i];
        [mAry addObject:nav];
 
    }
    self.viewControllers = mAry;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
