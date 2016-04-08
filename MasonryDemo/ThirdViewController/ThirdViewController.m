//
//  ThirdViewController.m
//  MasonryDemo
//
//  Created by SIMPLE PLAN on 16/3/24.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import "ThirdViewController.h"
#import <Masonry.h>
#import "ViewCell.h"
#import "ViewModel.h"

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"第三页";
    
    
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    
    for (NSUInteger i = 0; i<10; i++) {
        
        ViewModel *model = [[ViewModel alloc]init];
        model.title=  @"主标题，据听说要短一点，但是要多短呢，还要能突出重点呢";
        model.desc = @"副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。副标题呢，左侧配的有图，上方配的有主标题，副标题真好啊。";
        
        [self.dataSource addObject:model];
        
    }
    
    
    [self.tableView reloadData];
    
}

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"Cell";
    
    ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        
        cell = [[ViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    cell.indexPath = indexPath;
    cell.block = ^(NSIndexPath *path)
    {
        [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    };
    ViewModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewModel *model = [self.dataSource objectAtIndex:indexPath.row];
    return [ViewCell heightWithModel:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
