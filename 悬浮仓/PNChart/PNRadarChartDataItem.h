//
//  PNRadarChartDataItem.h
//  PNChartDemo
//
//  Created by Lei on 15/7/1.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNRadarChartDataItem : NSObject

+ (instancetype)dataItemWithValue:(float)value
                      description:(NSString *)description;

@property (nonatomic) float   value;
@property (nonatomic,copy) NSString *textDescription;

@end


