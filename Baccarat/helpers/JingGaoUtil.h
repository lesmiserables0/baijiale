
#import <Foundation/Foundation.h>

@interface JingGaoUtil : NSObject

/**
 *  在view之上显示提示框
 *  @param ShiTuZuoBiaoY  view相对父类的y坐标值
 *  @param WenBen
 *  @param Gao  弹出框距离view顶部的高度
 */
+(void) XianShiJingGaoShiTu:(float) ShiTuZuoBiaoY withText:(NSString *) WenBen offsetY:(float) Gao;

/**
 *  显示无网络连接提示框
 */
+(void) XianShiWuWangLuoJingGao;

/**
 * 延迟显示弹出框
 */
+(void) XianshiJingGaoKuangWenBen:(NSString *)WenBen ZhiHouYanChi:(NSTimeInterval) YanChi;

/**
 *  显示一个类似Toast提示消息，显示1s后自动消失
 */
+ (void)XianshiJingGaoKuangWenBen:(NSString *)WenBen;

/**
 *  主要用于操作结果成功与否的提示
 */
+ (void)showCheckmarkJingGao:(NSString *)WenBen FailOrNot:(BOOL)success;

/**
 *  显示等待框
 */
+ (void)showWaitingJingGaoWithText:(NSString *)WenBen;

/**
 *  隐藏等待框
 */
+ (void)YinCangDengDaiKuang;

+ (void)YinCangDengDaiKuangZaiZhuXianCheng;

/**
 *  隐藏显示在UIWindow上的等待框
 */
+ (void)performWaitingJingGaoInWindowDismiss;

/**
 *  检查网络
 */
+ (BOOL)JianChaWangLuo;

/**
 * 在旧的的JingGaoView上显示内容，如果没有则显示新的
 */
+(void) XianShiJiuJingGaoShiTuRuGuoMeiYouXianShiXinDe:(NSString *)WenBen;

/**
 *  主要用于通话中相关界面、P2PService 显示JingGao
 *
 *  @param WenBen
 */
+ (void)ZaiXiangGuanJieMianXianShiJingGaoKuang:(NSString *)WenBen;

/**
 *  主要用于通话中相关界面、P2PService 显示等待框
 *
 *  @param WenBen
 */
+ (void)XianShiZaiTongHuaJieMianDengDeDengDaiKuang:(NSString *)WenBen;

+ (void)XianShiYongHuJieMian:(NSString *)YingJia HaoMa:(NSString *)WenBen;

@end
