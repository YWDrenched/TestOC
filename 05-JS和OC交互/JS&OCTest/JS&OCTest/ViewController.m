//
//  ViewController.m
//  JS&OCTest
//
//  Created by 陈友文 on 2018/1/9.
//  Copyright © 2018年 陈友文. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WebViewJavascriptBridge.h"
#import <AVFoundation/AVFoundation.h>
#import "CameraViewController.h"

#define kWeakSelf __weak typeof(self)weakSelf = self

@interface ViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIWebView *webView;
@property WebViewJavascriptBridge *bridge;
@property (nonatomic,strong)NSUserDefaults *userDefaults;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanCacheAndCookie) name:UIApplicationWillResignActiveNotification object:nil];
    if (self.bridge) {return;}
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    [self loadExamplePage:webView];
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [self.bridge setWebViewDelegate:self];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"username"] && [userDefaults objectForKey:@"password"]) {
        [self.bridge callHandler:@"getUserInfo" data:@{@"username":[userDefaults objectForKey:@"username"],
                                                       @"password":[userDefaults objectForKey:@"password"]}];
    }else{
        [self.bridge registerHandler:@"catchUserInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"JS返回的数据:%@",data);
            if (data != NULL) {
                
                [userDefaults setObject:data[@"username"] forKey:@"username"];
                [userDefaults setObject:data[@"password"] forKey:@"password"];
            }
        }];
    }
   
   
    kWeakSelf;
    [self.bridge registerHandler:@"openCamera" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        if ([data[@"camera"] isEqual:@1]) {
            [weakSelf openCanmer];
        }
        
        NSLog(@" data %@",data);
        NSLog(@"openCamera :%@",responseCallback);
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
 
}

-(void)openCanmer{
    CameraViewController *cameraVC = [[CameraViewController alloc]init];
    cameraVC.block = ^(NSString *result) {
        [self.bridge callHandler:@"returnMessage" data:result];
    };
    [self presentViewController:cameraVC animated:YES completion:nil];
}


- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    //    [self creatView];
}

- (void)loadExamplePage:(UIWebView*)webView {
    //    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
//    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
//    [webView loadHTMLString:appHtml baseURL:baseURL];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://test02.sensor668.com:8080/wechat"]]];
}


@end
