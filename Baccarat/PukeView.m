
#import "PukeView.h"

@interface PukeView()

//@property (nonatomic, copy) NSString *faceImageName;

#pragma mark - method 1 vars

@property (nonatomic, strong) UIImageView *bgTuPianShiTu;

@property (nonatomic, strong) UIImageView *MianDuiTuPianShiTu;

@end

@implementation PukeView

- (instancetype)initWithFrame:(CGRect)frame TuPianMing:(NSString *)TuPianMing
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SheZhiChuangKoXiaoBuJian:TuPianMing];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self SheZhiChuangKoXiaoBuJian:@""];
}

- (void)dealloc
{
    NSLog(@"PukeView dealloc");
    _bgTuPianShiTu = nil;
}

- (void)ShanChuKaPai
{
//    [self.faceImageView.layer removeAllAnimations];
//    [self.bgImageView.layer removeAllAnimations];

    self.MianDuiTuPianShiTu.image = nil;
    self.MianDuiTuPianShiTu.hidden = YES;
    self.bgTuPianShiTu.hidden = NO;
}

- (void)TianJiaKaPai:(NSString *)KaPaiMing;
{
    self.MianDuiTuPianShiTu.image = [UIImage imageNamed:KaPaiMing];
    [self setNeedsDisplay];
}

#pragma mark - method 1 begin

- (void)SheZhiChuangKoXiaoBuJian:(NSString *)faceImageName
{
    self.MianDuiTuPianShiTu = [[UIImageView alloc] initWithFrame:self.bounds];
    self.MianDuiTuPianShiTu.image = [UIImage imageNamed:faceImageName];
    self.MianDuiTuPianShiTu.hidden = YES;
    [self addSubview:self.MianDuiTuPianShiTu];
    
    self.bgTuPianShiTu = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bgTuPianShiTu.image = [UIImage imageNamed:@"bg"];
    self.bgTuPianShiTu.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self addSubview:self.bgTuPianShiTu];
}

- (void)ShanChuBgPuKe;
{
    self.bgTuPianShiTu.hidden = YES;
    self.MianDuiTuPianShiTu.hidden = NO;
}

#pragma mark - method 2 begin

//- (void)setUpWidgets:(NSString *)faceImageName
//{
//    self.faceImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    self.faceImageView.image = [UIImage imageNamed:faceImageName];
//    CATransform3D transform = CATransform3DIdentity;
//    CATransform3DRotate(transform, M_PI, 1, 0, 0);
//    self.faceImageView.layer.transform = transform;
//    self.faceImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    self.faceImageView.hidden = YES;
//    [self addSubview:self.faceImageView];
//    
//    self.bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    self.bgImageView.image = [UIImage imageNamed:@"bg"];
//    self.bgImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    [self addSubview:self.bgImageView];
//}
//
//- (void)flipPukeViewDuration:(NSTimeInterval)duration
//{
//    [self performSelector:@selector(changeStatus) withObject:nil afterDelay:duration/2];
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    animation.toValue = [NSNumber numberWithFloat:M_PI];
//    animation.duration = duration;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = YES;
//    animation.repeatCount = 0;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    
//    [self.bgImageView.layer addAnimation:animation forKey:@"animation1"];
//    [self.faceImageView.layer addAnimation:animation forKey:@"animation1"];
//}
//
//- (void)changeStatus
//{
//    self.bgImageView.hidden = YES;
//    self.faceImageView.hidden = NO;
//}





@end
