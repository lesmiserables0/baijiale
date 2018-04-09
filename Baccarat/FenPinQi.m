
#import "FenPinQi.h"

#define DegreeToAngle(degrees)((M_PI * degrees)/180)

@interface FenPinQi()

@property (nonatomic, strong) NSTimer *DingShiQi;

@property (nonatomic, assign) BOOL YunXing;

@property (nonatomic, assign) float ZuiChuDeFenPinQi;

@property (nonatomic, assign) int FenPinQiKaoBei;

@end

@implementation FenPinQi

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.YunXing = NO;
        [super setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)KaiShiDingShiQi
{
    if (self.YunXing) {
        [self TingZhiDingShiQi];
    }
    self.YunXing = YES;
    self.FenPinQiKaoBei= self.FenPinQiTime;
    self.ZuiChuDeFenPinQi = self.FenPinQiTime;
    self.DingShiQi = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(GengXinQuan) userInfo:nil repeats:YES];
    if (self.KaiShiBlock) {
        self.KaiShiBlock();
    }
}

- (void)TingZhiDingShiQi
{
    [self.DingShiQi invalidate];
    self.DingShiQi= nil;
    self.YunXing = NO;
    self.hidden = YES;
}

- (void)GengXinQuan
{
    if ([self KeYiYunXing]) {
        self.hidden = NO;
        if (self.YunXing) {
            self.FenPinQiKaoBei--;
            if (self.FenPinQiKaoBei == 10) {
                if (self.ZuiHou10MiaoBlock) {
                    self.ZuiHou10MiaoBlock();
                }
            }
            [self setNeedsDisplay];
        }
    } else {
        [self TingZhiDingShiQi];
        if (self.TingZhiBlock) {
            self.TingZhiBlock();
        }
    }
}

- (BOOL)KeYiYunXing
{
    return self.FenPinQiKaoBei > 1;
}

- (void)drawRect:(CGRect)rect
{
    // draw text
    if (self.FenPinQiKaoBei > 0) {
        NSString *text = [NSString stringWithFormat:@"%d", self.FenPinQiKaoBei];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[UIFont systemFontOfSize:20.0] forKey:NSFontAttributeName];
        [dic setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        
        CGSize size = [text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
        CGPoint textOrigin = CGPointMake((CGRectGetWidth(self.bounds) - size.width)/2.0, (CGRectGetHeight(self.bounds) - size.height)/2.0);
        [text drawAtPoint:textOrigin withAttributes:dic];
    }
}


@end
