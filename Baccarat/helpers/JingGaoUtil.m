
#import "JingGaoUtil.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "UserDefaults.h"
#import "ColorUtil.h"

// 在RootViewController.view上显示的MBProgressHUD
static MBProgressHUD *hudJingGaoView;

// 在UIWindow上显示的MBProgressHUD
static MBProgressHUD *hudJingGaoViewZaiWindow;

@implementation JingGaoUtil

/**
 *  在view之上显示提示框
 *  @param viewFrameY  view相对父类的y坐标值
 *  @param text
 *  @param height  弹出框距离view顶部的高度
 */
+(void) XianShiJingGaoShiTu:(float) ShiTuZuoBiaoY withText:(NSString *) WenBen offsetY:(float) Gao{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showJingGaoAboveView 提示框显示:%@",WenBen);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        UIViewController *GenVC = window.rootViewController;
        UIView *view = GenVC.view;
        MBProgressHUD *jc_hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        
        jc_hud.mode = MBProgressHUDModeText;
        jc_hud.labelText = @"";
        jc_hud.detailsLabelText = WenBen;
        jc_hud.detailsLabelFont = [UIFont systemFontOfSize:14];
        jc_hud.margin = 10.f;
        
        CGRect bounds = view.bounds;
        NSInteger yOffset = ShiTuZuoBiaoY - bounds.size.height / 2 - Gao ;
        jc_hud.yOffset = yOffset;
        jc_hud.removeFromSuperViewOnHide = YES;
        // 不接收点击等事件，显示时hud之下的view可接收点击事件
        jc_hud.userInteractionEnabled = NO;
        
        [jc_hud hide:YES afterDelay:1.5];
    });
}

/**
 * 注：MBProgressHUD弹窗必须在主线程中弹出，否者弹出无法消失
 */

/**
 *  显示无网络连接提示框
 */
+(void) XianShiWuWangLuoJingGao {
    dispatch_async(dispatch_get_main_queue(), ^{
        [JingGaoUtil ZaiXiangGuanJieMianXianShiJingGaoKuang:@"当前无网络，请检查网络！"];
    });
}

/**
 * 延迟显示弹出框
 */
+(void) XianshiJingGaoKuangWenBen:(NSString *)WenBen ZhiHouYanChi:(NSTimeInterval) YanChi{
    [self performSelector:@selector(XianshiJingGaoKuangWenBen:) withObject:WenBen afterDelay:YanChi];
}

+ (void)XianshiJingGaoKuangWenBen:(NSString *)WenBen
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showJingGaoWithText 提示框显示:%@",WenBen);
        // 修改：2014-06-06 keyWindow获取到的类型不一定为UIWindow，例如可能为_UIJingGaoOverlayWindow，其他类型暂时未知
        //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        UIViewController *rootVC = window.rootViewController;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:rootVC.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"";
        hud.detailsLabelText = WenBen;
        hud.detailsLabelFont = [UIFont systemFontOfSize:14];
        hud.margin = 10.f;
        hud.yOffset = 130.f + (iPhone5 ? 20.0f : 0.0f);
        hud.removeFromSuperViewOnHide = YES;
        // 不接收点击等事件，显示时hud之下的view可接收点击事件
        hud.userInteractionEnabled = NO;
        
        [hud hide:YES afterDelay:1.5];
    });
}

/**
 *  主要用于通话中相关界面、P2PService 显示JingGao
 *
 *  @param text
 */
+ (void)ZaiXiangGuanJieMianXianShiJingGaoKuang:(NSString *)WenBen
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"ZaiXiangGuanJieMianXianShiJingGaoKuang 提示框显示:%@",WenBen);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"";
        hud.detailsLabelText = WenBen;
        hud.detailsLabelFont = [UIFont systemFontOfSize:14];
        hud.margin = 10.f;
        hud.yOffset = 130.f + (iPhone5 ? 20.0f : 0.0f);
        if (iPhone4) {
            hud.yOffset = 0.0f;
        }
        hud.removeFromSuperViewOnHide = YES;
        // 不接收点击等事件，显示时hud之下的view可接收点击事件
        hud.userInteractionEnabled = NO;
        
        [hud hide:YES afterDelay:1.5];
    });
}

+ (void)showCheckmarkJingGao:(NSString *)WenBen FailOrNot:(BOOL)success
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showCheckmarkJingGao 提示框显示:%@",WenBen);
        NSString *imgFileName = @"ic_checkmark_success";
        if (!success) {
            imgFileName = @"ic_checkmark_failure";
        }
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        UIViewController *rootVC = window.rootViewController;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:rootVC.view animated:YES];
        
        hud.mode = MBProgressHUDModeCustomView;
        UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgFileName]];
        [customView setBounds:CGRectMake(0, 0, 37, 37)];
        hud.customView = customView;
        
        hud.labelText = WenBen;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1.5];
    });
}
/**
 *  显示等待框
 */
+ (void)showWaitingJingGaoWithText:(NSString *)WenBen
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showWaitingJingGaoWithText 提示框显示:%@",WenBen);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        UIViewController *rootVC = window.rootViewController;
        if (hudJingGaoView) {
            [hudJingGaoView removeFromSuperview];
            hudJingGaoView = nil;
        }
        hudJingGaoView = [MBProgressHUD showHUDAddedTo:rootVC.view animated:YES];
        hudJingGaoView.labelText = ((WenBen && WenBen.length > 0) ? WenBen : @"请稍候");
//        [window addSubview:hudJingGaoView];
    });
}

/**
 *  主要用于通话中相关界面、SipService 显示等待框
 *
 *  @param text
 */
+ (void)XianShiZaiTongHuaJieMianDengDeDengDaiKuang:(NSString *)WenBen;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showWaitingAlertInWindowWithText 提示框显示:%@",WenBen);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        
        if (hudJingGaoViewZaiWindow) {
            [hudJingGaoViewZaiWindow removeFromSuperview];
            hudJingGaoViewZaiWindow = nil;
        }
        hudJingGaoViewZaiWindow = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hudJingGaoViewZaiWindow.labelText = ((WenBen && WenBen.length > 0) ? WenBen : @"请稍候");
    });
}
/**
 *  隐藏等待框
 */
+ (void)YinCangDengDaiKuang
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"YinCangDengDaiKuang");
        if (hudJingGaoView) {
            [hudJingGaoView removeFromSuperview];
            hudJingGaoView = nil;
        }
    });
}

+ (void)YinCangDengDaiKuangZaiZhuXianCheng
{
    NSLog(@"YinCangDengDaiKuangZaiZhuXianCheng");
    if (hudJingGaoView) {
        [hudJingGaoView removeFromSuperview];
        hudJingGaoView = nil;
    }
}

/**
 *  隐藏显示在UIWindow上的等待框
 */
+ (void)performWaitingJingGaoInWindowDismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"performWaitingJingGaoInWindowDismiss");
        if (hudJingGaoViewZaiWindow) {
            [hudJingGaoViewZaiWindow removeFromSuperview];
            hudJingGaoViewZaiWindow = nil;
        }
    });
}

/**
 * 在旧的的JingGaoView上显示内容，如果没有则显示新的
 */
+(void) XianShiJiuJingGaoShiTuRuGuoMeiYouXianShiXinDe:(NSString *)WenBen {
    NSLog(@"XianShiJiuJingGaoShiTuRuGuoMeiYouXianShiXinDe:%@",WenBen);
    if (hudJingGaoView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            hudJingGaoView.labelText = ((WenBen &&WenBen.length > 0) ? WenBen : @"请稍候");
        });
    } else {
        [JingGaoUtil showWaitingJingGaoWithText:WenBen];
    }
}

/**
 *  检查网络
 */
+ (BOOL)JianChaWangLuo
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    if (defaultRouteReachability) {
        CFRelease(defaultRouteReachability);
    }
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}


+ (void)XianShiYongHuJieMian:(NSString *)YingJia HaoMa:(NSString *)WenBen;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showJingGaoWithText 提示框显示:%@",WenBen);

        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
//        UIViewController *rootVC = window.rootViewController;
                
        MBProgressHUD *jc_hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        
        jc_hud.mode = MBProgressHUDModeText;
        
        jc_hud.labelText = YingJia;
        jc_hud.detailsLabelText = WenBen;
        jc_hud.detailsLabelFont = [UIFont boldSystemFontOfSize:20.0];
        jc_hud.margin = 10.f;
        jc_hud.yOffset = 0;
       jc_hud.removeFromSuperViewOnHide = YES;
       jc_hud.detailsLabelColor = [UIColor whiteColor];
        jc_hud.minSize = CGSizeMake(215, 60);
        // 不接收点击等事件，显示时hud之下的view可接收点击事件
      jc_hud.userInteractionEnabled = NO;
        
        [jc_hud hide:YES afterDelay:1.5];
    });
}
@end
