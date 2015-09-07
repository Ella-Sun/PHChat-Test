//
//  ShowViewController.m
//  PNChat-M
//
//  Created by SunHong on 15/9/6.
//  Copyright (c) 2015年 Sunhong. All rights reserved.
//

#import "ShowViewController.h"

#import "PNChartDelegate.h"
#import "PNChart.h"
#define ARC4RANDOM_MAX 0x100000000
//#define ksWidth [UIScreen mainScreen].bounds.size.width;

@interface ShowViewController () <PNChartDelegate>

@property (nonatomic) PNLineChart * lineChart;
@property (nonatomic) PNBarChart * barChart;
@property (nonatomic) PNCircleChart * circleChart;
@property (nonatomic) PNPieChart *pieChart;
@property (nonatomic) PNScatterChart *scatterChart;
@property (nonatomic) PNRadarChart *radarChart;

@property (nonatomic, strong) UILabel *showPosition;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _showPosition = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, width-20, 100)];
    _showPosition.backgroundColor = [UIColor clearColor];
    _showPosition.textAlignment = NSTextAlignmentCenter;
    _showPosition.numberOfLines = 0;
    [self.view addSubview:_showPosition];

        switch (self.showNo) {
            case 1:
                //线形图
                [self createLineChart];
                break;
            case 2:
                //柱状图 不太懂
                [self createBarChart];
                break;
            case 3:
                //环形 中空 图
                [self createCircleChart];
                break;
            case 4:
                //饼状图
                [self createPieChart];
                break;
            case 5:
                //散列图
                [self createScatterChart];
                break;
            case 6:
                //雷达图
                [self createRadarChart];
                break;
                
            default:
                break;
        }
}

//For Line Chart
- (void)createLineChart
{
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    self.lineChart.yLabelFormat = @"%1.1f";//y轴的数字显示位数
    self.lineChart.backgroundColor = [UIColor clearColor];//
    [self.lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    self.lineChart.showCoordinateAxis = YES;//是否显示坐标轴
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 300.0;//y轴最大的数字
    self.lineChart.yFixedValueMin = 0.0;
    
    //默认300 240 180 120...可以改变 坐标上文字显示
    //    [self.lineChart setYLabels:@[
    //                                 @"0 min",
    //                                 @"50 min",
    //                                 @"100 min",
    //                                 @"150 min",
    //                                 @"200 min",
    //                                 @"250 min",
    //                                 @"300 min",
    //                                 ]
    //     ];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];//起点到终点 弯折的点的纵坐标
    //动态改变线上的点值
    //NSArray * data01Array = @[@(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300)];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = self.lineChart.xLabels.count;//data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;//线上显示的图形 三角形
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = self.lineChart.xLabels.count;//data02Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleSquare;//线上显示的图形 正方形
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.3  可以创建多条曲线
    NSArray * data03Array = @[@40.1, @120.1, @56.4, @172.2, @96.2];
    PNLineChartData *data03 = [PNLineChartData new];
    data03.color = PNStarYellow;
    data03.itemCount = self.lineChart.xLabels.count;//data02Array.count;
    data03.inflexionPointStyle = PNLineChartPointStyleCircle;//线上显示的图形 圆圈
    data03.getData = ^(NSUInteger index) {
        CGFloat yValue = [data03Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data01, data02 ,data03];
    //    [lineChart updateChartData:@[data01, data02 ,data03]];
    [self.lineChart strokeChart];//绘制
    self.lineChart.delegate = self;//代理 点击事件
    
    [self.view addSubview:self.lineChart];
    
    //Add Line Titles for the Legend
    data01.dataTitle = @"Alpha";
    data02.dataTitle = @"Beta Beta Beta Beta";
    data03.dataTitle = @"SH-Test";
    
    //下边对不同线的说明
    //Legend has been added to PNChart for Line and Pie Charts. Legend items position can be stacked or in series.
    
    //Build the legend
    self.lineChart.legendStyle = PNLegendItemStyleSerial;//一行显示
    //    lineChart.legendStyle = PNLegendItemStyleStacked;//多行显示
    
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    self.lineChart.legendFontColor = [UIColor redColor];//文字说明的颜色 默认黑色
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    //Move legend to the desired position and add to view
    [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
    
    [self.view addSubview:legend];
}



//For Bar Chart  还不太会用
- (void)createBarChart
{
    //前面加了个$符号
    static NSNumberFormatter *barChartFormatter;
    if (!barChartFormatter){
        barChartFormatter = [[NSNumberFormatter alloc] init];
        /**
         *kCFNumberFormatterNoStyle,
         *kCFNumberFormatterDecimalStyle,
         *kCFNumberFormatterCurrencyStyle,
         *kCFNumberFormatterPercentStyle,
         *kCFNumberFormatterScientificStyle
         *kCFNumberFormatterSpellOutStyle,
         **/
        barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        barChartFormatter.allowsFloats = NO;
        barChartFormatter.maximumFractionDigits = 0;
    }
    
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    //    self.barChart.showLabel = NO;
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
    };
    
    //改变 柱子的 高度 和总体与视图的相对布局
    self.barChart.yChartLabelWidth = 20.0;
    self.barChart.chartMarginLeft = 30.0;
    self.barChart.chartMarginRight = 10.0;
    self.barChart.chartMarginTop = 5.0;
    self.barChart.chartMarginBottom = 10.0;
    
    self.barChart.labelMarginTop = 5.0;
    self.barChart.showChartBorder = YES;//是否显示坐标线
    [self.barChart setXLabels:@[@"2",@"3",@"4",@"5",@"2",@"3",@"4",@"5"]];
    //    [self.barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    
    //Y轴显示的数字 -￥10 ￥0 ..
    //    self.barChart.yLabels = @[@-10,@0,@10];
    
    //每个柱子代表的值 左侧的Y轴坐标会随着最大与最小值 自动修改
    //    [self.barChart setYValues:@[@1,  @10, @2, @6, @3]];
    //    [self.barChart setYValues:@[@10000.0,@30000.0,@10000.0,@100000.0,@500000.0,@1000000.0,@1150000.0,@2150000.0]];
    [self.barChart setYValues:@[@10.82,@1.88,@6.96,@33.93,@10.82,@1.88,@6.96,@33.93]];
    //添加不同的颜色 色柱
    //动态改变柱状图的值
    //    [self.barChart updateChartData:@[@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30)]];
    
    [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNGreen,PNRed,PNGreen]];
    self.barChart.isGradientShow = NO;//是否显示柱子中间的亮条 立体
    self.barChart.isShowNumbers = NO;//是否显示 YValues
    
    
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;//
    
    [self.view addSubview:self.barChart];
}



//For Circle Chart
- (void)createCircleChart
{
    self.circleChart = [[PNCircleChart alloc]
                        initWithFrame:CGRectMake(0, 80.0, SCREEN_WIDTH, 100.0)
                        total:[NSNumber numberWithInt:100]
                        current:[NSNumber numberWithInt:60]
                        clockwise:YES//顺时针 YES || 逆时针
                        shadow:NO
                        shadowColor:[UIColor clearColor]];//圆环默认的颜色
    
    [self.circleChart updateChartByCurrent:@(arc4random() % 100)];//
    //没有这个方法了
    //    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 80.0, SCREEN_WIDTH, 100.0) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:60] clockwise:NO shadow:NO];
    
    self.circleChart.backgroundColor = [UIColor clearColor];
    //    [self.circleChart setStrokeColor:PNGreen];
    [self.circleChart setStrokeColor:[UIColor clearColor]];
    [self.circleChart setStrokeColorGradientStart:[UIColor greenColor]];//颜色逐渐加深
    
    [self.circleChart strokeChart];
    
    [self.view addSubview:self.circleChart];
}



//For Pie Chart
- (void)createPieChart
{
     CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _showPosition.frame = CGRectMake(10, 450, width-20, 100);
    
    //根据所有的value值 再计算百分比  不必满足所有value值总和为100
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       [PNPieChartDataItem dataItemWithValue:22 color:PNDarkYellow description:@"Project I/O"],
                       ];
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 155.0, 240.0, 240.0) items:items];
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];//艺术字的重影
    self.pieChart.showAbsoluteValues = NO;//是否加%  default NO
    self.pieChart.showOnlyValues = NO;//是否 显示 每个模块代表 default NO
    [self.pieChart strokeChart];
    
    self.pieChart.delegate = self;
    
    [self.view addSubview:self.pieChart];
    
    //Build the legend  //图片下方的说明
    self.pieChart.legendStyle = PNLegendItemStyleStacked;
    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0];//legendFontSize = 12.0;
    UIView *legend = [self.pieChart getLegendWithMaxWidth:200];
    
    //Move legend to the desired position and add to view
    [legend setFrame:CGRectMake(130, 420, legend.frame.size.width, legend.frame.size.height)];
    [self.view addSubview:legend];
}



//For Scatter Chart
- (void)createScatterChart
{
    self.scatterChart = [[PNScatterChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /6.0 - 30, 135, 280, 200)];
    [self.scatterChart setAxisXWithMinimumValue:20 andMaxValue:100 toTicks:6];
    [self.scatterChart setAxisYWithMinimumValue:30 andMaxValue:50 toTicks:5];
    [self.scatterChart setAxisXLabel:@[@"x1", @"x2", @"x3", @"x4", @"x5", @"x6"]];//
    [self.scatterChart setAxisYLabel:@[@"y1", @"y2", @"y3", @"y4", @"y5"]];//
    
    NSArray * data01Array = [self randomSetOfObjects];
    PNScatterChartData *data01 = [PNScatterChartData new];
    data01.strokeColor = PNGreen;
    data01.fillColor = PNFreshGreen;
    data01.size = 2;
    data01.itemCount = [[data01Array objectAtIndex:0] count];
    data01.inflexionPointStyle = PNScatterChartPointStyleCircle;//表示点得图案形状
    __block NSMutableArray *XAr1 = [NSMutableArray arrayWithArray:[data01Array objectAtIndex:0]];
    __block NSMutableArray *YAr1 = [NSMutableArray arrayWithArray:[data01Array objectAtIndex:1]];
    data01.getData = ^(NSUInteger index) {
        CGFloat xValue = [[XAr1 objectAtIndex:index] floatValue];
        CGFloat yValue = [[YAr1 objectAtIndex:index] floatValue];
        return [PNScatterChartDataItem dataItemWithX:xValue AndWithY:yValue];
    };
    
    [self.scatterChart setup];
    self.scatterChart.chartData = @[data01];
    
    /***
     this is for drawing line to compare
     ***/
    CGPoint start = CGPointMake(20, 35);
    CGPoint end = CGPointMake(80, 45);
    [self.scatterChart drawLineFromPoint:start ToPoint:end WithLineWith:2 AndWithColor:PNBlack];
    
    self.scatterChart.delegate = self;//么有
    [self.view addSubview:self.scatterChart];
}

/* this function is used only for creating random points */
- (NSArray *) randomSetOfObjects{
    NSMutableArray *array = [NSMutableArray array];
    NSString *LabelFormat = @"%1.f";
    NSMutableArray *XAr = [NSMutableArray array];
    NSMutableArray *YAr = [NSMutableArray array];
    for (int i = 0; i < 25 ; i++) {
        [XAr addObject:[NSString stringWithFormat:LabelFormat,(((double)arc4random() / ARC4RANDOM_MAX) * (self.scatterChart.AxisX_maxValue - self.scatterChart.AxisX_minValue) + self.scatterChart.AxisX_minValue)]];
        [YAr addObject:[NSString stringWithFormat:LabelFormat,(((double)arc4random() / ARC4RANDOM_MAX) * (self.scatterChart.AxisY_maxValue - self.scatterChart.AxisY_minValue) + self.scatterChart.AxisY_minValue)]];
    }
    [array addObject:XAr];
    [array addObject:YAr];
    return (NSArray*) array;
}



//For Radar Chart
- (void)createRadarChart
{
    NSArray *items = @[[PNRadarChartDataItem dataItemWithValue:3 description:@"Art"],
                       [PNRadarChartDataItem dataItemWithValue:2 description:@"Math"],
                       [PNRadarChartDataItem dataItemWithValue:8 description:@"Sports"],
                       [PNRadarChartDataItem dataItemWithValue:5 description:@"Literature"],
                       [PNRadarChartDataItem dataItemWithValue:4 description:@"Other"],
                       ];
    self.radarChart = [[PNRadarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 300.0) items:items valueDivider:1];
    [self.radarChart strokeChart];
    
    [self.view addSubview:self.radarChart];
}


#pragma mark - PNChartDelegate
- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{
//    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
    _showPosition.text = [NSString stringWithFormat:@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex];
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
//    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
    _showPosition.text = [NSString stringWithFormat:@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex];
}


#pragma mark - Bar Chart Delegate
- (void)userClickedOnBarAtIndex:(NSInteger)barIndex;
{
//    NSLog(@"点击了第%zd个柱子",barIndex);
    _showPosition.text = [NSString stringWithFormat:@"点击了第%zd个柱子",barIndex+1];
    //实现 点击柱子 放大的效果
    PNBar * bar = [self.barChart.bars objectAtIndex:barIndex];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue = @1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = @1.1;
    animation.duration = 0.2;
    animation.repeatCount = 0;
    animation.autoreverses = YES;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [bar.layer addAnimation:animation forKey:@"Float"];
}

#pragma mark - Pie Chart Delegate
- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex
{
//    NSLog(@"Pie Chart is selected %zd",pieIndex);
    _showPosition.text = [NSString stringWithFormat:@"Pie Chart %zd is selected",pieIndex];
}

- (void)didUnselectPieItem
{
//    NSLog(@"dianji");
    _showPosition.text = @"取消点击效果";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
