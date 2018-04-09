
#import "ZhiNanViewController.h"
#import "YouXiViewController.h"
#import "UserDefaults.h"

@interface ZhiNanViewController ()

@end

@implementation ZhiNanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBtns];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpBtns
{
    float orightW = 667;
    float orightH = 375;
    float ratioW = ScreenWidth / orightW;
    float ratioH = ScreenHeight / orightH;
    UIButton *AnNiu = [UIButton buttonWithType:UIButtonTypeCustom];
    AnNiu.frame = CGRectMake(278 * ratioW, 252 * ratioH, 159 * ratioW, 65 * ratioH);
    [AnNiu addTarget:self action:@selector(KaiShiYouXi:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:AnNiu];
}

- (IBAction)KaiShiYouXi:(id)sender {
    YouXiViewController *YouXiVC = [YouXiViewController new];
    [self presentViewController:YouXiVC animated:YES completion:nil];
}

@end
