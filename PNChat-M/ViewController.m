//
//  ViewController.m
//  PNChat-M
//
//  Created by SunHong on 15/9/6.
//  Copyright (c) 2015年 Sunhong. All rights reserved.
//
//联系 push request

#import "ViewController.h"

#import "ShowViewController.h"


@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong) NSArray * chartArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _chartArray = @[@"For Line Chart",@"For Bar Chart",@"For Circle Chart",@"For Pie Chart",@"For Scatter Chart",@"For Radar Chart"];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, width, height) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chartArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _chartArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    NSLog(@"点击了%ld",indexPath.row);
    
    ShowViewController * showCtrl = [[ShowViewController alloc] init];
    showCtrl.showNo = (indexPath.row + 1);
    
    [self.navigationController pushViewController:showCtrl animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
