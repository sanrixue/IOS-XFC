//
//  UserController.m
//  悬浮仓
//
//  Created by 尤超 on 17/3/16.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "UserController.h"
#import "YCHead.h"

@interface UserController ()<UIAlertViewDelegate> {
    
    NSArray *numbers;
    
    NSMutableString *_id;
}

@property (nonatomic, strong) UIView *backView1;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UIView *backView3;
@property (nonatomic, strong) UISwitch *lightBtn;
@property (nonatomic, strong) UISwitch *musicBtn;
@property (nonatomic, strong) UISlider *timeSlider;

@property (nonatomic, strong) UIButton *ZYBtn;
@property (nonatomic, strong) UIButton *TYBtn;
@property (nonatomic, strong) UIButton *beginBtn;
@property (nonatomic, strong) UIButton *stopBtn;

@end

@implementation UserController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
    if (self.pro_indent_id != nil) {
        
        NSString * url = [NSString stringWithFormat:Main_URL,UserNow_URL];
        
        NSLog(@"%@",url);
        
        NSDictionary * post_dic = @{@"id":@"1"};  //参数
        
        NSLog(@"%@",post_dic);
        
        [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
            
            NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",json);
            
            if ([[NSString stringWithFormat:@"%@",json[@"code"]] isEqualToString:@"200"]) {
                
                
                // 获得日期对象
                NSDateFormatter *formatter_ = [[NSDateFormatter alloc] init];
                formatter_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSDate *createDate = [formatter_  dateFromString:json[@"data"][@"startTime"]];
                NSDate *currentDate = [NSDate date];//获取当前时间，日期
                // 对比时间差
                NSTimeInterval time = [currentDate timeIntervalSinceDate:createDate];
                
                NSLog(@"%f",time);
                
                int max = [json[@"data"][@"time"] intValue];
                
                if (time<max*60) {
                    self.timeSlider.value = (int)((max-time/60)/15);
                } else {
                    self.timeSlider.value = 0;
                }
                
                _id = json[@"data"][@"id"];
                
                
                if ([[NSString stringWithFormat:@"%@",json[@"data"][@"isLamp"]] isEqualToString:@"1"] ) {
                    [self.lightBtn setOn:YES];
                } else {
                    [self.lightBtn setOn:NO];
                }
                
                if ([[NSString stringWithFormat:@"%@",json[@"data"][@"isMusic"]] isEqualToString:@"1"] ) {
                    [self.musicBtn setOn:YES];
                } else {
                    [self.musicBtn setOn:NO];
                }
                
                [self addLabText:@"欢迎您！" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(40, 10, 50, 10) font:[UIFont systemFontOfSize:12] View:self.backView3];
                [self addLabText:[NSString stringWithFormat:@"性别:%@",json[@"data"][@"sex"]] Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(45, 75, 30, 10) font:[UIFont systemFontOfSize:8] View:self.backView3];
                
                //年龄
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *date = [dateFormatter dateFromString:json[@"data"][@"birthday"]];
                NSLog(@"%@", date);
                
                NSInteger age = [self ageWithDateOfBirth:date];
                
                [self addLabText:[NSString stringWithFormat:@"年龄:%ld",age] Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(105, 75, 35, 10) font:[UIFont systemFontOfSize:8] View:self.backView3];
                
                
                [self addLabText:@"健康状态:良好" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(160, 75, 60, 10) font:[UIFont systemFontOfSize:8] View:self.backView3];
                [self addLabText:@"106" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(225, 20, 100, 80) font:[UIFont systemFontOfSize:60] View:self.backView3];

                
            } else if ([[NSString stringWithFormat:@"%@",json[@"code"]] isEqualToString:@"203"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"该悬浮仓未开启" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败: %@",error);
        }];
        
    }
    
    
}

- (NSInteger)ageWithDateOfBirth:(NSDate *)date;
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpUI];
}

- (void) setUpUI {
    
    [self addIcon:@"background" frame:self.view.frame View:self.view];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 120, KSCREENWIDTH-40, 80)];
    backView.backgroundColor = COLOR(16, 61, 76, 1);
    [self.view addSubview:backView];
    
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 230, KSCREENWIDTH-40, 400)];
    self.backView1.backgroundColor = COLOR(16, 61, 76, 1);
    [self.view addSubview:self.backView1];
    self.backView1.hidden = NO;
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 230, KSCREENWIDTH-40, KSCREENHEIGHT-230)];
    self.backView2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backView2];
    self.backView2.hidden = YES;
    
    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, KSCREENWIDTH-40, 100)];
    self.backView3.backgroundColor = COLOR(16, 61, 76, 1);
    [self.backView2 addSubview:self.backView3];
    
    UIView *backView4 = [[UIView alloc] initWithFrame:CGRectMake(20, 110, KSCREENWIDTH-40, 200)];
    backView4.backgroundColor = COLOR(16, 61, 76, 1);
    [self.backView2 addSubview:backView4];
    
    [self addBtn:nil IMG:@"1" SIMG:nil Frame:CGRectMake(KSCREENWIDTH-60, 35, 40, 40) Action:@selector(homeBtnClick) View:self.view];
    
    [self addBtn:nil IMG:@"2" SIMG:nil Frame:CGRectMake(KSCREENWIDTH-120, 35, 40, 40) Action:@selector(unKnowBtnClick) View:self.view];
    
    [self addLabText:@"用户管理" Color:COLOR(28, 115, 125, 1) Frame:CGRectMake(20, 90, 150, 25) font:[UIFont systemFontOfSize:25] View:self.view];
 
    
    self.ZYBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, KSCREENWIDTH*0.5-50, 40)];
    [self.ZYBtn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    [self.ZYBtn setBackgroundImage:[UIImage imageNamed:@"9"] forState:UIControlStateSelected];
    self.ZYBtn.backgroundColor = [UIColor clearColor];
    [self.ZYBtn addTarget:self action:@selector(ZYBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.ZYBtn.layer.masksToBounds = YES;
    self.ZYBtn.layer.cornerRadius = 5;
    [backView addSubview:self.ZYBtn];
    self.ZYBtn.selected = YES;
    

    self.TYBtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5-10, 20, KSCREENWIDTH*0.5-50, 40)];
    [self.TYBtn setBackgroundImage:[UIImage imageNamed:@"10"] forState:UIControlStateNormal];
    [self.TYBtn setBackgroundImage:[UIImage imageNamed:@"16"] forState:UIControlStateSelected];
    self.TYBtn.backgroundColor = [UIColor clearColor];
    [self.TYBtn addTarget:self action:@selector(TYBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.TYBtn.layer.masksToBounds = YES;
    self.TYBtn.layer.cornerRadius = 5;
    [backView addSubview:self.TYBtn];

    
    
  
    [self addIcon:@"11" frame:CGRectMake(30, 0,KSCREENWIDTH-100,360) View:self.backView1];
   
    [self addBtn:self.beginBtn IMG:@"13" SIMG:nil Frame:CGRectMake(80, 320, KSCREENWIDTH-200, 45) Action:@selector(beginBtnClick) View:self.backView2];
    [self addBtn:self.stopBtn IMG:@"14" SIMG:nil Frame:CGRectMake(80, 375, KSCREENWIDTH-200, 45) Action:@selector(stopBtnClick) View:self.backView2];
    
    [self addIcon:@"12" frame:CGRectMake(0, 0,KSCREENWIDTH-40,200) View:backView4];
    
    self.lightBtn = [[UISwitch alloc] initWithFrame:CGRectMake(245, 76 , 30, 20)];
    self.lightBtn.onTintColor =  COLOR(0, 255, 255, 1);
    self.lightBtn.transform= CGAffineTransformMakeScale(0.75,0.75);
    [backView4 addSubview:self.lightBtn];
    
    self.musicBtn = [[UISwitch alloc] initWithFrame:CGRectMake(245, 137, 30, 20)];
    self.musicBtn.onTintColor =  COLOR(0, 255, 255, 1);
    self.musicBtn.transform= CGAffineTransformMakeScale(0.75,0.75);
    [backView4 addSubview:self.musicBtn];

    //时间UISlider
    self.timeSlider = [[UISlider alloc] initWithFrame:CGRectMake(35, 150, 140, 20)];
    // These number values represent each slider position
    numbers = @[@(0), @(15), @(30), @(45), @(60)];
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[numbers count] - 1);
    self.timeSlider.maximumValue = numberOfSteps;
    self.timeSlider.minimumValue = 0;
    self.timeSlider.value = (self.timeSlider.minimumValue + self.timeSlider.maximumValue) / 2;// 设置初始值
    // As the slider moves it will continously call the -valueChanged:
    self.timeSlider.continuous = YES; // NO makes it call only once you let go
    self.timeSlider.minimumTrackTintColor = COLOR(0, 255, 255, 1);
    [self.timeSlider addTarget:self
                        action:@selector(valueChanged:)
              forControlEvents:UIControlEventValueChanged];
    [backView4 addSubview:self.timeSlider];
    
    
    
    [self addLabText:@"0" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(45, 132, 20, 10) font:[UIFont systemFontOfSize:14] View:backView4];
    [self addLabText:@"15" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(70, 132, 20, 10) font:[UIFont systemFontOfSize:14] View:backView4];
    [self addLabText:@"30" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(98, 132, 20, 10) font:[UIFont systemFontOfSize:14] View:backView4];
    [self addLabText:@"45" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(126, 132, 20, 10) font:[UIFont systemFontOfSize:14] View:backView4];
    [self addLabText:@"60" Color:COLOR(36, 130, 141, 1) Frame:CGRectMake(152, 132, 20, 10) font:[UIFont systemFontOfSize:14] View:backView4];
    
    
    [self addIcon:@"17" frame:CGRectMake(20, 20, 200, 80) View:self.backView3];
//    [self addLabText:@"欢迎您！" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(40, 10, 50, 10) font:[UIFont systemFontOfSize:12] View:backView3];
//    [self addLabText:@"性别:女" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(45, 75, 30, 10) font:[UIFont systemFontOfSize:8] View:backView3];
//    [self addLabText:@"年龄:30" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(105, 75, 35, 10) font:[UIFont systemFontOfSize:8] View:backView3];
//    [self addLabText:@"健康状态:良好" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(160, 75, 60, 10) font:[UIFont systemFontOfSize:8] View:backView3];
//    [self addLabText:@"106" Color:COLOR(0, 255, 255, 1) Frame:CGRectMake(230, 20, 100, 80) font:[UIFont systemFontOfSize:60] View:backView3];

    
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


- (void)valueChanged:(UISlider *)sender {
    // round the slider position to the nearest index of the numbers array
    NSUInteger index = (NSUInteger)(sender.value);
    [sender setValue:index animated:NO];
    
}

- (void)beginBtnClick {
    
    if (self.pro_indent_id != nil) {
        NSUInteger index = (NSUInteger)(self.timeSlider.value);
        
        NSString * url = [NSString stringWithFormat:Main_URL,Begin_URL];
        
        NSLog(@"%@",url);
        
        BOOL isLightON = [self.lightBtn isOn];
        BOOL isMusicON = [self.musicBtn isOn];
        
        
        NSDictionary * post_dic = @{@"fkid":@"1",
                                    @"orderId":self.pro_indent_id,
                                    @"time":[NSString stringWithFormat:@"%ld",index*15],
                                    @"is_lamp":[NSString stringWithFormat:@"%d",isLightON],
                                    @"is_music":[NSString stringWithFormat:@"%d",isMusicON],
                                    @"status":@"1",
                                    @"user_name":@"xiaodeng"};  //参数
        
        NSLog(@"%@",post_dic);
        
        [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
            
            NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",json);
            
            if ([json[@"code"] isEqualToString:@"200"]) {
                
               
                
                _id = json[@"data"][@"id"];
                
            } else if ([json[@"code"] isEqualToString:@"201"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"该订单已被体验" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            } else if ([json[@"code"] isEqualToString:@"203"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"该悬浮仓正在体验" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败: %@",error);
        }];
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请从用户页面开始体验" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    
}



- (void)stopBtnClick {
    NSString * url = [NSString stringWithFormat:Main_URL,Begin_URL];
    
    NSLog(@"%@",url);
    
    
    
    NSDictionary * post_dic = @{@"status":@"2",
                                @"fkid":@"1",
                                @"id":_id};  //参数
    
    NSLog(@"%@",post_dic);
    
    [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
        
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",json);
        
        if ([[NSString stringWithFormat:@"%@",json[@"code"]] isEqualToString:@"200"]) {
            
            self.timeSlider.value = 0;
            
            self.beginBtn.userInteractionEnabled = YES;
            
            [self.musicBtn setOn:NO];
            [self.lightBtn setOn:NO];
            
        } else if ([[NSString stringWithFormat:@"%@",json[@"code"]] isEqualToString:@"202"]){
            
            
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
    }];
    
}



#warning 22222
- (void)homeBtnClick {
    [self dismissViewControllerAnimated:YES completion: nil];
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
