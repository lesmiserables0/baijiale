
#import "GuiZeAction.h"
#import "YongHuBean.h"

@interface RuleAction()

@property (nonatomic, strong) OperateBlock  YingJiaBlock;

@property (nonatomic, strong) NSMutableArray *HuoJiangZhe;

@end

@implementation RuleAction

+ (instancetype)ShengChengAnNiu
{
    static RuleAction *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RuleAction alloc] init];
        instance.HuoJiangZhe = [NSMutableArray array];
    });
    return instance;
}

- (void)dealloc
{
    NSLog(@"RuleAction dealloc");
}

- (void)SheZhiWanChengBlock:(OperateBlock)block
{
    self.YingJiaBlock = block;
}

- (RedChoosePuKe)winnerOfBanker:(NSInteger)bankerTotal player:(NSInteger)playerTotal
{
    NSInteger playerNum = playerTotal % 10;
    NSInteger bankerNum = bankerTotal % 10;
    
    NSLog(@"compareNum, player: %ld --- banker: %ld", (long)playerNum, (long)bankerNum);
    
    if (playerNum < bankerNum) {
        return RedChoosePuKeBanker;
    } else if (playerNum > bankerNum) {
        return RedChoosePuKePlayer;
    } else {
        return RedChoosePuKeTier;
    }
}


- (void)XianShiKaPaiYingJiaJieGuo:(NSArray *)bankerCards playerCards:(NSArray *)playerCards users:(NSArray *)users isNeedPair:(BOOL)isNeedPair
{
    [self.HuoJiangZhe removeAllObjects];
    if (!bankerCards || !playerCards) {
        return;
    }
    
    NSInteger playerTotalNum = [self totalNumOfArray:playerCards];
    NSInteger bankerTotalNum = [self totalNumOfArray:bankerCards];
    
    NSInteger playerNum = playerTotalNum % 10;
    NSInteger bankerNum = bankerTotalNum % 10;
    
    if (isNeedPair) {
        BOOL bPair = [self hasPair:bankerCards];
        BOOL pPair = [self hasPair:playerCards];
//        if (bPair && !pPair) {
//            if (self.winBlock) {
//                self.winBlock((int)playerNum, (int)bankerNum, RedChoosePuKeBankerPair);
//            }
//        } else if (!bPair && pPair) {
//            if (self.winBlock) {
//                self.winBlock((int)playerNum, (int)bankerNum, RedChoosePuKePlayerPair);
//            }
//        } else {
//            [self caculateWinnerOfUsers:users playerNum:playerNum bankerNum:bankerNum];
//        }
        
        if (bPair) {
            [self.HuoJiangZhe addObject:[NSNumber numberWithInteger:RedChoosePuKeBankerPair]];
        }
        if (pPair) {
            [self.HuoJiangZhe addObject:[NSNumber numberWithInteger:RedChoosePuKePlayerPair]];
        }
        [self caculateWinnerOfUsers:users playerNum:playerNum bankerNum:bankerNum];
    } else {
        [self caculateWinnerOfUsers:users playerNum:playerNum bankerNum:bankerNum];
    }
}

- (void)caculateWinnerOfUsers:(NSArray *)users playerNum:(long)playerNum bankerNum:(long)bankerNum
{
    NSLog(@"compareNum, player: %ld --- banker: %ld", (long)playerNum, (long)bankerNum);
    
    RedChoosePuKe winner = RedChoosePuKeNone;
    if (playerNum < bankerNum) {
        winner = RedChoosePuKeBanker;
        [self.HuoJiangZhe addObject:[NSNumber numberWithInteger:RedChoosePuKeBanker]];
    } else if (playerNum > bankerNum) {
        winner = RedChoosePuKePlayer;
        [self.HuoJiangZhe addObject:[NSNumber numberWithInteger:RedChoosePuKePlayer]];
    } else {
        winner = RedChoosePuKeTier;
        [self.HuoJiangZhe addObject:[NSNumber numberWithInteger:RedChoosePuKeTier]];
    }
    
    BOOL isSmallWin = winner==RedChoosePuKeBanker;
    BOOL isBigWin = winner==RedChoosePuKeBanker;
    
    for (YongHuBean *user in users) {
        for (RoleMoney *roleMoney in user.JiaoSeJinQian) {
            if (roleMoney.JiaoSe == RedChoosePuKeSmall) {
                roleMoney.isWin = isSmallWin;
            } else if (roleMoney.JiaoSe == RedChoosePuKeBig) {
                roleMoney.isWin = isBigWin;
            } else {
                roleMoney.isWin = roleMoney.JiaoSe == winner;
            }
        }
    }
    
    if (self.YingJiaBlock) {
        self.YingJiaBlock((int)playerNum, (int)bankerNum, self.HuoJiangZhe);
    }

}

- (BOOL)hasPair:(NSArray *)array
{
    BOOL bPair = NO;
    for (int i=0; i<array.count-1; i++) {
        NSInteger iValue = [array[i] integerValue];
        for (int j=i+1; j<array.count; j++) {
            NSInteger jValue = [array[j] integerValue];
            
            if (iValue == jValue) {
                bPair = YES;
                break;
            }
        }
    }
    return bPair;
}

- (NSInteger)totalNumOfArray:(NSArray *)array
{
    NSInteger total = 0;
    for (int i=0; i<array.count; i++) {
        NSInteger iValue = [array[i] integerValue];
        if (iValue > 9) {
            iValue = 0;
        }
        total += iValue;
    }
    
    return total;
}

@end
