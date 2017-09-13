//
//  ManagerController.m
//  悬浮仓
//
//  Created by 尤超 on 17/3/17.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "ManagerController.h"
#import "YCHead.h"
#import "PNChartDelegate.h"
#import "PNChart.h"
#import "DACircularProgressView.h"

@interface ManagerController ()<PNChartDelegate>

@property (nonatomic ,strong) NSDictionary *json;
@property (nonatomic) PNLineChart * lineChart;

@property (nonatomic, strong) DACircularProgressView *progressView;
@property (nonatomic, strong) DACircularProgressView *progressView2;
@property (nonatomic, strong) DACircularProgressView *progressView3;
@property (nonatomic, strong) DACircularProgressView *progressView4;

@end

@implementation ManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSString * url = [NSString stringWithFormat:Main_URL,Manager_URL];
    
    NSLog(@"%@",url);
    
    NSDictionary * post_dic = @{@"id":@"1"};  //参数
    
    
    [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
        
        self.json = json;
        
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",self.json);
        
        [self addLabText:[NSString stringWithFormat:@"%@:00", self.json[@"data"][@"disinfection"]] Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(100, 115, 80, 60) font:[UIFont systemFontOfSize:25]];
        [self addLabText:@"6:00" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+90, 115, 80, 60) font:[UIFont systemFontOfSize:25]];
        [self addLabText:[NSString stringWithFormat:@"%@:00", self.json[@"data"][@"ozone"]] Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(100, 190, 80, 60) font:[UIFont systemFontOfSize:25]];
        [self addLabText:@"15:00" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+90, 190, 80, 60) font:[UIFont systemFontOfSize:25]];
        
        self.progressView.progress = [self.json[@"data"][@"disinfection"] floatValue]/30;
        self.progressView2.progress = 6.0/30;
        self.progressView3.progress = [self.json[@"data"][@"ozone"] floatValue]/30;
        self.progressView4.progress = 15.0/30;
        
        
        if (self.json[@"day"][@"number"] == nil) {
            [self addLabText: @"0" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(40, 485, 100, 60)font:[UIFont systemFontOfSize:35]];
        } else {
            [self addLabText: [NSString stringWithFormat:@"%@",self.json[@"day"][@"number"]] Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(40, 485, 100, 60)font:[UIFont systemFontOfSize:35]];
        }
        
        if (self.json[@"day"][@"time"] == nil) {
            [self addLabText:@"0" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(40, 560, 100, 60)font:[UIFont systemFontOfSize:35]];
        } else {
            [self addLabText:[NSString stringWithFormat:@"%@",self.json[@"day"][@"time"]] Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(40, 560, 100, 60)font:[UIFont systemFontOfSize:35]];
        }
        
        if (self.json[@"week"][@"number"] == nil) {
            [self addLabText:@"0" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+40, 485, 100, 60) font:[UIFont systemFontOfSize:35]];
        } else {
            [self addLabText:[NSString stringWithFormat:@"%@",self.json[@"week"][@"number"]] Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+40, 485, 100, 60) font:[UIFont systemFontOfSize:35]];
        }
        
        if (self.json[@"week"][@"time"]==nil) {
            [self addLabText:@"0" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+40, 560, 100, 60)font:[UIFont systemFontOfSize:35]];
        } else {
            [self addLabText:[NSString stringWithFormat:@"%@",self.json[@"week"][@"time"]] Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+40, 560, 100, 60)font:[UIFont systemFontOfSize:35]];
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
    }];
    

    
    
    
    [self setUpUI];
}

- (void)addViewFrame:(CGRect)frame Color:(UIColor *)color {
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    backView.backgroundColor = color;
    [self.view addSubview:backView];
}


//圆形进度条值变
- (void)progressChange
{
    
    
}

- (void) setUpUI {
    
    [self addIcon:@"background" frame:self.view.frame];
    
    [self addViewFrame:CGRectMake(20, 120, KSCREENWIDTH*0.5-22.5, 70) Color:COLOR(16, 61, 76, 1)];
    [self addViewFrame:CGRectMake(KSCREENWIDTH*0.5+2.5, 120, KSCREENWIDTH*0.5-22.5, 70) Color:COLOR(16, 61, 76, 1)];
    [self addViewFrame:CGRectMake(20, 195, KSCREENWIDTH*0.5-22.5, 70) Color:COLOR(16, 61, 76, 1)];
    [self addViewFrame:CGRectMake(KSCREENWIDTH*0.5+2.5, 195, KSCREENWIDTH*0.5-22.5, 70) Color:COLOR(16, 61, 76, 1)];
    
    [self addIcon:@"26" frame:CGRectMake(27, 130, 50, 45)];
    [self addIcon:@"27" frame:CGRectMake(KSCREENWIDTH*0.5 +10, 133, 50, 45)];
    [self addIcon:@"28" frame:CGRectMake(28, 209, 50, 45)];
    [self addIcon:@"29" frame:CGRectMake(KSCREENWIDTH*0.5 +10, 205, 50, 45)];
    
    
    
    self.progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(26, 126, 55, 55)];
    self.progressView.roundedCorners = YES;
    self.progressView.trackTintColor = COLOR(31, 104, 112, 1);
    self.progressView.progressTintColor = COLOR(0, 255, 255, 1);
    self.progressView.indeterminate = 1;
    self.progressView.progress = 0;
    [self.view addSubview:self.progressView];
    
    self.progressView2 = [[DACircularProgressView alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5 +10, 128, 55, 55)];
    self.progressView2.roundedCorners = YES;
    self.progressView2.trackTintColor = COLOR(31, 104, 112, 1);
    self.progressView2.progressTintColor = COLOR(0, 255, 255, 1);
    self.progressView2.indeterminate = 1;
    self.progressView2.progress = 0;
    [self.view addSubview:self.progressView2];
    
    self.progressView3 = [[DACircularProgressView alloc] initWithFrame:CGRectMake(26, 204, 55, 55)];
    self.progressView3.roundedCorners = YES;
    self.progressView3.trackTintColor = COLOR(31, 104, 112, 1);
    self.progressView3.progressTintColor = COLOR(0, 255, 255, 1);
    self.progressView3.indeterminate = 1;
    self.progressView3.progress = 0;
    [self.view addSubview:self.progressView3];
    
    self.progressView4 = [[DACircularProgressView alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5 +10, 201, 55, 55)];
    self.progressView4.roundedCorners = YES;
    self.progressView4.trackTintColor = COLOR(31, 104, 112, 1);
    self.progressView4.progressTintColor = COLOR(0, 255, 255, 1);
    self.progressView4.indeterminate = 1;
    self.progressView4.progress = 0;
    [self.view addSubview:self.progressView4];
    
    
    
    [self addLabText:@"消毒剩余时间" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(90, 160, 100, 20)font:[UIFont systemFontOfSize:12]];
    
    [self addLabText:@"加热剩余时间" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+70, 160, 100, 20)font:[UIFont systemFontOfSize:12]];
    
    [self addLabText:@"臭氧剩余时间" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(90, 240, 100, 20)font:[UIFont systemFontOfSize:12]];
    
    [self addLabText:@"排风剩余时间" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+70, 240, 100, 20)font:[UIFont systemFontOfSize:12]];
    
    
    
    UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 270, KSCREENWIDTH-40, 360)];
    backView2.backgroundColor = COLOR(16, 61, 76, 1);
    [self.view addSubview:backView2];
    
    [self addBtn:@"1" Frame:CGRectMake(KSCREENWIDTH-60, 35, 40, 40) action:@selector(homeBtnClick)];
    
    [self addBtn:@"2" Frame:CGRectMake(KSCREENWIDTH-120, 35, 40, 40) action:@selector(unKnowBtnClick)];
    
    [self addLabText:@"管理员" Color:COLOR(28, 115, 125, 1) Frame:CGRectMake(8, 90, 100, 25) font:[UIFont systemFontOfSize:25] ];
    
    
    [self addLabText:@"今日订单数量" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(40, 530, 100, 20)font:[UIFont systemFontOfSize:10]];
    
    [self addLabText:@"本周订单数量" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+40, 530, 100, 20)font:[UIFont systemFontOfSize:10]];
    
    [self addLabText:@"今日体验时间" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(40, 605, 100, 20)font:[UIFont systemFontOfSize:10]];
    
    [self addLabText:@"本周体验时间" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(KSCREENWIDTH*0.5+40, 605, 100, 20)font:[UIFont systemFontOfSize:10]];
    
    
    
    //折线图
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 275, KSCREENWIDTH-20, 200.0)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    [self.lineChart setXLabels:@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]];
    self.lineChart.showCoordinateAxis = YES;
    
    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    self.lineChart.yGridLinesColor = [UIColor clearColor];
    self.lineChart.showYGridLines = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 300.0;
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:@[
                                 @"0",
                                 @"50",
                                 @"100",
                                 @"150",
                                 @"200",
                                 @"250",
                                 @"300",
                                 ]
     ];
    
    // Line Chart #1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @0.0, @186.2, @127.2, @176.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"订单";
    data01.color = PNFreshGreen;
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointColor = PNRed;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart #2
    NSArray * data02Array = @[@0.0, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"时间";
    data02.color = PNTwitterColor;
    data02.alpha = 0.5f;
    data02.itemCount = data02Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data01, data02];
    [self.lineChart strokeChart];
    self.lineChart.delegate = self;
    
    
    [self.view addSubview:self.lineChart];
    
    self.lineChart.legendStyle = PNLegendItemStyleStacked;
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    self.lineChart.legendFontColor = [UIColor whiteColor];
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(60, 280, legend.frame.size.width, legend.frame.size.width)];
    [self.view addSubview:legend];
    
    
    [self addLineLabColor:COLOR(0, 44, 56, 1) Frame:CGRectMake(20, 480, KSCREENWIDTH-40, 2)];
    [self addLineLabColor:COLOR(0, 44, 56, 1) Frame:CGRectMake(20, 555, KSCREENWIDTH-40, 2)];
    [self addLineLabColor:COLOR(0, 44, 56, 1) Frame:CGRectMake(KSCREENWIDTH*0.5-1, 490, 2, 55)];
    [self addLineLabColor:COLOR(0, 44, 56, 1) Frame:CGRectMake(KSCREENWIDTH*0.5-1, 565, 2, 55)];
   
}

- (void)addLineLabColor:(UIColor *)color Frame:(CGRect)frame {
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.backgroundColor = color;
    [self.view addSubview:lab];
}


- (void)addLabText:(NSString *)text Color:(UIColor *)color Frame:(CGRect) frame font:(UIFont *)font {
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = text;
    lab.textColor = color;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = font;
    lab.numberOfLines=0;
    [self.view addSubview:lab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBtn:(NSString *)iconName Frame:(CGRect)frame action:(SEL)name {
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:name forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];
}

- (void)addIcon:(NSString *)name frame:(CGRect)frame {
    UIImageView *icon = [[UIImageView alloc] initWithFrame:frame];
    icon.image = [UIImage imageNamed:name];
    [self.view addSubview:icon];
}

#warning 44442
- (void)homeBtnClick {
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)unKnowBtnClick {
    NSLog(@"未知");
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
