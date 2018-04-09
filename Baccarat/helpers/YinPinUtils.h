
#import <Foundation/Foundation.h>

@interface YinPinUtils : NSObject

+ (void)play:(NSString *)MingZi;

+ (void)GuanBiYingXiangJuYouWanChengBlock:(void (^)(BOOL isAllow)) completeBlock;

+ (BOOL)YunXuYingXiangWan;


@end
