
#import "YunDanBean.h"

@implementation YunDanBean

- (instancetype)initWithWanJiaHaoMa:(int)WanJiaHaoMa ZhuangJiaHaoMa:(int)ZhuangJiaHaoMa
{
    self = [super init];
    if (self) {
        self.WanJiaHaoMa = WanJiaHaoMa;
        self.ZhuangJiaHaoMa = ZhuangJiaHaoMa;
    }
    return  self;
}

@end
