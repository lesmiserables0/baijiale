
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RedChoosePuKe) {    //下注方
    RedChoosePuKeNone = 0,      // 没选择
    RedChoosePuKePlayer = 1,    // 闲家
    RedChoosePuKeBanker = 2,    // 庄家
    RedChoosePuKeTier = 3,      // 和
    RedChoosePuKePlayerPair = 4,    // 闲对
    RedChoosePuKeBankerPair = 5,    // 庄对
    RedChoosePuKeSmall = 6,
    RedChoosePuKeBig = 7,
};

typedef void (^OperateBlock) (int playerNum, int bankerNum, NSArray *winners);

@interface RuleAction : NSObject

+ (instancetype)ShengChengAnNiu;

- (void)SheZhiWanChengBlock:(OperateBlock)block;

- (void)XianShiKaPaiYingJiaJieGuo:(NSArray *)bankerCards playerCards:(NSArray *)playerCards users:(NSArray *)users isNeedPair:(BOOL)isNeedPair;

@end
