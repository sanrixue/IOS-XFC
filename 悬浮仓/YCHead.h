//
//  YCHead.h
//  掌声植物
//
//  Created by 尤超 on 16/9/14.
//  Copyright © 2016年 尤超. All rights reserved.
//

#ifndef YCHead_h
#define YCHead_h



#import "SVProgressHUD.h"
#import <MJRefresh.h>
#import "AFNetwork.h"
#import <Masonry.h>
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "CreatControls.h"



#define NOTIFICATION_NAME  @"selectimage"     //选取图片发送通知使用

#define kTelRegex @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"

#define backBarButton [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]

//系统通用宏
#define BFLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:@"Gfeng"]

#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define ScreenMiddle (DEVICE_HEIGHT-64-self.tabBarController.tabBar.frame.size.height)
#define ScreenSubViewHight (DEVICE_HEIGHT-64)
#define ScreenMiddle_iPhone5 455  //iphone5 除去navi 和 tabBar的高度
#define DeviceIsIphone5 ([UIScreen mainScreen].bounds.size.height == 568?YES:NO)
#define DeviceIsIOS7 ([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0? YES:NO)
#define SystemAppDelegate  (AppDelegate *)[UIApplication sharedApplication].delegate
#define safeSet(d,k,v) if (v) d[k] = v;

#define Back_W  11
#define Back_H  30
/**
 *  Get App name
 */
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**
 *  Get App build
 */
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/**
 *  Get App version
 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 *  Get AppDelegate
 */
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//  主要单例
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]



//设置加载图片 颜色
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define loadImage(Name)  [UIImage   imageNamed:Name]

#define LineColor COLOR(223, 223, 223, 1)  //常用灰色线条的颜色
#define CommonBlueColor COLOR(0, 155, 200, 1) //整体蓝


//屏幕高度
#define   KNagHEIGHT  self.navigationController.navigationBar.bounds.size.height-20
#define   KSCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define   KSCREENHEIGHT  [UIScreen mainScreen].bounds.size.height



//颜色设置
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFormRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define backBarButton [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]





/****************************请求地址*******************************/

//根URL
#define Main_URL @"http://www.meng-jing.com/%@"

//管理员
#define Manager_URL @"interfaces_suspended_material"

//设备当前状态
#define EQNow_URL @"interfaces_suspended_manage"

//设备维护
#define EQ_URL @"interfaces_suspended_managesave"

//手机查询
#define Phone_URL @"intefaces_suspended_selectByPhone"

//开启悬浮仓
#define Begin_URL @"interfaces_suspended_insert"

//查询悬浮仓
#define UserNow_URL @"interfaces_suspended_select"


#endif /* YCHead_h */
