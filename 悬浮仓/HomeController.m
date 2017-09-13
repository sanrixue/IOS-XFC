//
//  HomeController.m
//  悬浮仓
//
//  Created by 尤超 on 17/3/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "HomeController.h"
#import "YCHead.h"
#import "SBController.h"
#import "UserListController.h"
#import "ManagerController.h"


@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUpUI];
}

- (void) setUpUI {
    
    [self addIcon:@"background" frame:self.view.frame];
    
    UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 100, KSCREENWIDTH-40, 120)];
    backView1.backgroundColor = COLOR(37, 134, 144, 1);
    [self.view addSubview:backView1];
    
    UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 230, KSCREENWIDTH-40, 400)];
    backView2.backgroundColor = COLOR(37, 134, 144, 1);
    [self.view addSubview:backView2];

    [self addBtn:@"1" Frame:CGRectMake(KSCREENWIDTH-60, 35, 40, 40) action:@selector(homeBtnClick)];
    
    [self addBtn:@"2" Frame:CGRectMake(KSCREENWIDTH-120, 35, 40, 40) action:@selector(homeBtnClick)];
    
    [self addBtn:@"3" Frame:CGRectMake(40, 115, 80, 90) action:@selector(SBBtnClick)];
    
    [self addBtn:@"4" Frame:CGRectMake(KSCREENWIDTH*0.5-40, 115, 80, 90) action:@selector(userBtnClick)];
    
    [self addBtn:@"5" Frame:CGRectMake(KSCREENWIDTH-120, 115, 80, 90) action:@selector(managerBtnClick)];
    
    [self addIcon:@"6" frame:CGRectMake(40, 260, KSCREENWIDTH-80, 100)];
    [self addIcon:@"7" frame:CGRectMake(40, 380, KSCREENWIDTH-80, 100)];
    [self addIcon:@"8" frame:CGRectMake(40, 500, KSCREENWIDTH-80, 100)];

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

- (void)homeBtnClick {
    NSLog(@"未知");
}

- (void)SBBtnClick {
    SBController *VC = [[SBController alloc] init];
    
    [self presentViewController:VC animated:YES completion:nil];
}

- (void)userBtnClick {
    UserListController *VC = [[UserListController alloc] init];
    
    [self presentViewController:VC animated:YES completion:nil];
}

- (void)managerBtnClick {
    ManagerController *VC = [[ManagerController alloc] init];
    
    [self presentViewController:VC animated:YES completion:nil];
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
