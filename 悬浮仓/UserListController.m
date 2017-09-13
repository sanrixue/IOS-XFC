//
//  UserListController.m
//  悬浮窗
//
//  Created by 尤超 on 17/2/28.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "UserListController.h"
#import "YCHead.h"
#import "EQListController.h"

@interface UserListController () <UITableViewDelegate,UITableViewDataSource>{
    
    
    NSMutableArray *_array;
}

@property (nonatomic, strong) UITextField *phone;

@property (nonatomic, strong) UITableView *tabeleView;

@end

@implementation UserListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if ([self.phone.text isEqualToString:@""]) {
        
    } else {
    
    
        NSString * url = [NSString stringWithFormat:Main_URL,Phone_URL];
        
        NSLog(@"%@",url);
        
        NSDictionary * post_dic = @{@"phone":self.phone.text};  //参数
        
        NSLog(@"%@",post_dic);
        
        [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
            
            NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",json);
            
            _array = json[@"list"];
            [self.tabeleView reloadData];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败: %@",error);
        }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
    

    [self setUpUI];
    
    _array = [NSMutableArray array];
    
    self.tabeleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, KSCREENWIDTH, KSCREENHEIGHT-170) style:UITableViewStylePlain];
    self.tabeleView.delegate = self;
    self.tabeleView.dataSource = self;
    self.tabeleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tabeleView];
    
    
}

- (void)setUpUI {
    [self addIcon:@"background" frame:self.view.frame];

    [self addBtn:@"1" Frame:CGRectMake(KSCREENWIDTH-60, 35, 40, 40) action:@selector(homeBtnClick)];
    
    [self addBtn:@"2" Frame:CGRectMake(KSCREENWIDTH-120, 35, 40, 40) action:@selector(unKnowBtnClick)];
    
    self.phone = [[UITextField alloc] initWithFrame:CGRectMake(100, 80, KSCREENWIDTH-200, 40)];
    self.phone.placeholder = @"请输入手机号";
    self.phone.keyboardType = UIKeyboardTypePhonePad;
    self.phone.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.phone];
    
#warning 111111
//    self.phone.text = @"18717905170";
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 125, KSCREENWIDTH-260,40)];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    searchBtn.backgroundColor = COLOR(0, 255, 255, 1);
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = 10;
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];

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
    [self dismissViewControllerAnimated:YES completion: nil];
}

#warning 2222
- (void)unKnowBtnClick {
    NSLog(@"未知");
}

- (void)searchBtnClick {
    NSString * url = [NSString stringWithFormat:Main_URL,Phone_URL];
    
    NSLog(@"%@",url);
    
    NSDictionary * post_dic = @{@"phone":self.phone.text};  //参数
    
    NSLog(@"%@",post_dic);
    
    [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
        
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",json);
        
        _array = json[@"list"];
        [self.tabeleView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
    }];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [self.tabeleView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"订单号:%@",_array[indexPath.row][@"no"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EQListController *userVC = [[EQListController alloc] init];
    userVC.pro_indent_id =[NSString stringWithFormat:@"%@",_array[indexPath.row][@"pro_indent_id"]];
    [self presentViewController:userVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
    
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
