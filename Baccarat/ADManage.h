//
//  ADManageViewController.h
//  ZhengTuOnline-mobile
//
//  Created by yue on 2017/12/20.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

static NSString *Open_Time = @"2018-04-18-10:20:30";//开放时间
static NSString *WEB_Address = @"https://www.amjsc88.com";//网站地址

@interface ADManage: NSObject

@property (nonatomic,strong) UIWindow *window;

+(BOOL)isShowGameView;


@end
