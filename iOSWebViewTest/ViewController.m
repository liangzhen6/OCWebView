//
//  ViewController.m
//  iOSWebViewTest
//
//  Created by shenzhenshihua on 2018/4/27.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)JSContext *jsContext;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL * URL = [NSURL fileURLWithPath:path];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
//    request.allHTTPHeaderFields = @{@"usename":@"liang",@"token":@"666"};
    [request addValue:@"666" forHTTPHeaderField:@"token"];
    
    [_webView loadRequest:request];
    // Do any additional setup after loading the view, typically from a nib.
}
/*
 android webview 资料
 https://blog.csdn.net/hello_1s/article/details/52817444
 iOS webviwe 资料
 https://blog.csdn.net/ioschenlu/article/details/51942349
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *jsContext = [webView     valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _jsContext = jsContext;
    
    JSValue *jsValue = [jsContext evaluateScript:@"showAppAlertMsg"];
    [jsValue callWithArguments:@[@"这是app本地交互文案"]];
    // 也可以通过下标的方式获取到方法
    self.jsContext[@"appWebViewBack"] = ^(){
        NSLog(@"点我返回");
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
