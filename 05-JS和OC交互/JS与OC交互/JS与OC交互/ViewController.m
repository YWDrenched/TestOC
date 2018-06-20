//
//  ViewController.m
//  JS与OC交互
//
//  Created by cyw on 2017/5/10.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) WebViewJavascriptBridge *bridge;

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatWebView];
    
    
    
    
    
}


-(void) creatWebView{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400)];
    
    NSString *str = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
    
    NSString *htmlStr = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    
    NSURL *url = [NSURL URLWithString:htmlStr];
    
    [self.webView loadHTMLString:htmlStr baseURL:url];
    
    [self.view addSubview:self.webView];
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
//    [self.bridge setWebViewDelegate:self];
    
    //    JS调用OC的方法
    [self.bridge registerHandler:@"registerHandle" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"datattatatatat=== %@",[NSString stringWithFormat:@"%@",data]);
        
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:nil message:@"js调用oc的按钮提示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        aler.tag = 100;
        
        [aler show];
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
