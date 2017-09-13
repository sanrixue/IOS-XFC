//
//  EQModel.h
//  悬浮窗
//
//  Created by 尤超 on 17/3/1.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQModel : NSObject

@property (nonatomic, strong) NSString *image;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)eqWithDict:(NSDictionary *)dic;

@end
