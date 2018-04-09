
#import "SingleViewController.h"
#import "ShuiPingView.h"
#import "UserDefaults.h"

@interface SingleViewController ()

@property (nonatomic, strong) ShuiPingView *ShuiPingView;

@end

@implementation SingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    float orightW = 667;
    float orightH = 375;
    float ratioW = ScreenWidth / orightW;
    float ratioH = ScreenHeight / orightH;

    self.ShuiPingView = [[ShuiPingView alloc] initWithFrame:CGRectMake(30 * ratioW, 32 * ratioH, 280 * ratioW, 304 * ratioH)];
    [self.view addSubview:self.ShuiPingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addSingleItem:(int)WanJiaHaoMa bankerNum:(int)ZhuangJiaHaoMa
{
    NSString *JieGuoTuPianName = nil;
    if (WanJiaHaoMa < ZhuangJiaHaoMa) {
        JieGuoTuPianName = @"ic_banker";
    } else if (WanJiaHaoMa > ZhuangJiaHaoMa) {
        JieGuoTuPianName = @"ic_player";
    } else {
        JieGuoTuPianName = @"ic_tier";
    }
    [self.ShuiPingView TianJiaXiangMu:JieGuoTuPianName];
}

@end
