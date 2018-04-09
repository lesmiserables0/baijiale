

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Color(R, G, B, A) [UIColor ColorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface ColorUtil : NSObject

+(UIColor *) ShiLiuJinZhiZiFuChuanYanSe:(NSString *) stringToConvert;

+ (UIImage *)ChuangJianShiTuJuYouYanSe:(UIColor *)Color;

+ (CAGradientLayer *)operationGradientLayer:(CGSize)DaXiao;

@end
