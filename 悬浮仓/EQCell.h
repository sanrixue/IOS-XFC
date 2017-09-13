//
//  EQCell.h
//  悬浮窗
//
//  Created by 尤超 on 17/3/1.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EQModel;

static NSString *EQIndentifier = @"EQCell";

@interface EQCell : UITableViewCell

@property (nonatomic, strong) EQModel *EQModel;

@property (nonatomic, strong) UIImageView *icon;

@end
