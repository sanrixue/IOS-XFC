//
//  SBController.m
//  悬浮仓
//
//  Created by 尤超 on 17/3/17.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "SBController.h"
#import "YCHead.h"

@interface SBController ()<UIAlertViewDelegate> {
    
    NSArray *numbers;
    
    NSInteger _type;
    
    NSMutableString *_id;
}


@property (nonatomic, strong) UIView *backView1;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UISwitch *lightBtn;
@property (nonatomic, strong) UISwitch *musicBtn;
@property (nonatomic, strong) UISlider *timeSlider1;
@property (nonatomic, strong) UISlider *timeSlider2;
@property (nonatomic, strong) UISlider *timeSlider3;
@property (nonatomic, strong) UISlider *timeSlider4;

@property (nonatomic, strong) UIButton *ZYBtn;
@property (nonatomic, strong) UIButton *TYBtn;
@property (nonatomic, strong) UIButton *BeginBtn;
@property (nonatomic, strong) UIButton *StopBtn;

@end

@implementation SBController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    NSString * url = [NSString stringWithFormat:Main_URL,EQNow_URL];
    
    NSLog(@"%@",url);
    
    NSDictionary * post_dic = @{@"id":@"1"};  //参数
    
    NSLog(@"%@",post_dic);
    
    [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
        
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",json);
        
        if ([[NSString stringWithFormat:@"%@",json[@"code"]] isEqualToString:@"200"]) {
            
            NSArray * list = @[json[@"data"][@"xuanfu_water"],json[@"data"][@"exhaust_time"] ,json[@"data"][@"re_time"],json[@"data"][@"ozone_time"]];
            
            NSLog(@"%@",list);
            
            float max = [[list valueForKeyPath:@"@max.floatValue"] floatValue];
            
            // 获得日期对象
            NSDateFormatter *formatter_ = [[NSDateFormatter alloc] init];
            formatter_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSDate *createDate = [formatter_  dateFromString:json[@"data"][@"create_time"]];
            NSDate *currentDate = [NSDate date];//获取当前时间，日期
            // 对比时间差
            NSTimeInterval time = [currentDate timeIntervalSinceDate:createDate];
            
            NSLog(@"%f",time);
            
            if (time<max*60) {
                
                
                if (time < [json[@"data"][@"xuanfu_water"] floatValue]*60) {
                    self.timeSlider1.value = [json[@"data"][@"xuanfu_water"] floatValue]-time/60;
                   
                } else {
                    self.timeSlider1.value = 0;
                }
                
                if (time < [json[@"data"][@"ozone_time"] floatValue]*60) {
                    self.timeSlider2.value = [json[@"data"][@"ozone_time"] floatValue]-time/60;
                    
                } else {
                    self.timeSlider2.value = 0;
                   
                }
                
                if (time < [json[@"data"][@"re_time"] floatValue]*60) {
                    self.timeSlider3.value = [json[@"data"][@"re_time"] floatValue]-time/60;
                   
                } else {
                    self.timeSlider3.value = 0;
                                   }
                
                if (time < [json[@"data"][@"exhaust_time"] floatValue]*60) {
                    self.timeSlider4.value = [json[@"data"][@"exhaust_time"] floatValue]-time/60;
                    
                } else {
                    self.timeSlider4.value = 0;
                    
                }
                
                
                
    
                
                _id = json[@"data"][@"id"];
                
                
                
            }
            
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _type = 1;
    
    self.timeSlider1 = [[UISlider alloc] init];
    self.timeSlider2 = [[UISlider alloc] init];
    self.timeSlider3 = [[UISlider alloc] init];
    self.timeSlider4 = [[UISlider alloc] init];
    
    [self setUpUI];
}

- (void) setUpUI {
    
    [self addIcon:@"background" frame:self.view.frame View:self.view];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 120, KSCREENWIDTH-40, 80)];
    backView.backgroundColor = COLOR(16, 61, 76, 1);
    [self.view addSubview:backView];
    
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 230, KSCREENWIDTH-40, 320)];
    self.backView1.backgroundColor = COLOR(16, 61, 76, 1);
    [self.view addSubview:self.backView1];
    self.backView1.hidden = NO;
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 230, KSCREENWIDTH-40, 320)];
    self.backView2.backgroundColor = COLOR(16, 61, 76, 1);
    [self.view addSubview:self.backView2];
    self.backView2.hidden = YES;
    
    
    [self addBtn:nil IMG:@"1" SIMG:nil Frame:CGRectMake(KSCREENWIDTH-60, 35, 40, 40) Action:@selector(homeBtnClick) View:self.view];
    
    [self addBtn:nil IMG:@"2" SIMG:nil Frame:CGRectMake(KSCREENWIDTH-120, 35, 40, 40) Action:@selector(unKnowBtnClick) View:self.view];
    
    [self addLabText:@"设备管理" Color:COLOR(28, 115, 125, 1) Frame:CGRectMake(20, 90, 150, 25) font:[UIFont systemFontOfSize:25] View:self.view];
    
    
    self.ZYBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, KSCREENWIDTH*0.5-50, 40)];
    [self.ZYBtn setBackgroundImage:[UIImage imageNamed:@"20"] forState:UIControlStateNormal];
    [self.ZYBtn setBackgroundImage:[UIImage imageNamed:@"24"] forState:UIControlStateSelected];
    self.ZYBtn.backgroundColor = [UIColor clearColor];
    [self.ZYBtn addTarget:self action:@selector(ZYBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.ZYBtn.layer.masksToBounds = YES;
    self.ZYBtn.layer.cornerRadius = 5;
    [backView addSubview:self.ZYBtn];
    self.ZYBtn.selected = YES;
    
    
    self.TYBtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5-10, 20, KSCREENWIDTH*0.5-50, 40)];
    [self.TYBtn setBackgroundImage:[UIImage imageNamed:@"25"] forState:UIControlStateNormal];
    [self.TYBtn setBackgroundImage:[UIImage imageNamed:@"21"] forState:UIControlStateSelected];
    self.TYBtn.backgroundColor = [UIColor clearColor];
    [self.TYBtn addTarget:self action:@selector(TYBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.TYBtn.layer.masksToBounds = YES;
    self.TYBtn.layer.cornerRadius = 5;
    [backView addSubview:self.TYBtn];
    
    
    
    
    [self addIcon:@"19" frame:CGRectMake(10, 0,KSCREENWIDTH-60,320) View:self.backView1];
    
    [self addBtn:self.BeginBtn IMG:@"22" SIMG:nil Frame:CGRectMake(20, 570, KSCREENWIDTH*0.5-30, 45) Action:@selector(beginBtnClick) View:self.view];
    [self addBtn:self.StopBtn IMG:@"23" SIMG:nil Frame:CGRectMake(KSCREENWIDTH*0.5+10, 570,  KSCREENWIDTH*0.5-30, 45) Action:@selector(stopBtnClick) View:self.view];
    
    
    
    
    [self addIcon:@"18" frame:CGRectMake(10, 0,KSCREENWIDTH-62,320) View:self.backView2];
    
    
    //消毒UISlider
    [self addSlider:self.timeSlider1 Frame:CGRectMake(45, 145, 240, 20) Tag:1001 View:self.backView1];
    
    [self addLabText:@"0" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(57, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"5" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(92, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"10" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(124, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"15" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(158, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"20" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(192, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"25" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(225, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"30" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(260, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    
  
    
    //加热UISlider
    [self addSlider:self.timeSlider3 Frame:CGRectMake(45, 275, 240, 20) Tag:1003 View:self.backView1];
    
    [self addLabText:@"0" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(57, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"5" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(92, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"10" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(124, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"15" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(158, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"20" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(192, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"25" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(225, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    [self addLabText:@"30" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(260, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView1];
    
    
    
    
    //臭氧UISlider
    [self addSlider:self.timeSlider2 Frame:CGRectMake(45, 145, 240, 20) Tag:1002 View:self.backView2];
    
    [self addLabText:@"0" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(57, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"5" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(92, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"10" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(124, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"15" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(158, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"20" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(192, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"25" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(225, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"30" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(260, 128, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    
    
    
    //排风UISlider
    [self addSlider:self.timeSlider4 Frame:CGRectMake(45, 275, 240, 20) Tag:1004 View:self.backView2];

    
    [self addLabText:@"0" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(57, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"5" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(92, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"10" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(124, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"15" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(158, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"20" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(192, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"25" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(225, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    [self addLabText:@"30" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(260, 256, 20, 10) font:[UIFont systemFontOfSize:14] View:self.backView2];
    
    
}

- (void)addBtn:(UIButton *)btn IMG:(NSString *)iconName SIMG:(NSString *)iconSName  Frame:(CGRect)frame Action:(SEL)name View:(UIView *)view {
    btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:iconSName] forState:UIControlStateSelected];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:name forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [view addSubview:btn];
}

- (void)addIcon:(NSString *)name frame:(CGRect)frame View:(UIView *)view {
    UIImageView *icon = [[UIImageView alloc] initWithFrame:frame];
    icon.image = [UIImage imageNamed:name];
    [view addSubview:icon];
}

- (void)addLabText:(NSString *)text Color:(UIColor *)color Frame:(CGRect) frame font:(UIFont *)font View:(UIView *)view {
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = text;
    lab.textColor = color;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = font;
    lab.numberOfLines=0;
    [view addSubview:lab];
}


//设置UISlider
- (void)addSlider:(UISlider *)slider Frame:(CGRect)frame Tag:(NSInteger)tag View:(UIView *) view{
    //时间UISlider
    slider.frame = frame;
    slider.tag = tag;
    //    // These number values represent each slider position
    //    numbers = @[@(0), @(5), @(10), @(15), @(20), @(25), @(30)];
    //    // slider values go from 0 to the number of values in your numbers array
    //    NSInteger numberOfSteps = ((float)[numbers count] - 1);
    //    slider.maximumValue = numberOfSteps;
    
    slider.maximumValue = 30;
    slider.minimumValue = 0;
    slider.value = 0;// 设置初始值
    // As the slider moves it will continously call the -valueChanged:
    slider.continuous = YES; // NO makes it call only once you let go
    slider.minimumTrackTintColor = COLOR(0, 255, 255, 1);
    [slider addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];
    [view addSubview:slider];
    
}

- (void)valueChanged:(UISlider *)sender {
    // round the slider position to the nearest index of the numbers array
    NSUInteger index = (NSUInteger)(sender.value);
    [sender setValue:index animated:YES];
    
    if (sender.tag == 1001) {
        self.timeSlider1 = sender;
       
    } else if (sender.tag == 1002) {
        self.timeSlider2 = sender;
       
    } else if (sender.tag == 1003) {
        self.timeSlider3 = sender;
      
    } else if (sender.tag == 1004) {
        self.timeSlider4 = sender;
        
    }
    
}


- (void)homeBtnClick {
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)beginBtnClick {
    NSString * url = [NSString stringWithFormat:Main_URL,EQ_URL];
    
//    NSLog(@"%@",url);
    
    NSDictionary * post_dic = @{@"fk_id":@"1",
                                @"xuanfu_water":[NSString stringWithFormat:@"%d",(int)self.timeSlider1.value],
                                @"re_time":[NSString stringWithFormat:@"%d",(int)self.timeSlider3.value],
                                @"ozone_time":[NSString stringWithFormat:@"%d",(int)self.timeSlider2.value],
                                @"exhaust_time":[NSString stringWithFormat:@"%d",(int)self.timeSlider4.value],
                                @"type":[NSString stringWithFormat:@"%ld",_type],
                                @"status":@"2"};  //参数
    
//    NSLog(@"%@",post_dic);
    
    [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
        
//        NSLog(@"!!!!!%@",json);
        
        if ([[NSString stringWithFormat:@"%@",json[@"code"]] isEqualToString:@"200"]) {
            
          
            _id = json[@"id"];
            

        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
    }];

    
    
    NSString * url2 = [NSString stringWithFormat:Main_URL,@"relay_operation"];
    
    NSLog(@"%@",url2);
    
    NSDictionary * post_dic2 = @{@"status":@"1",
                                @"number":@"4",
                                @"deviceid":@"22-01-21-7f-00-00-55-18",
                                @"type":@"4"};  //参数
    
    NSLog(@"%@",post_dic2);
    
    [AFNetwork POST:url2 parameters:post_dic2 success:^(id  _Nonnull json) {
        
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",json);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
    }];

}

- (void)stopBtnClick {
    NSString * url = [NSString stringWithFormat:Main_URL,EQ_URL];
    
//    NSLog(@"%@",url);
    
    NSDictionary * post_dic = @{@"status":@"1",
                                @"fk_id":@"1",
                                @"id":_id};  //参数
    
//    NSLog(@"%@",post_dic);
    
    [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
        
//        NSLog(@"!!!!!%@",json);
        
        if ([[NSString stringWithFormat:@"%@",json[@"code"]] isEqualToString:@"200"]) {
            
            self.timeSlider1.value = 0;
            self.timeSlider2.value = 0;
            self.timeSlider3.value = 0;
            self.timeSlider4.value = 0;
            
            
        } else if ([[NSString stringWithFormat:@"%@",json[@"code"]] isEqualToString:@"202"]){
            
            
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
    }];
    
    
    NSString * url2 = [NSString stringWithFormat:Main_URL,@"relay_operation"];
    
    NSLog(@"%@",url2);
    
    NSDictionary * post_dic2 = @{@"status":@"0",
                                 @"number":@"4",
                                 @"deviceid":@"22-01-21-7f-00-00-55-18",
                                 @"type":@"4"};  //参数
    
    NSLog(@"%@",post_dic2);
    
    [AFNetwork POST:url2 parameters:post_dic2 success:^(id  _Nonnull json) {
        
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",json);
    
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
    }];

}

- (void)unKnowBtnClick {
    NSLog(@"未知");
}

- (void)ZYBtnClick {
    
    self.backView1.hidden = NO;
    self.backView2.hidden = YES;
    
    self.ZYBtn.selected = YES;
    self.TYBtn.selected = NO;
}

- (void)TYBtnClick {
    
    self.backView1.hidden = YES;
    self.backView2.hidden = NO;
    
    self.ZYBtn.selected = NO;
    self.TYBtn.selected = YES;
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
