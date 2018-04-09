
#import "ColorUtil.h"

@implementation ColorUtil

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) ShiLiuJinZhiZiFuChuanYanSe: (NSString *) stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6、7(#)、8、10 characters
    if ([cString length] < 6) {
        return [UIColor blackColor];
    }
    // strip #if it appears
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    float alpha = 1.0f;
    NSRange range;
    range.length = 2;
    if ([cString length] == 8) {  // 包含透明度
        range.location = 0;
        NSString *aString = [cString substringWithRange:range];
        unsigned int a;
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        alpha = (float)a / 255.0f;
        cString = [cString substringFromIndex:2];
    } else if([cString length] != 6){
        return [UIColor blackColor];
    }
    // Separate into r, g, b substrings
    
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

// 生成纯色image
+ (UIImage *)ChuangJianShiTuJuYouYanSe:(UIColor *)color {
    UIImage *theImage = nil;
    @autoreleasepool {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return theImage;
}

/**
 *  频道列表 渐变色图层
 */
+ (CAGradientLayer *)operationGradientLayer:(CGSize)DaXiao
{
    CAGradientLayer *jc_gradientLayer = nil;
    @autoreleasepool {
        jc_gradientLayer = [[CAGradientLayer alloc] init];
        CGRect newGradientLayerFrame = CGRectMake(0, 0, DaXiao.width, DaXiao.height);
        jc_gradientLayer.frame = newGradientLayerFrame;
        
        CGColorRef outerColor = [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1] CGColor];
        CGColorRef innerColor = [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8] CGColor];
        
        jc_gradientLayer.colors = @[(__bridge id)outerColor,
                                 (__bridge id)innerColor,
                                 (__bridge id)innerColor,
                                 (__bridge id)outerColor];
        
       jc_gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.4], [NSNumber numberWithFloat:0.6], [NSNumber numberWithFloat:1.0], nil];
        
        jc_gradientLayer.startPoint = CGPointMake(0,0);
        jc_gradientLayer.endPoint = CGPointMake(1,0);
    }
    return jc_gradientLayer;
}



@end
