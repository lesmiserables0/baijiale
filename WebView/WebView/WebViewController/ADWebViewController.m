#import "ADWebViewController.h"
#import "Reachability.h"

@interface ADWebViewController ()<UIWebViewDelegate,UIAlertViewDelegate>

@property (nonatomic) Reachability *hostReachability;//域名检查
@property (nonatomic) Reachability *internetReachability;//网络检查

@property (assign, nonatomic) BOOL isLoadFinish;//是否加载完成
@property (assign, nonatomic) BOOL isLandscape;//是否横屏

@property (weak, nonatomic) IBOutlet UIWebView *webView;//主体网页
@property (retain, nonatomic) IBOutlet UIView *noNetView;//无网络提示 视图

@property (strong,nonatomic) UIAlertView *alertView;//退出 确认 警告框
@property (retain, nonatomic) IBOutlet UIView *bottomBarView;//底部导航栏视图
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;//活动指示器

@end

@implementation ADWebViewController


+(instancetype)initWithURL:(NSString *)urlString{
    ADWebViewController *adWKWebViewController = [[ADWebViewController alloc]init];
    adWKWebViewController.webViewURL = urlString;
    return adWKWebViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doRotateAction:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
 
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]]];
    [self.view addSubview:self.webView];
    
    
    self.noNetView.hidden = YES;
    [self.view addSubview:self.noNetView];
    
    [self listenNetWorkingStatus]; //监听网络是否可用
    
    [self.view addSubview:self.activityIndicatorView];
}


//更新 UI 布局
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.isLandscape) {
        self.webView.frame = self.view.bounds;
    }else{
        self.webView.frame = self.webView.frame;
    }
}



#pragma mark - ------ 网页代理方法 ------

//是否允许加载网页
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

// 网页开始加载时调用
- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.activityIndicatorView.hidden = NO;
    self.isLoadFinish = NO;
}

// 网页加载完成之后调用
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.activityIndicatorView.hidden = YES;
    self.noNetView.hidden = YES;
    self.isLoadFinish = YES;
}

// 网页加载失败时调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (!self.noNetView.hidden) {
        self.noNetView.hidden = YES;
    }
    self.activityIndicatorView.hidden = YES;
}



#pragma mark - ------ 底部 导航栏 ------

//底部 导航栏 按钮 点击事件
- (IBAction)goingBT:(UIButton *)sender {
    if (sender.tag ==200) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]]];
    }else if (sender.tag ==201) {
        if ([self.webView canGoBack]) {[self.webView goBack]; }
    }else if (sender.tag ==202) {
        if ([self.webView canGoForward]) {[self.webView goForward];}
    }else if (sender.tag ==203) {
        [self.webView reload];
    }else if (sender.tag ==204) {
        self.alertView = [[UIAlertView alloc]initWithTitle:@"是否退出？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [self.alertView show];
    }
}

//退出 确认
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        exit(0);
    }
}




#pragma mark - ------ 网络监听 ------

//无网络 重试 按钮 点击事件
- (IBAction)againBTAction:(UIButton *)sender {
    self.activityIndicatorView.hidden = NO;
    self.noNetView.hidden = YES;
    self.isLoadFinish = NO;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]]];
    [self performSelector:@selector(checkNetwork) withObject:nil afterDelay:3];
}

//检查网络
-(void)checkNetwork{
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
}


//监听 网络状态
-(void)listenNetWorkingStatus{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    // 设置网络检测的站点
    NSString *remoteHostName = @"www.apple.com";
    
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}

//网络状态 通知事件
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    [self updateInterfaceWithReachability:curReach];
}

//当前网络类型
- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
        case 0://无网络
            //网页加载完成，突然断网，不显示 无网络提醒视图
            if (!self.isLoadFinish) { self.noNetView.hidden = NO; }
            break;
            
        case 1://WIFI
            NSLog(@"ReachableViaWiFi----WIFI");
            break;
            
        case 2://蜂窝网络
            NSLog(@"ReachableViaWWAN----蜂窝网络");
            break;
            
        default:
            break;
    }
    
}



#pragma mark - ------ 横竖屏相关 ------

//支持旋转
-(BOOL)shouldAutorotate{
    return YES;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

//监听屏幕 横竖屏
- (void)doRotateAction:(NSNotification *)notification {
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        self.webView.frame = self.webView.frame;
        self.bottomBarView.hidden = NO;
        self.isLandscape = NO;
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
               || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        NSLog(@"横屏");
        self.webView.frame = self.view.bounds;
        self.bottomBarView.hidden = YES;
        self.isLandscape = YES;
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.webView stopLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

