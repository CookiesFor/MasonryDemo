//
//  SecondViewController.m
//  MasonryDemo
//
//  Created by SIMPLE PLAN on 16/3/24.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import "SecondViewController.h"
#import <Masonry.h>

@interface SecondViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *mTableView;
    NSMutableArray *dataArr;
}


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"系统字体";
    
    self.view.backgroundColor = [UIColor greenColor];
    
    mTableView = [[UITableView alloc]init];
    [self.view addSubview:mTableView];
    
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view);
        
    }];
    dataArr = [[NSMutableArray alloc] init];
    
    NSInteger i = 0;
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
            
            [dataArr addObject:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont fontWithName:fontName size:20], @"font" ,fontName, @"name", nil]];
        }
        NSLog(@"-------------%ld", i++);
    }
    NSLog(@"%@",dataArr);
    mTableView.delegate = self;
    mTableView.dataSource = self;
    
}

#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"TOTAL COUNT -------------%ld", [dataArr count]);
    return [dataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = @"fontCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    NSDictionary *item = [dataArr objectAtIndex:indexPath.row];
    cell.textLabel.font = [item objectForKey:@"font"];
    cell.textLabel.text = [NSString stringWithFormat:@"字体 %@", [item objectForKey:@"name"]];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
