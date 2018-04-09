#import "ADWKWebViewController.h"
#import "Reachability.h"

@interface ADWKWebViewController ()<WKNavigationDelegate,UIAlertViewDelegate>

@property (nonatomic) Reachability *hostReachability;//域名检查
@property (nonatomic) Reachability *internetReachability;//网络检查

@property (assign, nonatomic) BOOL isLoadFinish;//是否加载完成
@property (assign, nonatomic) BOOL isLandscape;//是否横屏

@property (strong, nonatomic) WKWebView *wkwebView;//网页
@property (weak, nonatomic) IBOutlet UIWebView *webView;//背景网页 没有加载url的，是用来确定 wkwebView 的 frame，
@property (retain, nonatomic) IBOutlet UIView *noNetView;//无网络提示 视图

@property (strong,nonatomic) UIAlertView *alertView;//退出 确认 警告框
@property (retain, nonatomic) IBOutlet UIView *bottomBarView;//底部导航栏视图
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;//活动指示器

@end




@implementation ADWKWebViewController

+(instancetype)initWithURL:(NSString *)urlString{
    ADWKWebViewController *adWKWebViewController = [[ADWKWebViewController alloc]init];
    adWKWebViewController.webViewURL = urlString;
    return adWKWebViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doRotateAction:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    

    self.wkwebView = [[WKWebView alloc] initWithFrame:self.webView.frame];
    self.wkwebView.navigationDelegate = self;
    [self.wkwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]]];
    [self.view addSubview:self.wkwebView];
    
    
    self.noNetView.hidden = YES;
    [self.view addSubview:self.noNetView];
    
    [self listenNetWorkingStatus]; //监听网络是否可用
    
    [self.view addSubview:self.activityIndicatorView];
}

//更新 UI 布局
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.isLandscape) {
        self.wkwebView.frame = self.view.bounds;
    }else{
        self.wkwebView.frame = self.webView.frame;
    }
}



#pragma mark - ------ 网页代理方法 ------

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.activityIndicatorView.hidden = NO;
    self.isLoadFinish = NO;
   
    //是否 跳转到 别的 应用
    [self openOtherAppWithWKWebView:webView];
}

//只管 固定的几个 跳转
-(void)openSomeTheAppWithWKWebView:(WKWebView *)webView{
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]//Appstore
        ||[webView.URL.absoluteString hasPrefix:@"itms-services://"]//iOS 网页安装协议
        ||[webView.URL.absoluteString hasPrefix:@"weixin://"]//微信跳转
        ||[webView.URL.absoluteString hasPrefix:@"mqq://"])//QQ跳转
    {
        [[UIApplication sharedApplication] openURL:webView.URL];
    }
}


//是否 跳转到 别的 应用
-(void)openOtherAppWithWKWebView:(WKWebView *)webView{
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]//Appstore
        ||[webView.URL.absoluteString hasPrefix:@"itms-services://"])//iOS 网页安装协议
    {
        [[UIApplication sharedApplication] openURL:webView.URL];
    }else{
        //如果不是 http 链接，判断 是否 可以进行 白名单跳转
        if (![webView.URL.absoluteString hasPrefix:@"http"]) {
            //获取 添加的 白名单
            NSArray *whitelist = [[[NSBundle mainBundle] infoDictionary] objectForKey : @"LSApplicationQueriesSchemes"];
            //遍历 查询 白名单
            for (NSString * whiteName in whitelist) {
                //白名单 跳转 规则
                NSString *rulesString = [NSString stringWithFormat:@"%@://",whiteName];
                //判断 链接前缀 是否在 白名单 范围内
                if ([webView.URL.absoluteString hasPrefix:rulesString]){
                    [[UIApplication sharedApplication] openURL:webView.URL];
                }
            }
        }
    }
}


// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.activityIndicatorView.hidden = YES;
    self.isLoadFinish = YES;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    self.activityIndicatorView.hidden = YES;
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}




#pragma mark - ------ 底部 导航栏 ------

//底部 导航栏 按钮 点击事件
- (IBAction)goingBT:(UIButton *)sender {
    if (sender.tag ==200) {
        [self.wkwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]]];
    }else if (sender.tag ==201) {
        if ([self.wkwebView canGoBack]) {[self.wkwebView goBack]; }
    }else if (sender.tag ==202) {
        if ([self.wkwebView canGoForward]) {[self.wkwebView goForward];}
    }else if (sender.tag ==203) {
        [self.wkwebView reloadFromOrigin];
    }else if (sender.tag ==204) {
        self.alertView = [[UIAlertView alloc]initWithTitle:@"是否退出？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [self.alertView show];
    }
}

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
    
    [self.wkwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]]];
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
            if (!self.isLoadFinish) {
                self.noNetView.hidden = NO;
            }
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
        self.wkwebView.frame = self.webView.frame;
        self.bottomBarView.hidden = NO;
        self.isLandscape = NO;
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
               || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        NSLog(@"横屏");
        self.wkwebView.frame = self.view.bounds;
        self.bottomBarView.hidden = YES;
        self.isLandscape = YES;
    }
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.wkwebView stopLoading];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

