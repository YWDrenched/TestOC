//
//  ViewController.m
//  ScanTest
//
//  Created by Aotu on 16/6/28.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ViewController.h"

#import "SubLBXScanViewController.h"
#import "LBXScanWrapper.h"


@interface ViewController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *webAddressTextfiled;
@property (weak, nonatomic) IBOutlet UIView *erWeiCodeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";

  
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[UITextField class]]) {
            UITextField *t = (UITextField*)v;
            [t resignFirstResponder];
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//扫一扫按钮
- (IBAction)saoYiSaoBtn:(id)sender {

    [self createZFBStyle];
    
}
//生成二维码按钮
- (IBAction)getCodeBtn:(id)sender {
    if (_webAddressTextfiled.text.length>0) {
        UIImage *img = [LBXScanWrapper createQRWithString:_webAddressTextfiled.text size:_erWeiCodeView.frame.size];
        _imageView.image = [LBXScanWrapper imageBlackToTransparent:img withRed:0.0f andGreen:0.0f andBlue:0.0f];

       
    }
}

#pragma mark - 仿支付宝扫码(style设置)
-(void)createZFBStyle{
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc] init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480) {
        //如果是3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    
    style.alpa_notRecoginitonArea = 0.6;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    style.animationImage = imgFullNet;
    [self openScanVCWithStyle:style];
    
}
#pragma  mark - 跳转扫码
- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    vc.isOpenInterestRect = YES;//区域识别效果
    
    vc.isQQSimulator = YES; //qq功能预写了一些功能按钮 (相册/闪光/二维码按钮)
    vc.isVideoZoom = YES; //增加缩放功能
    [self.navigationController pushViewController:vc animated:YES];
}

@end
