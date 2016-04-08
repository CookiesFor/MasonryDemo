//
//  MenuViewController.m
//  MasonryDemo
//
//  Created by SIMPLE PLAN on 16/3/24.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import "MenuViewController.h"
#import <Masonry.h>
#import "ViewModel.h"
#import "OfflineDemoMapViewController.h"

@interface MenuViewController ()<UIAlertViewDelegate>

@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,assign)CGFloat scacle;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _mapTableView = [[UITableView alloc]init];
    [self.view addSubview:_mapTableView];
    _mapTableView.delegate = self;
    _mapTableView.dataSource = self;
    [_mapTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    
//    ViewModel *model =[[ViewModel alloc]init];
//    NSLog(@"isExpanded value:%@",model.isExpanded?@YES:@NO);
    
    self.navigationItem.title = @"Zapfino";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     
  @{NSFontAttributeName:[UIFont fontWithName:@"Zapfino" size:19],
    
    
    NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.view.backgroundColor = [UIColor grayColor];
    
    
//    [self createButton];
    
    
    //另开辟子线程执行死循环
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        while (1) {
//            NSLog(@"懵逼");
        }
        
  });
    
    
//    NSDictionary *dict = @{@"1":@"a",@"2":@"b"};
//    NSLog(@"%@",[MenuViewController dictionaryToJson:dict]);
    
    
    _offlineMap = [[BMKOfflineMap alloc]init];
    _offlineMap.delegate = self;
    _arraylocalDownLoadMapInfo = [NSMutableArray arrayWithArray:[_offlineMap getAllUpdateInfo]];
//    NSLog(@"已经离线的城市%@",_arraylocalDownLoadMapInfo);
//    for ( BMKOLUpdateElement *element in _arraylocalDownLoadMapInfo) {
//        
//        NSLog(@"%d,%@",element.cityID,element.cityName);
//        
//    }
//    //获取支持离线下载的城市列表
//    NSArray *arr = [_offlineMap getOfflineCityList];
//    NSLog(@"支持离线下载的城市列表:%@",arr);
//    for (BMKOLSearchRecord* item in arr) {
//        NSLog(@"%@",item.cityName);
//        NSLog(@"%d",item.cityID);
//        NSLog(@"%@",item.childCities);
//        for (BMKOLSearchRecord* item1 in item.childCities) {
//            NSLog(@"%@",item1.cityName);
//            NSLog(@"%d",item1.cityID);
//            
//        }
//
//    }
    
    
    NSArray *records = [_offlineMap searchCity:@"焦作"];
    BMKOLSearchRecord *oneRecord = [records objectAtIndex:0];
    [_offlineMap start:oneRecord.cityID];
    
//    NSLog(@"已经下载的数据:%@",_arraylocalDownLoadMapInfo);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arraylocalDownLoadMapInfo.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    BMKOLSearchRecord* item = [_arraylocalDownLoadMapInfo objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ --%@",item.cityName,[self getDataSizeString:item.size]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKOLSearchRecord* item = [_arraylocalDownLoadMapInfo objectAtIndex:indexPath.row];
    OfflineDemoMapViewController *offlineMapViewCtrl = [[OfflineDemoMapViewController alloc] init];
    
    offlineMapViewCtrl.title = @"查看离线地图";
    //            NSLog(@"%@",oneRecord.cityID);
    offlineMapViewCtrl.cityId = item.cityID;
    offlineMapViewCtrl.offlineServiceOfMapview = _offlineMap;
//    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
//    customLeftBarButtonItem.title = @"返回";
//    self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController pushViewController:offlineMapViewCtrl animated:YES];
}


#pragma mark -包大小转换工具类（将包大小转换成合适单位）
-(NSString *)getDataSizeString:(int) nSize
{
    NSString *string = nil;
    if (nSize<1024)
    {
        string = [NSString stringWithFormat:@"%dB", nSize];
    }
    else if (nSize<1048576)
    {
        string = [NSString stringWithFormat:@"%dK", (nSize/1024)];
    }
    else if (nSize<1073741824)
    {
        if ((nSize%1048576)== 0 )
        {
            string = [NSString stringWithFormat:@"%dM", nSize/1048576];
        }
        else
        {
            int decimal = 0; //小数
            NSString* decimalStr = nil;
            decimal = (nSize%1048576);
            decimal /= 1024;
            
            if (decimal < 10)
            {
                decimalStr = [NSString stringWithFormat:@"%d", 0];
            }
            else if (decimal >= 10 && decimal < 100)
            {
                int i = decimal / 10;
                if (i >= 5)
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 1];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 0];
                }
                
            }
            else if (decimal >= 100 && decimal < 1024)
            {
                int i = decimal / 100;
                if (i >= 5)
                {
                    decimal = i + 1;
                    
                    if (decimal >= 10)
                    {
                        decimal = 9;
                    }
                    
                    decimalStr = [NSString stringWithFormat:@"%d", decimal];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", i];
                }
            }
            
            if (decimalStr == nil || [decimalStr isEqualToString:@""])
            {
                string = [NSString stringWithFormat:@"%dMss", nSize/1048576];
            }
            else
            {
                string = [NSString stringWithFormat:@"%d.%@M", nSize/1048576, decimalStr];
            }
        }
    }
    else	// >1G
    {
        string = [NSString stringWithFormat:@"%dG", nSize/1073741824];
    }
    
    return string;
}

-(void)onGetOfflineMapState:(int)type withState:(int)state
{
    if (type == TYPE_OFFLINE_UPDATE) {
        
        
        
        
        //id为state的城市正在下载或更新，start后会毁掉此类型
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
        if (updateInfo.ratio == 100) {
            [_arraylocalDownLoadMapInfo addObject:updateInfo.cityName];
            
//            BMKOLSearchRecord *oneRecord = [_arraylocalDownLoadMapInfo objectAtIndex:0];
            OfflineDemoMapViewController *offlineMapViewCtrl = [[OfflineDemoMapViewController alloc] init];
            
            offlineMapViewCtrl.title = @"查看离线地图";
//            NSLog(@"%@",oneRecord.cityID);
            offlineMapViewCtrl.cityId = updateInfo.cityID;
            offlineMapViewCtrl.offlineServiceOfMapview = _offlineMap;
            UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
            customLeftBarButtonItem.title = @"返回";
            self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
            [self.navigationController pushViewController:offlineMapViewCtrl animated:YES];

        }
    }
    if (type == TYPE_OFFLINE_NEWVER) {
        //id为state的state城市有新版本,可调用update接口进行更新
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"是否有更新%d",updateInfo.update);
    }
    if (type == TYPE_OFFLINE_UNZIP) {
        //正在解压第state个离线包，导入时会回调此类型
    }
    if (type == TYPE_OFFLINE_ZIPCNT) {
        //检测到state个离线包，开始导入时会回调此类型
        NSLog(@"检测到%d个离线包",state);
        if(state==0)
        {
            [self showImportMesg:state];
        }
    }
    if (type == TYPE_OFFLINE_ERRZIP) {
        //有state个错误包，导入完成后会回调此类型
        NSLog(@"有%d个离线包导入错误",state);
    }
    if (type == TYPE_OFFLINE_UNZIPFINISH) {
        NSLog(@"成功导入%d个离线包",state);
        //导入成功state个离线包，导入成功后会回调此类型
        [self showImportMesg:state];
    }

}

//导入提示框
- (void)showImportMesg:(int)count
{
    NSString* showmeg = [NSString stringWithFormat:@"成功导入离线地图包个数:%d", count];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"导入离线地图" message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)viewWillAppear:(BOOL)animated {
    //    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _offlineMap.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _offlineMap.delegate = nil; // 不用时，置nil
}


//将字典转换为json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
-(void)createButton
{
    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _scacle = 1.0;
    [_btn setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:_btn];
    
    
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        
        //初始化宽高
        make.width.height.mas_equalTo(100 * self.scacle).priorityLow();
        
        //最大放大到整个view
//        make.width.height.lessThanOrEqualTo(self.view);
        
    }];
    
   
}

#pragma mark -update
-(void)updateViewConstraints
{
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        
        //初始化宽高
        make.width.height.mas_equalTo(100 * self.scacle).priorityLow();
        
        //最大放大到整个view
        make.width.height.lessThanOrEqualTo(self.view);
        
    }];
    
    [super updateViewConstraints];
    
}

-(void)btnClick:(UIButton *)sender
{
    self.scacle += 0.5;
    //告诉self.view要更新约束
    [self.view setNeedsUpdateConstraints];
    
    //调用此方法告诉self.view检测是否需要更新约束,若需要则更新，下面添加动画效果
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
