//
//  ViewController.h
//  PNChat-M
//
//  Created by SunHong on 15/9/6.
//  Copyright (c) 2015年 Sunhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChartDelegate.h"
#import "PNChart.h"

@interface ViewController : UIViewController<PNChartDelegate>

@property (nonatomic) PNLineChart * lineChart;
@property (nonatomic) PNBarChart * barChart;
@property (nonatomic) PNCircleChart * circleChart;
@property (nonatomic) PNPieChart *pieChart;
@property (nonatomic) PNScatterChart *scatterChart;
@property (nonatomic) PNRadarChart *radarChart;

@end

