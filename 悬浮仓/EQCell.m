//
//  EQCell.m
//  悬浮窗
//
//  Created by 尤超 on 17/3/1.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "EQCell.h"
#import "EQModel.h"
#import "YCHead.h"

@implementation EQCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.icon = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.icon];
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(8);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-40, 100));
    }];
    
}

- (void)setEQModel:(EQModel *)EQModel {
    _EQModel = EQModel;
    
    
    NSLog(@"%@",EQModel.image);
    
    self.icon.image  = [UIImage imageNamed:EQModel.image];
}


@end
