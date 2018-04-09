
#import "ShuiPingCell.h"
#import "ColorUtil.h"

@implementation ShuiPingCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ShuiPingCell" owner:self options:nil].lastObject;
        [self SheZhiWigets];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self SheZhiWigets];
}

- (void)SheZhiWigets
{
//    self.layer.borderWidth = 0.5;
//    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.backgroundColor = [UIColor clearColor];
    self.JieGuoTuPian.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)SheZhiTuPianShiTu:(NSString *)TuPianMing
{
//    if ([imageName isEqualToString:@""]) {
//        self.JieGuoTuPian.image = [ColorUtil ChuangJianShiTuJuYouYanSe:[ColorUtil ShiLiuJinZhiZiFuChuanYanSe:@"#B7B7B7"]];
//    } else {
        self.JieGuoTuPian.image = [UIImage imageNamed:TuPianMing];
//    }
}

- (void)prepareForReuse
{
    self.JieGuoTuPian.image = nil;
}

@end
