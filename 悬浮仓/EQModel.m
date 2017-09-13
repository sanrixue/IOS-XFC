//
//  EQModel.m
//  悬浮窗
//
//  Created by 尤超 on 17/3/1.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "EQModel.h"

@implementation EQModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.image = [dic valueForKey:@"image"];
        
    }
    return self;
    
}

+ (instancetype)eqWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
