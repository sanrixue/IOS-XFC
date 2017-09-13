//
//  EQListController.m
//  悬浮窗
//
//  Created by 尤超 on 17/3/1.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "EQListController.h"
#import "EQCell.h"
#import "EQModel.h"
#import "YCHead.h"
#import "UserController.h"

@interface EQListController ()<UITableViewDelegate,UITableViewDataSource> {
   
    NSMutableArray * _array;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EQListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTitle:@"悬浮仓"];
    
    [self addIcon:@"background" frame:self.view.frame];
    
    [self addBtn:@"1" Frame:CGRectMake(KSCREENWIDTH-60, 35, 40, 40) action:@selector(homeBtnClick)];
    
    [self addBtn:@"2" Frame:CGRectMake(KSCREENWIDTH-120, 35, 40, 40) action:@selector(unKnowBtnClick)];
    
    
    [self addLabText:@"悬浮仓" Color:COLOR(28, 115, 125, 1) Frame:CGRectMake(20, 90, 150, 25) font:[UIFont systemFontOfSize:25] View:self.view];

    
    _array = [NSMutableArray array];
    
    
    NSDictionary *dic = @{@"image":@"7.png"
                          };
    for (int i = 0; i<1; i++) {
        [_array addObject:dic];
    }
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, KSCREENWIDTH, KSCREENHEIGHT-130) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //注册表格单元
    [self.tableView registerClass:[EQCell class] forCellReuseIdentifier:EQIndentifier];
    
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    EQModel *eqModel = [EQModel eqWithDict:dic];
    
    
    
    EQCell *cell = [tableView dequeueReusableCellWithIdentifier:EQIndentifier];
    
    //传递模型给cell
    cell.EQModel = eqModel;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
    
}


//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserController *userVC = [[UserController alloc] init];
    userVC.pro_indent_id = self.pro_indent_id;
    NSLog(@"%@",self.pro_indent_id);
    [self presentViewController:userVC animated:YES completion:nil];


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

- (void)addLabText:(NSString *)text Color:(UIColor *)color Frame:(CGRect) frame font:(UIFont *)font View:(UIView *)view {
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = text;
    lab.textColor = color;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = font;
    lab.numberOfLines=0;
    [view addSubview:lab];
}

- (void)addIcon:(NSString *)name frame:(CGRect)frame {
    UIImageView *icon = [[UIImageView alloc] initWithFrame:frame];
    icon.image = [UIImage imageNamed:name];
    [self.view addSubview:icon];
}

- (void)homeBtnClick {
    [self dismissViewControllerAnimated:YES completion: nil];
}

#warning 2222
- (void)unKnowBtnClick {
    NSLog(@"未知");
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
