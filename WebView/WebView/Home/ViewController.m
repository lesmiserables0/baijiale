//
//  ViewController.m
//  WebView
//
//  Created by iMac on 2018/1/24.
//  Copyright © 2018年 潴潴侠. All rights reserved.
//

#import "ViewController.h"

#import "ADWebViewController.h"//UIWebView
#import "ADWKWebViewController.h"//WKWebView

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chooseImageView_1.highlighted = YES;
    
}


//选择 浏览器控件类型
- (IBAction)chooseWebType:(UIButton *)sender {
    self.chooseImageView_1.highlighted = NO;
    self.chooseImageView_2.highlighted = NO;
    if (sender.tag == 200) {
        self.chooseImageView_1.highlighted = YES;
    }else{
        self.chooseImageView_2.highlighted = YES;
    }
}


//条状到浏览器
- (IBAction)goWeb:(id)sender {
    
    if (self.textField.text.length<5){ self.textField.text = @"http://amjsc88.com"; }
    
    if (self.chooseImageView_1.highlighted) {
        ADWebViewController *VC = [ADWebViewController initWithURL:self.textField.text];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        ADWKWebViewController *VC = [ADWKWebViewController initWithURL:self.textField.text];
        [self.navigationController pushViewController:VC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
