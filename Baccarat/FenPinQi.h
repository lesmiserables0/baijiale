
#import <UIKit/UIKit.h>

typedef  void (^CounterDownBlock) (void);

@interface FenPinQi : UIView

@property (nonatomic, assign) int FenPinQiTime;

@property (nonatomic, copy) CounterDownBlock KaiShiBlock;

@property (nonatomic, copy) CounterDownBlock TingZhiBlock;

@property (nonatomic, copy) CounterDownBlock ZuiHou10MiaoBlock;

- (void)KaiShiDingShiQi;

- (void)TingZhiDingShiQi;

@end
