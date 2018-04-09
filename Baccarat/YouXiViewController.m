
#import "YouXiViewController.h"
#import "ColorUtil.h"
#import "UserDefaults.h"
#import "YinPinUtils.h"
#import "GuiZeAction.h"
#import "PuKeUtils.h"
#import "YongHuBean.h"
#import "JingGaoUtil.h"
#import "ShuiPingView.h"
#import "FenPinQi.h"
#import "PukeView.h"
#import "YunDanBean.h"
#import "SingleViewController.h"

#define YaZhu10Img       @"10"
#define YaZhu20Img       @"20"
#define YaZhu50Img       @"50"
#define YaZhu100Img      @"100"
#define YaZhu500Img      @"500"
#define YaZhu1000Img     @"1000"
#define YaZhu5000Img     @"5000"
#define YaZhu10000Img    @"100000"

#define MusicIconName        @"ic_sound"
#define MusicCloseIconName   @"ic_sound_c"

#define CardDuration    1.2

#define PlayerRatio  1.0
#define BankerRatio  0.95
#define TierRatio    8.0
#define PlayerPairRatio   0.88
#define BankerPairRatio   0.92

static CGFloat YaZhuWidth = 30;
static CGFloat GoleHeight = 30;

//static int YaZhuNumFirst = 10;
//static int YaZhuNumSecond = 20;
//static int YaZhuNumThird = 50;
//static int YaZhuNumFourth = 100;
//static int YaZhuNumFifth = 500;
//static int YaZhuNumSix = 1000;
//static int YaZhuNumSeven = 5000;
//static int YaZhuNumEight = 10000;

static float LeftTimes = 0.2;

typedef NS_ENUM(NSInteger, PageStatus) {
    PageStatusPrepare = 0,     //洗牌
    PageStatusStartBet = 1,    // 开始下注
    PageStatusStopBet = 2,     // 停止下注
    PageStatusOpenCard = 3,  // 开牌
    PageStatusShowResult = 4
};

@interface YouXiViewController () {
    float ratioW;
    float ratioH;
}

@property (weak, nonatomic) IBOutlet UIButton *YinYueAnNiu;
@property (weak, nonatomic) IBOutlet UIButton *ChongZhiAnNiu;

@property (strong, nonatomic) IBOutlet UIView *JieGuoShiTu;
@property (weak, nonatomic) IBOutlet UILabel *JieGuoPHaoMa;
@property (weak, nonatomic) IBOutlet UILabel *JieGuoBHaoMa;
@property (weak, nonatomic) IBOutlet UILabel *JieGuoPBiaoQian;
@property (weak, nonatomic) IBOutlet UILabel *JieGuoBBiaoXian;

@property (strong, nonatomic) UIView *balanceView;

@property (strong, nonatomic) IBOutlet UIView *KaPaiShiTu;
@property (weak, nonatomic) IBOutlet PukeView *ZuoKaPai2;
@property (weak, nonatomic) IBOutlet PukeView *ZuoKaPai3;
@property (weak, nonatomic) IBOutlet PukeView *YouKaPai2;
@property (weak, nonatomic) IBOutlet PukeView *YouKaPai3;
@property (strong, nonatomic) UIButton *WanJiaAnNiu;
@property (strong, nonatomic) UIButton *WanJiaYiDuiAnNiu;
@property (strong, nonatomic) UIButton *LingDaiAnNiu;
@property (strong, nonatomic) UIButton *ZhuanJiaYiDuiAnNiu;
@property (strong, nonatomic) UIButton *ZhuangJiaAnNiu;

@property (strong, nonatomic) UILabel *WanJiaBiaoQian;
@property (strong, nonatomic) UILabel *WanJiaYiDuiBiaoQian;
@property (strong, nonatomic) UILabel *LingDaiBiaoQian;
@property (strong, nonatomic) UILabel *ZhuangJiaBiaoQian;
@property (strong, nonatomic) UILabel *ZhuangJiaYiDuiBiaoQian;

@property (weak, nonatomic) IBOutlet UIButton *YaZhu10Kuai;
@property (weak, nonatomic) IBOutlet UIButton *YaZhu50Kuai;
@property (weak, nonatomic) IBOutlet UIButton *YaZhu100Kuai;
@property (weak, nonatomic) IBOutlet UIButton *YaZhu1000Kuai;
@property (weak, nonatomic) IBOutlet UIButton *YaZhu5000Kuai;
@property (weak, nonatomic) IBOutlet UIButton *YaZhu10000Kuai;

@property (strong, nonatomic) UILabel *QuanBuDeHaoMaBiaoQian;

@property (strong, nonatomic) UIButton *LinShiXuanZeYaZhuBtn;
@property (assign, nonatomic) RedChoosePuKe XuanZePorB;

@property (nonatomic) NSMutableArray *YaZhu10Arr;//!<10金币的数组
@property (nonatomic) NSMutableArray *YaZhu20Arr;//!<50金币的数组
@property (nonatomic) NSMutableArray *YaZhu50Arr;//!<100金币的数组
@property (nonatomic) NSMutableArray *YaZhu100Arr;//!<100金币的数组
@property (nonatomic) NSMutableArray *YaZhu500Arr;//!<100金币的数组
@property (nonatomic) NSMutableArray *YaZhu1000Arr;//!<100金币的数组
@property (nonatomic) NSMutableArray *YaZhu5000Arr;//!<100金币的数组
@property (nonatomic) NSMutableArray *YaZhu10000Arr;//!<100金币的数组

@property (nonatomic)NSDictionary *PuKesDic;
@property (strong, nonatomic) NSMutableDictionary *YongHu;
@property (strong, nonatomic) NSMutableDictionary *YongHuJiaoSeZiDian;
@property (strong, nonatomic) YongHuBean *XuanZeYongHu;

@property (strong, nonatomic) FenPinQi *FenPinQiView;
@property (weak, nonatomic) IBOutlet UIView *XiaZaiShiTu;

@property (strong, nonatomic) NSMutableArray *YaZhuBtns;
@property (assign, nonatomic) double WanJiaDeQain;

@property (assign, nonatomic) NSInteger KaPaiSuoYin;
@property (strong, nonatomic) UIView *TiXiShiTu;

@property (assign, nonatomic) int BiaoTiKaPaHaoMa;

@property (strong, nonatomic) IBOutlet UIView *GuanYuNiDeShiTu;
@property (weak, nonatomic) IBOutlet UITextView *WenBenShiTu;
@property (weak, nonatomic) IBOutlet UIImageView *GuanYuShiTuBgTuPian;

@property (strong, nonatomic) SingleViewController *SingleVC;

@end

@implementation YouXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpMembers];
    [self setUpWidgets];
}

- (void)setUpMembers
{
    self.KaPaiSuoYin = 0;
    self.BiaoTiKaPaHaoMa = 52 * 8;
    
    self.YaZhu10Arr = [NSMutableArray array];
    self.YaZhu20Arr = [NSMutableArray array];
    self.YaZhu50Arr = [NSMutableArray array];
    self.YaZhu100Arr = [NSMutableArray array];
    self.YaZhu500Arr = [NSMutableArray array];
    self.YaZhu1000Arr = [NSMutableArray array];
    self.YaZhu5000Arr = [NSMutableArray array];
    self.YaZhu10000Arr = [NSMutableArray array];
    
    self.PuKesDic = [PuKeUtils DeDaoPuKeZiDian];
    self.YongHu = [NSMutableDictionary dictionary];
    YongHuBean *bean = [[YongHuBean alloc] initWithYongHuID:@"left" YongHuXingMing:@"哈哈"];
    bean.totalMoney = 5000.00;
    [self.YongHu setObject:bean forKey:bean.YongHuID];
    self.XuanZeYongHu = bean;
    self.YongHuJiaoSeZiDian = [NSMutableDictionary dictionary];
    
    self.QuanBuDeHaoMaBiaoQian.text = [self formatMoney:bean.totalMoney];
    
   RuoYinYongZiJi
    [[RuleAction ShengChengAnNiu] SheZhiWanChengBlock:^(int playerNum, int bankerNum, NSArray *winners) {
        [weakSelf handlePlayerNum:playerNum bankerNum:bankerNum winners:winners];
    }];
    
    self.YaZhuBtns = [NSMutableArray array];
    [self.YaZhuBtns addObject:self.YaZhu10Kuai];
    [self.YaZhuBtns addObject:self.YaZhu50Kuai];
    [self.YaZhuBtns addObject:self.YaZhu100Kuai];
    [self.YaZhuBtns addObject:self.YaZhu1000Kuai];
    [self.YaZhuBtns addObject:self.YaZhu5000Kuai];
    [self.YaZhuBtns addObject:self.YaZhu10000Kuai];
    
    self.WanJiaDeQain = 0.0;
}

- (void)setUpWidgets
{
    if ([YinPinUtils YunXuYingXiangWan]) {
        [self.YinYueAnNiu setImage:[UIImage imageNamed:MusicIconName] forState:UIControlStateNormal];
    } else {
        [self.YinYueAnNiu setImage:[UIImage imageNamed:MusicCloseIconName] forState:UIControlStateNormal];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [YinPinUtils play:@"welcome"];
    float orightW = 667;
    float orightH = 375;
    ratioW = ScreenWidth / orightW;
    ratioH = ScreenHeight / orightH;

    [self createBalanceView];
    [self createBtns];
    [self resetCardView];
    [self resetResultView];
    [self createFenPinQi];
    [self createSingle];
    [self startYouXi];
}

- (void)createBtns
{
    self.WanJiaAnNiu = [[UIButton alloc] initWithFrame:CGRectMake(35 * ratioW, 177 * ratioH, 56 * ratioW, 50 * ratioH)];
//    self.playerBtn.backgroundColor = [UIColor yellowColor];
    [self.WanJiaAnNiu addTarget:self action:@selector(playerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.WanJiaAnNiu];
    
    self.LingDaiAnNiu = [[UIButton alloc] initWithFrame:CGRectMake(295 * ratioW, 238 * ratioH, 74 * ratioW, 54 * ratioH)];
//    self.tieBtn.backgroundColor = [UIColor yellowColor];
    [self.LingDaiAnNiu addTarget:self action:@selector(tieBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.LingDaiAnNiu];

    self.ZhuangJiaAnNiu = [[UIButton alloc] initWithFrame:CGRectMake(570 * ratioW, 184 * ratioH, 50 * ratioW, 49 * ratioH)];
//    self.bankerBtn.backgroundColor = [UIColor yellowColor];
    [self.ZhuangJiaAnNiu addTarget:self action:@selector(bankerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ZhuangJiaAnNiu];

    self.WanJiaYiDuiAnNiu = [[UIButton alloc] initWithFrame:CGRectMake(154 * ratioW, 224 * ratioH, 74 * ratioW, 54 * ratioH)];
//    self.playerPairBtn.backgroundColor = [UIColor yellowColor];
    [self.WanJiaYiDuiAnNiu addTarget:self action:@selector(playerPairBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.WanJiaYiDuiAnNiu];
    
    self.ZhuanJiaYiDuiAnNiu = [[UIButton alloc] initWithFrame:CGRectMake(444 * ratioW, 224 * ratioH, 67 * ratioW, 49 * ratioH)];
//    self.bankerPairBtn.backgroundColor = [UIColor yellowColor];
    [self.ZhuanJiaYiDuiAnNiu addTarget:self action:@selector(bankerPairBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ZhuanJiaYiDuiAnNiu];
}

- (void)resetCardView
{
    self.KaPaiShiTu.frame = CGRectMake(0, 142 * ratioH, ScreenWidth, 76);
    self.KaPaiShiTu.hidden = YES;
    [self.view addSubview:self.KaPaiShiTu];
}

- (void)resetResultView
{
    self.JieGuoShiTu.frame = CGRectMake(0, 66 * ratioH, ScreenWidth, 40);
    self.JieGuoShiTu.hidden = YES;
    [self.view addSubview:self.JieGuoShiTu];
    
    self.JieGuoBBiaoXian.layer.cornerRadius = 8.0;
    self.JieGuoBBiaoXian.layer.masksToBounds = YES;
    self.JieGuoBHaoMa.layer.cornerRadius = 20.0;
    self.JieGuoBHaoMa.layer.masksToBounds = YES;
    self.JieGuoBHaoMa.layer.borderColor = [ColorUtil ShiLiuJinZhiZiFuChuanYanSe:@""].CGColor;
    self.JieGuoBHaoMa.layer.borderWidth = 0.5;
    
    self.JieGuoPBiaoQian.layer.cornerRadius = 8.0;
    self.JieGuoPBiaoQian.layer.masksToBounds = YES;
    self.JieGuoPHaoMa.layer.cornerRadius = 20.0;
    self.JieGuoPHaoMa.layer.masksToBounds = YES;
    self.JieGuoPHaoMa.layer.borderWidth = 0.5;
    self.JieGuoPHaoMa.layer.borderColor = [ColorUtil ShiLiuJinZhiZiFuChuanYanSe:@""].CGColor;
}

- (void)createBalanceView
{
    self.balanceView = [[UIView alloc] initWithFrame:CGRectMake(0, 70 * ratioH, 150, 80)];
    self.balanceView.backgroundColor = [UIColor clearColor];
//    self.balanceView.center = CGPointMake(self.view.center.x, (35 * ratioH + 75));
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    bg.image = [UIImage imageNamed:@"ic_YaZhu_bag"];
    bg.contentMode = UIViewContentModeScaleAspectFit;
    [self.balanceView addSubview:bg];
    
    self.QuanBuDeHaoMaBiaoQian = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 93, 80)];
    self.QuanBuDeHaoMaBiaoQian.textColor = [UIColor whiteColor];
    self.QuanBuDeHaoMaBiaoQian.textAlignment = NSTextAlignmentLeft;
    self.QuanBuDeHaoMaBiaoQian.font = [UIFont systemFontOfSize:20.0];
    self.QuanBuDeHaoMaBiaoQian.text = [self formatMoney:5000];
    [self.balanceView addSubview:self.QuanBuDeHaoMaBiaoQian];
    
    [self.view addSubview:self.balanceView];
}

- (void)createFenPinQi
{
    self.FenPinQiView = [[FenPinQi alloc] initWithFrame:self.XiaZaiShiTu.bounds];
    self.FenPinQiView.FenPinQiTime = 16;
    RuoYinYongZiJi
    [self.FenPinQiView setKaiShiBlock:^{
//        weakSelf.clockView.hidden = NO;
        [YinPinUtils play:@"startYouXi"];
        [weakSelf showTip:@"请下注"];
        [weakSelf canBet:YES];
    }];
    [self.FenPinQiView setTingZhiBlock:^{
        [YinPinUtils play:@"stopbet"];
        [weakSelf showTip:@"停止下注"];
        [weakSelf canBet:NO];
//        weakSelf.clockView.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [YinPinUtils play:@"startCard"];
            [weakSelf showTip:@"开始发牌"];
            [weakSelf playBtnClick:nil];
        });
    }];
    [self.XiaZaiShiTu addSubview:self.FenPinQiView];
}

- (void)createSingle
{
    if (!self.SingleVC) {
        SingleViewController *SingleVC = [[SingleViewController alloc] init];
        SingleVC.view.frame = CGRectMake((ScreenWidth - 342 * ratioW) * 0.5, (ScreenHeight - 367 * ratioH ) * 0.5, 342 * ratioW, 367 * ratioH);
        SingleVC.view.hidden = YES;
        [self.view addSubview:SingleVC.view];
        [self addChildViewController:SingleVC];
        self.SingleVC = SingleVC;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)canBet:(BOOL)can
{
    self.WanJiaAnNiu.enabled = can;
    self.ZhuangJiaAnNiu.enabled = can;
    self.WanJiaYiDuiAnNiu.enabled = can;
    self.ZhuanJiaYiDuiAnNiu.enabled = can;
    self.LingDaiAnNiu.enabled = can;
}

- (void)showTip:(NSString *)tip
{
    UILabel *label;
    if (!self.TiXiShiTu) {
        self.TiXiShiTu = [[UIView alloc] initWithFrame:CGRectMake(20, (ScreenHeight - 60) * 0.5, ScreenWidth - 40, 60)];
        [self.TiXiShiTu.layer addSublayer:[ColorUtil operationGradientLayer:CGSizeMake(ScreenWidth - 40, 60)]];
        
        label = [[UILabel alloc] initWithFrame:self.TiXiShiTu.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.tag = 2000;
        label.textAlignment = NSTextAlignmentCenter;
        
        [self.TiXiShiTu addSubview:label];
        [self.view addSubview:self.TiXiShiTu];
    } else {
        label = [self.TiXiShiTu viewWithTag:2000];
    }
    
    label.text = tip;
    self.TiXiShiTu.hidden = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.TiXiShiTu.hidden = NO;
    }];
    
    RuoYinYongZiJi
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf hideTipView];
    });
}

- (void)hideTipView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.TiXiShiTu.hidden = YES;
    }];
}

- (void)startYouXi
{
    [self canBet:NO];
    
   RuoYinYongZiJi
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.FenPinQiView KaiShiDingShiQi];
    });
}

#pragma mark - buttons click events

- (void)hightlightBtn:(UIButton *)btn
{
//    NSString *hightlightName = [NSString stringWithFormat:@"%ld_sel", btn.tag];
//    [btn setImage:[UIImage imageNamed:hightlightName] forState:UIControlStateNormal];
    
    NSString *hightlightTag = [NSString stringWithFormat:@"1%ld", btn.tag];
    UIImageView *hlImageView = [self.view viewWithTag:[hightlightTag integerValue]];
    hlImageView.hidden = NO;
    
    UIImageView *hideHgImageView;
    for (UIButton *b in self.YaZhuBtns) {
        if (b.tag != btn.tag) {
            NSString *normalName = [NSString stringWithFormat:@"1%ld", b.tag];
            hideHgImageView = [self.view viewWithTag:[normalName integerValue]];
            hideHgImageView.hidden = YES;
        }
    }
}

- (void)whichYaZhuClick
{
    if (self.LinShiXuanZeYaZhuBtn) {
        [self YaZhuClick:self.LinShiXuanZeYaZhuBtn];
    }
}

- (void)playerBtnClick:(UIButton *)sender
{
    self.XuanZePorB = RedChoosePuKePlayer;
    [self whichYaZhuClick];
}

- (void)playerPairBtnClick:(UIButton *)sender
{
    self.XuanZePorB = RedChoosePuKePlayerPair;
    [self whichYaZhuClick];
}

- (void)tieBtnClick:(UIButton *)sender
{
    self.XuanZePorB = RedChoosePuKeTier;
    [self whichYaZhuClick];
}

- (void)bankerBtnClick:(UIButton *)sender
{
    self.XuanZePorB = RedChoosePuKeBanker;
    [self whichYaZhuClick];
}

- (void)bankerPairBtnClick:(UIButton *)sender
{
    self.XuanZePorB = RedChoosePuKeBankerPair;
    [self whichYaZhuClick];
}

#pragma mark - YaZhu click events

- (IBAction)YaZhuClick:(UIButton *)sender {
    NSLog(@"click 100 YaZhu");
    
    NSInteger tag = sender.tag;
    
    self.LinShiXuanZeYaZhuBtn = sender;
    [self hightlightBtn:sender];
    
    if (self.XuanZeYongHu.totalMoney - tag < 0) {
        //        self.playNumLab.text = @"您的余额不足";
    }else{
        CGRect frame = [sender.superview convertRect:sender.frame toView:self.view];
        UIImageView *NewYaZhuImg = [[UIImageView alloc] initWithFrame:frame];
        NewYaZhuImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", sender.tag]];
        NewYaZhuImg.tag = sender.tag;
        [self.view addSubview:NewYaZhuImg];
        
        [self addYaZhuToArray:NewYaZhuImg];

        [self setPlaceOfYaZhu:NewYaZhuImg];
    }
}

- (void)addYaZhuToArray:(UIImageView *)sender
{
    NSInteger tag = sender.tag;
    switch (tag) {
        case 10:
            [self.YaZhu10Arr addObject:sender];
            break;
        case 20:
            [self.YaZhu20Arr addObject:sender];
            break;
        case 50:
            [self.YaZhu50Arr addObject:sender];
            break;
        case 100:
            [self.YaZhu100Arr addObject:sender];
            break;
        case 500:
            [self.YaZhu500Arr addObject:sender];
            break;
        case 1000:
            [self.YaZhu1000Arr addObject:sender];
            break;
        case 5000:
            [self.YaZhu5000Arr addObject:sender];
            break;
        case 10000:
            [self.YaZhu10000Arr addObject:sender];
            break;
    }
}

- (void)setPlaceOfYaZhu:(UIImageView *)NewYaZhuImg
{
    if (!NewYaZhuImg) {
        return;
    }
    

    if (self.XuanZePorB == RedChoosePuKePlayer) {
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.WanJiaAnNiu.frame;
//            frame.size.height -= CGRectGetHeight(self.playerLabel.frame);
            NewYaZhuImg.frame = [self getRectOfYaZhu:frame];
        }];
        float oldMoney = [self.WanJiaBiaoQian.text floatValue];
        float totalMoney = oldMoney + NewYaZhuImg.tag;
        self.WanJiaBiaoQian.text = [NSString stringWithFormat:@"%0.2f", totalMoney];
        
        [self resetUserRoleDicWithMoney:NewYaZhuImg.tag ratio:PlayerRatio role:RedChoosePuKePlayer];
    }else if(self.XuanZePorB == RedChoosePuKeBanker){
        
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.ZhuangJiaAnNiu.frame;
//            frame.size.height -= CGRectGetHeight(self.bankerLabel.frame);
            NewYaZhuImg.frame = [self getRectOfYaZhu:frame];
        }];
        float oldMoney = [self.ZhuangJiaBiaoQian.text floatValue];
        float totalMoney = oldMoney + NewYaZhuImg.tag;
        self.ZhuangJiaBiaoQian.text = [NSString stringWithFormat:@"%0.2f", totalMoney];
        
        [self resetUserRoleDicWithMoney:NewYaZhuImg.tag ratio:BankerRatio role:RedChoosePuKeBanker];
    } else if (self.XuanZePorB == RedChoosePuKeTier) {
        
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.LingDaiAnNiu.frame;
//            frame.size.height -= CGRectGetHeight(self.tieLabel.frame);
            NewYaZhuImg.frame = [self getRectOfYaZhu:frame];
        }];
        float oldMoney = [self.LingDaiBiaoQian.text floatValue];
        float totalMoney = oldMoney + NewYaZhuImg.tag;
        self.LingDaiBiaoQian.text = [NSString stringWithFormat:@"%0.2f", totalMoney];

        [self resetUserRoleDicWithMoney:NewYaZhuImg.tag ratio:TierRatio role:RedChoosePuKeTier];
    } else if (self.XuanZePorB == RedChoosePuKePlayerPair) {
        
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.WanJiaYiDuiAnNiu.frame;
//            frame.size.height -= CGRectGetHeight(self.playerPairLabel.frame);
            NewYaZhuImg.frame = [self getRectOfYaZhu:frame];
        }];
        float oldMoney = [self.WanJiaYiDuiBiaoQian.text floatValue];
        float totalMoney = oldMoney + NewYaZhuImg.tag;
        self.WanJiaYiDuiBiaoQian.text = [NSString stringWithFormat:@"%0.2f", totalMoney];

        [self resetUserRoleDicWithMoney:NewYaZhuImg.tag ratio:PlayerPairRatio role:RedChoosePuKePlayerPair];
    } else if (self.XuanZePorB == RedChoosePuKeBankerPair) {
        
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.ZhuanJiaYiDuiAnNiu.frame;
//            frame.size.height -= CGRectGetHeight(self.bankerPairLabel.frame);
            NewYaZhuImg.frame = [self getRectOfYaZhu:frame];
        }];
        float oldMoney = [self.ZhuangJiaYiDuiBiaoQian.text floatValue];
        float totalMoney = oldMoney + NewYaZhuImg.tag;
        self.ZhuangJiaYiDuiBiaoQian.text = [NSString stringWithFormat:@"%0.2f", totalMoney];

        [self resetUserRoleDicWithMoney:NewYaZhuImg.tag ratio:BankerPairRatio role:RedChoosePuKeBankerPair];
    } else {
        return;
    }
    
    self.WanJiaDeQain += NewYaZhuImg.tag;
    double money = self.XuanZeYongHu.totalMoney;
    money -= NewYaZhuImg.tag;
    self.XuanZeYongHu.totalMoney = money;
    self.QuanBuDeHaoMaBiaoQian.text = [self formatMoney:self.XuanZeYongHu.totalMoney];
}

//关闭音效
- (IBAction)closeEffect:(id)sender {
    RuoYinYongZiJi
    [YinPinUtils GuanBiYingXiangJuYouWanChengBlock:^(BOOL isAllow) {
        if (isAllow) {
            [weakSelf.YinYueAnNiu setImage:[UIImage imageNamed:MusicIconName] forState:UIControlStateNormal];
        } else {
            [weakSelf.YinYueAnNiu setImage:[UIImage imageNamed:MusicCloseIconName] forState:UIControlStateNormal];
        }
    }];
}

#pragma mark - play YouXi

- (void)resetUserRoleDicWithMoney:(double)money ratio:(double)ratio role:(RedChoosePuKe)role
{
    NSMutableDictionary *mutableDic = [self.YongHuJiaoSeZiDian objectForKey:self.XuanZeYongHu.YongHuID];
    if (!mutableDic) {
        mutableDic = [NSMutableDictionary dictionary];
        [self.YongHuJiaoSeZiDian setObject:mutableDic forKey:self.XuanZeYongHu.YongHuID];
    }
    
     RoleMoney *roleMoney = [mutableDic objectForKey:@(role)];
    if (!roleMoney) {
         roleMoney = [[ RoleMoney alloc] initWithBi:ratio money:money JiaoSe:role];
        [mutableDic setObject:roleMoney forKey:@(role)];
    } else {
        roleMoney.JinQian += money;
    }
}

- (IBAction)resetBtnClick:(id)sender {
    [self resetWigets];
    self.BiaoTiKaPaHaoMa = 52 * 8;
    
    for (YongHuBean *user in [self.YongHu allValues]) {
        user.totalMoney = 5000;
        self.QuanBuDeHaoMaBiaoQian.text = [self formatMoney:user.totalMoney];
    }
    
    for (UIImageView *img in _YaZhu10Arr) {
        [img removeFromSuperview];
    }
    [_YaZhu10Arr removeAllObjects];

    for (UIImageView *img in _YaZhu20Arr) {
        [img removeFromSuperview];
    }
    [_YaZhu20Arr removeAllObjects];
    
    for (UIImageView *img in _YaZhu50Arr) {
        [img removeFromSuperview];
    }
    [_YaZhu50Arr removeAllObjects];
    
    for (UIImageView *img in _YaZhu100Arr) {
        [img removeFromSuperview];
    }
    [_YaZhu100Arr removeAllObjects];

    for (UIImageView *img in _YaZhu500Arr) {
        [img removeFromSuperview];
    }
    [_YaZhu500Arr removeAllObjects];

    for (UIImageView *img in _YaZhu1000Arr) {
        [img removeFromSuperview];
    }
    [_YaZhu1000Arr removeAllObjects];

    for (UIImageView *img in _YaZhu5000Arr) {
        [img removeFromSuperview];
    }
    [_YaZhu5000Arr removeAllObjects];

    for (UIImageView *img in _YaZhu10000Arr) {
        [img removeFromSuperview];
    }
    [_YaZhu10000Arr removeAllObjects];
}

- (void)resetWigets
{
    self.XuanZePorB = RedChoosePuKeNone;
    
//    [self cardsRemoveFromSuperView];
    [self.ZuoKaPai2 ShanChuKaPai];
    [self.ZuoKaPai3 ShanChuKaPai];
    [self.YouKaPai2 ShanChuKaPai];
    [self.YouKaPai3 ShanChuKaPai];
    self.KaPaiSuoYin = 0;
    
    [self.YongHuJiaoSeZiDian removeAllObjects];
    
    for (YongHuBean *user in [self.YongHu allValues]) {
        user.JiaoSeJinQian = nil;
    }
    self.WanJiaDeQain = 0.0;
    
    self.WanJiaYiDuiBiaoQian.text = @"";
    self.ZhuangJiaYiDuiBiaoQian.text = @"";
    self.WanJiaBiaoQian.text = @"";
    self.ZhuangJiaBiaoQian.text = @"";
    self.LingDaiBiaoQian.text = @"";
    [self.FenPinQiView TingZhiDingShiQi];
   RuoYinYongZiJi
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf startYouXi];
    });
    
    self.ChongZhiAnNiu.enabled = YES;
}

- (void)playBtnClick:(UIButton *)sender
{
    RuoYinYongZiJi
    NSArray *arr = [PuKeUtils DeDaoSuiJiPuKeShuZuDeShuLiang:4];
    
    self.KaPaiShiTu.frame = CGRectMake(594, -20, 0, 0);
    [UIView animateWithDuration:1 animations:^{
        self.KaPaiShiTu.frame = CGRectMake(0, 142 * ratioH, ScreenWidth, 76);
        self.KaPaiShiTu.hidden = NO;
    }];
    
    self.ChongZhiAnNiu.enabled = NO;
    self.BiaoTiKaPaHaoMa = self.BiaoTiKaPaHaoMa - 4;
    [self.view bringSubviewToFront:self.KaPaiShiTu];
    
    [YinPinUtils play:@"card"];
    
    [self.ZuoKaPai2 TianJiaKaPai:arr[0]];
    [self.ZuoKaPai3 TianJiaKaPai:arr[1]];
    [self.YouKaPai2 TianJiaKaPai:arr[2]];
    [self.YouKaPai3 TianJiaKaPai:arr[3]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self flipCards];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger playerTotalNum = [_PuKesDic[arr[0]] integerValue] + [_PuKesDic[arr[1]] integerValue];
        NSInteger bankerTotalNum = [_PuKesDic[arr[2]] integerValue] + [_PuKesDic[arr[3]] integerValue];
        NSLog(@"totalNum, player: %ld --- banker: %ld", (long)playerTotalNum, (long)bankerTotalNum);
        
        NSArray *bankerArray = @[_PuKesDic[arr[2]], _PuKesDic[arr[3]]];
        NSArray *playerArray = @[_PuKesDic[arr[0]], _PuKesDic[arr[1]]];
        
        [weakSelf calcurateBetYaZhu];
        [[RuleAction ShengChengAnNiu] XianShiKaPaiYingJiaJieGuo:bankerArray playerCards:playerArray users:[weakSelf.YongHu allValues] isNeedPair:YES];
    });
}

- (void)flipCards
{
    RuoYinYongZiJi
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger index = 2000 + weakSelf.KaPaiSuoYin;
        PukeView *PukeView = [weakSelf.KaPaiShiTu viewWithTag:index];
        
        [UIView transitionWithView:PukeView duration:CardDuration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [PukeView ShanChuBgPuKe];
        } completion:^(BOOL finish){
            self.KaPaiSuoYin++;
            if (self.KaPaiSuoYin < 4) {
                [self flipCards];
            }
        }];
    });
}

- (void)delayCardFlip
{
    self.KaPaiSuoYin++;
    if (self.KaPaiSuoYin < 4) {
        [self flipCards];
    }
}

- (void)calcurateBetYaZhu
{
    RuoYinYongZiJi
    [self.YongHuJiaoSeZiDian enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = (NSMutableDictionary *)obj;
        YongHuBean *user = weakSelf.YongHu[key];
        user.JiaoSeJinQian = [dic allValues];
    }];
}

- (void)handlePlayerNum:(int)playerNum bankerNum:(int)bankerNum winners:(NSArray *)winners
{
    if (self.ChongZhiAnNiu.enabled) {
        return;
    }
    RuoYinYongZiJi
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 页面显示庄、闲点数
        weakSelf.JieGuoShiTu.hidden = NO;
        weakSelf.JieGuoPHaoMa.text = [NSString stringWithFormat:@"%d", playerNum];
        weakSelf.JieGuoBHaoMa.text = [NSString stringWithFormat:@"%d", bankerNum];
        
        [weakSelf soundOfWinner:winners];
        [weakSelf toastOfWinner:winners];
        
        [self.SingleVC addSingleItem:playerNum bankerNum:bankerNum];
        
        // 设置余额
        [weakSelf.YongHu enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            YongHuBean *user = (YongHuBean *)obj;
            if ([key isEqualToString:@"left"]) {
                weakSelf.QuanBuDeHaoMaBiaoQian.text = [weakSelf formatMoney:user.totalMoney];
            }
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.KaPaiShiTu.hidden = YES;
            weakSelf.JieGuoShiTu.hidden = YES;
            [weakSelf recycleCoin];
        });
    });
}

- (NSString *)formatMoney:(double)money
{
    NSString *string = nil;
    if (money >= 100000) {
        string = [NSString stringWithFormat:@"%.2fk", money/10000];
    } else {
        string = [NSString stringWithFormat:@"%.2f", money];
    }
    return string;
}

- (void)recycleCoin{
    
    [self resetWigets];
    
    [self removeYaZhuFromArray:self.YaZhu10Arr];
    [self removeYaZhuFromArray:self.YaZhu20Arr];
    [self removeYaZhuFromArray:self.YaZhu50Arr];
    [self removeYaZhuFromArray:self.YaZhu100Arr];
    [self removeYaZhuFromArray:self.YaZhu500Arr];
    [self removeYaZhuFromArray:self.YaZhu1000Arr];
    [self removeYaZhuFromArray:self.YaZhu5000Arr];
    [self removeYaZhuFromArray:self.YaZhu10000Arr];
}

- (void)removeYaZhuFromArray:(NSMutableArray *)array
{
    if (!array) {
        return;
    }
    for (UIImageView *img in array) {
        [UIView animateWithDuration:LeftTimes*2 animations:^{
            img.frame = [self getReCycleFrame:img];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [img removeFromSuperview];
        });
    }
    [array removeAllObjects];
}

- (CGRect)getReCycleFrame:(UIImageView *)img
{
    NSInteger tag = img.tag;
    CGRect frame = CGRectZero;
    switch (tag) {
        case 10:
            frame = self.YaZhu10Kuai.frame;
            break;
        case 50:
            frame = self.YaZhu50Kuai.frame;
            break;
        case 100:
            frame = self.YaZhu100Kuai.frame;
            break;
        case 1000:
            frame = self.YaZhu1000Kuai.frame;
            break;
        case 5000:
            frame = self.YaZhu5000Kuai.frame;
            break;
        case 10000:
            frame = self.YaZhu10000Kuai.frame;
            break;
    }
    return frame;
}

//- (NSString *)getWinnerImageName:(NSArray *)winners
//{
//    NSString *win = @"";
//    for (int i=0; i<winners.count; i++) {
//        NSInteger winner = [winners[i] integerValue];
//        if (winner == RedChoosePuKeBanker) {
//            win = @"banker_win";
//            self.bankerWinLabel.text = [NSString stringWithFormat:@"%d", [self.bankerWinLabel.text intValue] + 1];
//            break;
//        } else if (winner == RedChoosePuKePlayer) {
//            win = @"player_win";
//            self.playerWinLabel.text = [NSString stringWithFormat:@"%d", [self.playerWinLabel.text intValue] + 1];
//            break;
//        } else if (winner == RedChoosePuKeTier) {
//            win = @"tie_win";
//            self.tierWinLabel.text = [NSString stringWithFormat:@"%d", [self.tierWinLabel.text intValue] + 1];
//            break;
//        }
//    }
//    
//    return win;
//}

- (void)soundOfWinner:(NSArray *)winners
{
    for (NSNumber *winnerNum in winners) {
        NSInteger winner = [winnerNum integerValue];
        switch (winner) {
            case RedChoosePuKeBanker:{
                [YinPinUtils play:@"banker_win"];
                break;
            }
            case RedChoosePuKePlayer:{
                [YinPinUtils play:@"player_win"];
                break;
            }
            case RedChoosePuKeTier: {
                [YinPinUtils play:@"tie_win"];
                break;
            }
            case RedChoosePuKePlayerPair: {
                [YinPinUtils play:@"player_pair_win"];
                break;
            }
            case RedChoosePuKeBankerPair:
                [YinPinUtils play:@"banker_pair_win"];
                break;
            default:
                break;
        }

    }
}

- (void)toastOfWinner:(NSArray *)winners
{
    NSString *win = @"";
    for (int i=0; i<winners.count; i++) {
        NSInteger winner = [winners[i] integerValue];
        if (winner == RedChoosePuKeBanker) {
            win = @"庄赢";
            break;
        } else if (winner == RedChoosePuKePlayer) {
            win = @"闲赢";
            break;
        } else if (winner == RedChoosePuKeTier) {
            win = @"和局";
            break;
        }
    }
    
    NSString *winMoney = @"";
    if (self.XuanZePorB != RedChoosePuKeNone) {
        double winDouble = [self.YongHu[@"left"] winMoney];
        double actualMoney = winDouble - self.WanJiaDeQain;
        if (actualMoney < 0.0) {
            winMoney = [NSString stringWithFormat:@"-%0.2f", fabs(actualMoney)];
        } else {
            winMoney = [NSString stringWithFormat:@"+%0.2f", fabs(actualMoney)];
        }
    } else {
        winMoney = @"本局未下注";
    }
    [JingGaoUtil XianShiYongHuJieMian:win HaoMa:winMoney];
}

- (CGRect)getRectOfYaZhu:(CGRect)maxFrame
{
    float minX = CGRectGetMinX(maxFrame);
    float maxX = CGRectGetMaxX(maxFrame);
    float minY = CGRectGetMinY(maxFrame);
    float maxY = CGRectGetMaxY(maxFrame);
    
    float randomX = [self getRandomNumber:floorf(minX - YaZhuWidth * 0.5) to:floorf(maxX - YaZhuWidth * 0.5)];
    float randowY = [self getRandomNumber:floorf(minY - GoleHeight * 0.5) to:floorf(maxY - GoleHeight * 0.5)];
    return CGRectMake(randomX, randowY, YaZhuWidth, GoleHeight);
}

- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}

- (IBAction)backBtnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)checkBtnClick:(id)sender
{
    float width = 458;
    float height= 324;
    
    [self.view addSubview:self.GuanYuNiDeShiTu];
    [UIView animateWithDuration:0.3 animations:^{
        self.GuanYuNiDeShiTu.frame = CGRectMake((CGRectGetWidth(self.view.bounds) - width)/2.0, (CGRectGetHeight(self.view.bounds) - height)/2.0, width, height);
    } completion:^(BOOL finished) {
        self.GuanYuNiDeShiTu.hidden = NO;
    }];
}

- (IBAction)closeAboutBtnClick:(id)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.GuanYuNiDeShiTu.hidden = YES;
    } completion:^(BOOL finished) {
        [self.GuanYuNiDeShiTu removeFromSuperview];
    }];
}


- (NSString *)getProfileText
{
    NSString *text = @"在百家乐中，Ace的扑克牌被算作1点；从2到9的扑克牌依点数不变，均依照其显示的点数计算；10、J、Q及K的扑克牌则被算作零点（有些赌场以10点计）。当所有牌的点数总和超过9时，则只算总数中的个位。因此，一个8和一个9的牌点大小为：7点（8 + 9 = 17）。因百家乐中只计算扑克牌的个位数值，因此可能的最大点数为9点（如一个4 和一个 5：4 + 5 = 9），最少则为0点，又称baccarat（如一个10 和一个 Q：10 + 10 = 20，只算个位是0。";
    return text;
}

- (IBAction)SingleClick:(id)sender {
    if (self.SingleVC.view.hidden) {
        [UIView animateWithDuration:1.0 animations:^{
            self.SingleVC.view.hidden = NO;
            [self.view bringSubviewToFront:self.SingleVC.view];
        }];
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            self.SingleVC.view.hidden = YES;
            [self.view sendSubviewToBack:self.SingleVC.view];
        }];
    }
}

@end
