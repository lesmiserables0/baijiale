
#import <Foundation/Foundation.h>

@interface YunDanBean : NSObject

@property (nonatomic, assign) int ZhuangJiaHaoMa;

@property (nonatomic, assign) int WanJiaHaoMa;

- (instancetype)initWithWanJiaHaoMa:(int)WanJiaHaoMa ZhuangJiaHaoMa:(int)ZhuangJiaHaoMa;

@end
