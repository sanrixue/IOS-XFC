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
    

    
    
    _array = [NSMutableArray array];
    
    
    NSDictionary *dic = @{@"image":@"test.png"
                          };
    for (int i = 0; i<1; i++) {
        [_array addObject:dic];
    }
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
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
    [self.navigationController pushViewController:userVC animated:YES];

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
